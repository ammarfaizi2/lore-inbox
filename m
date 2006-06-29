Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751831AbWF2AHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbWF2AHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWF2AHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:07:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:49637 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751829AbWF2AHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:07:31 -0400
Subject: Re: radeonfb: corrupted screen on bootup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200606282118.27750.mb@bu3sch.de>
References: <200606282118.27750.mb@bu3sch.de>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 10:07:11 +1000
Message-Id: <1151539632.4044.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 21:18 +0200, Michael Buesch wrote:
> Hi,
> 
> I have a weird error with my PowerBook G4, which
> has a radeon card. I am using radeonfb.
> After bootup, the screen sometimes looks like it is melting.
> I made a video to show you what is going on:
> http://bu3sch.de/misc/after_boot.avi  (6.1 MB)
> 
> It does only happen sometimes. I could not find
> a way to reproduce it.
> If I start X after boot with a melting screen, X is also
> melting:
> http://bu3sch.de/misc/after_x_switch.avi  (6.6 MB)
> 
> But here comes the interresting part:
> If I switch back into the console, the screen becomes
> normal again and I can continue to work as usual.
> 
> I am suspecting some initialization routine bug.
> It never happened when booting into OSX.

It's a known issue. There is some black magic with the flat panel that
we don't have quite right... If I tweak the timings to get it right on
one machine (well, apparently, difficult to make sure if the problem
happens once every week), it will probably break anohter. I've been
trying to get ATI to tell me what should be done but to no avail so
far...

It's basically that sometimes, the LCD doesn't "catch" the signal.
Usually just turning it off/on fixes it (which is what a mode change
does, sometimes a console switch, or a blank/unblank... or turn the
backlight all the way down to blank the screen and back up).

Ben.


