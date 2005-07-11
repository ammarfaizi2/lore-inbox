Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVGKT6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVGKT6B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVGKTwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:52:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42131 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262511AbVGKTvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:51:10 -0400
Date: Mon, 11 Jul 2005 21:50:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
Cc: Hamera Erik <HAMERAE@cs.felk.cvut.cz>
Subject: Re: arm: how to operate leds on zaurus?
Message-ID: <20050711195059.GA2219@elf.ucw.cz>
References: <20050711193454.GA2210@elf.ucw.cz> <20050711204534.C1540@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711204534.C1540@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 2.6.12-rc5 (and newer) does not boot on sharp zaurus sl-5500. It
> > blinks with green led, fast; what does it mean? I'd like to verify if
> > it at least reaches .c code in setup.c. I inserted this code at
> > begining of setup.c:674...
> > 
> > #define locomo_writel(val,addr) ({ *(volatile u16 *)(addr) = (val); })
> > #define LOCOMO_LPT_TOFH         0x80
> > #define LOCOMO_LED              0xe8
> > #define LOCOMO_LPT0             0x00
> > 
> >       locomo_writel(LOCOMO_LPT_TOFH, LOCOMO_LPT0 + LOCOMO_LED);
> > 
> > ...but that does not seem to do a trick -- it only breaks the boot :-(
> 
> Basically because you do not have access to IO during the early boot.
> The easiest debugging solution is to enable CONFIG_DEBUG_LL and
> throw a printascii(printk_buf) into printk.c, after vscnprintf.
> That might get you some boot messages through the serial port (if
> it's implemented it correctly.)

I'm afraid I do not have serial cable :-(. I'll try to get one [erik,
do you have one you don't need?], but zaurus has "little" nonstandard
connector.

Would code above work if executed later?
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
