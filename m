Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWIITRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWIITRM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 15:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWIITRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 15:17:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57746 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964808AbWIITRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 15:17:11 -0400
Date: Sat, 9 Sep 2006 21:16:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Eric Sandall <eric@sandall.us>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Suspend to ram with 2.6 kernels
Message-ID: <20060909191654.GC2561@elf.ucw.cz>
References: <44FF8586.8090800@sandall.us> <20060907193333.GI8793@ucw.cz> <4501EDA5.5020406@sandall.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4501EDA5.5020406@sandall.us>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> I am having a problem with suspend-to-ram (have been for a while, but
> >> suspend-to-disk has been working fine for me, so I never really bothered
> >> to report it until now).
> >>
> >> Suspend-to-disk and resuming from it works fine (using `echo -n disk >
> >> /sys/power/state`).
> >>
> >> Suspend-to-ram works fine (using `echo -n mem > /sys/power/state`), but
> >> resuming does not. When I lift up the lid of my laptop (Dell Inspiron
> >> 5100) it seems to power back up (the power light changes from blinking
> >> to solid), but my screen stays blank and keys such as capslock do not
> >> toggle their LED.
> > 
> > See suspend.sf.net, use provided s2ram program.
> 
> Thanks! The key (mentioned in the documentation there) is to disable
> framebuffer (ATI video card). First time I've had suspend-to-RAM working
> on this machine. ;)

I'm glad it works.

> Though you may want to rename the /usr/sbin/suspend command to something
> other than 'suspend' as, at least for me, it is a shell command which
> puts the current shell in the background.
> 
> The HOWTO *does* mention:
> [Warning: some shells have "suspend" built in command, so specifing
> exact path like ./suspend is more important than usual.]
> 
> Though I still believe it'd be a good idea to pick a non-conflicting name.

We thought about it, but was too lazy to rename, and suspend should
probably be called from script/powersaved/something, anyway.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
