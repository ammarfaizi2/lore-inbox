Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTEINSh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 09:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbTEINSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 09:18:37 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:56330 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263245AbTEINSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 09:18:36 -0400
Date: Fri, 9 May 2003 15:27:57 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Willy Tarreau <willy@w.ods.org>, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-ID: <20030509132757.GA16649@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509150207.3ff9cd64.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 03:02:07PM +0200, Stephan von Krawczynski wrote:
 
> I cannot say which version of the driver it was, the only thing I can tell you
> is that the archive was called aic79xx-linux-2.4-20030410-tar.gz.

That's really interesting, because I got the bug since around this version
(20030417 IIRC), and it locked up only on SMP, sometimes during boot, or
during heavy disk accesses caused by "updatedb" and "make -j dep". It's
fixed in 20030502 from http://people.freebsd.org/~gibbs/linux/SRC/

> I can't tell, basic problem in my setup is that it seems virtually impossible
> to bring some 100GB of data onto a streamer connected to the above aic. It
> crashes almost every day with a freeze and no oops or other message.

I had the same symptom which is very frustrating, I agree. I even had
difficulties to catch the NMI watchdog output which was often truncated.

> I am at the moment willing to await 2.4.21 and see, and if that does not solve it,

Well, would you at least agree to retest current version from the above URL ?
I find it a bit of a shame that the driver goes back in -rc stage.

Marcelo, do you have some information about the setup from the people who reported
hangs to you ? Perhaps we could even ask them to confirm that Justin's updated
driver fixes their problems ?

> This is a system in production and not particularly useful for debugging a lot
> and correspoding downtime.

I certainly can understand ;-)

Regards,
Willy

