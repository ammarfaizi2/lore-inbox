Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266701AbUGVQKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266701AbUGVQKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 12:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266702AbUGVQKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 12:10:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35533 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266701AbUGVQKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 12:10:48 -0400
Date: Thu, 22 Jul 2004 18:10:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: Video memory corruption during suspend
Message-ID: <20040722161047.GB15145@atrey.karlin.mff.cuni.cz>
References: <20040718225247.GA30971@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040718225247.GA30971@hell.org.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> My setup is:
> ASUS L3800C laptop, Radeon M7, i845 chipset, using DRI and radeonfb.
> 
> Note that this is not specific to the kernel used, as I've been seeing 
> similar corruption every now and then, most recently under 2.6.7 +
> ACPICA20040715 + swsusp2.0.0.100 (S3, S4), but also under 2.4 with S1 (but 
> not with S4/swsusp2).
> 
> I have a very simple script I use to suspend (i.e. basically echo $arg >
> /proc/acpi/sleep), which is usually started by acpid. Once the script is
> triggered (by pressing power / sleep button) and an X session is running, 
> various red and green patches appear on the screen (the background image
> and the tinted terminal emulator), followed by the VT switch the PM code
> does. After resume and subsequent VT switch by the PM code the corruption
> is still visible. The screen is properly restored by a manual VT switch.
> The corruption is clearly related to the existing background pixmap, as
> moving the windows does not change its pattern. Oddly enough, starting a GL
> app such as glxgears and moving it into and out of focus also properly
> restores the screen.

So what happens on 2.6.7 with swsusp1? Can you try vesafb (and fbdev
Xserver)?

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
