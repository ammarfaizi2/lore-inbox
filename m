Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTLCKgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 05:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTLCKgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 05:36:39 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:12720 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264540AbTLCKgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 05:36:37 -0500
Date: Wed, 3 Dec 2003 11:36:34 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031203103634.GA6449@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031202204656.GZ18176@lenin.nu> <Pine.LNX.4.33.0312030846390.9365-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0312030846390.9365-100000@wombat.indigo.net.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Dec 2003, Ian Kent wrote:

> Sorry, this is probably not the right place for this discussion but I feel
> strongly enough about it to pursue it anyway.
...
> 2) The supportability of using autofs v4 in RedHats' commercial product.
> 
> This issue can't be fixed by simply adding this patch to the kernel.
> 
> There is a userspace daemon which is also not included in the RedHat
> product. RedHat have no reason to trust my code for their commercial
> customers and their commercial customers need the sort of changes I am
> trying to make.
> 
> So the real question is "what can I do to enable this to be used, without
> customer penalty, in RedHats' commercial product".
> 
> I have a kernel module kit that allows the module to be used without
> wiping out the original (and back out the change if needed). I think I can
> turn this into an RPM if that would help.
> 
> I'm about to make 4.1.0 a release. It's not perfect but it is certainly an
> improvement on previous autofs v4 versions. A src RPM will be produced as
> well.
> 
> Anyone have any suggestions on how to solve this problem?

If people are chary about replacing autofs4 in its current shape with
some of the problems it has (like, if the process gets killed with busy
autofs4-mounted file systems), it's difficult to get the system back in
a working shape without rebooting.

Distros seeems to be using autofs3 all over the map, but I've found the
"use program" so very useful because it allows for the /etc/auto.net
stuff which is a great help in administration. To my surprise, I figured
that the FreeBSD amd(8) stuff (that I dropped a while ago because it was
inconvenient to administer and incompatible with Solaris) is capable of
doing these /net mounts as well, so I might just use a Makefile and go
amd again if Linux' autofs4 can't be made to fly.

It's fragile currently, and if there are changes that make the beast
solid, I'm all for it, and the whole discussion can be killed right here
because it's a "bugfix" in that case. After all, autofs4 is a
pre-something stuff and going "gold" is certainly a fix.

If there are optional features, well, they might have to be split out to
a separate patch or #ifdef'd out - but I direly hope that autofs4 will
improve.
