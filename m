Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264573AbTLCOtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 09:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264574AbTLCOtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 09:49:46 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:452 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S264573AbTLCOtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 09:49:45 -0500
Date: Wed, 3 Dec 2003 22:49:51 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Matthias Andree <matthias.andree@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
In-Reply-To: <20031203103634.GA6449@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.44.0312032234520.2968-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003, Matthias Andree wrote:

> If people are chary about replacing autofs4 in its current shape with
> some of the problems it has (like, if the process gets killed with busy
> autofs4-mounted file systems), it's difficult to get the system back in
> a working shape without rebooting.

Yes. That is sometimes the case. I have improved things somewhat though.

> 
> Distros seeems to be using autofs3 all over the map, but I've found the
> "use program" so very useful because it allows for the /etc/auto.net
> stuff which is a great help in administration. To my surprise, I figured
> that the FreeBSD amd(8) stuff (that I dropped a while ago because it was
> inconvenient to administer and incompatible with Solaris) is capable of
> doing these /net mounts as well, so I might just use a Makefile and go
> amd again if Linux' autofs4 can't be made to fly.

Yes. autofs v3 is quite a solid product but doesn't understand direct 
mounts. amd is a good product as well. In the end I decided to start work 
on autofs v4 because of the syntax differences to our Sun environment as 
well and the fact that it wasn't being maintained.

> 
> It's fragile currently, and if there are changes that make the beast
> solid, I'm all for it, and the whole discussion can be killed right here
> because it's a "bugfix" in that case. After all, autofs4 is a
> pre-something stuff and going "gold" is certainly a fix.

And that would be 4.1.0-beta3 you are talking about right?
Perhaps you could tell me about your problems and I'll put them on my 
growing todo list for 4.1.1.

> 
> If there are optional features, well, they might have to be split out to
> a separate patch or #ifdef'd out - but I direly hope that autofs4 will
> improve.

The kernel module is only needed to provide support for browsable 
directories (I coined it 'ghost'ing directories in autofs v4). The 
difficulty is many people don't like, and should not have 
to, patch the kernel to get the full functionality of the daemon.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

