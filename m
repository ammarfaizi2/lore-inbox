Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVGKTfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVGKTfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVGKTfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:35:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30849 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261656AbVGKTfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:35:06 -0400
Date: Mon, 11 Jul 2005 21:34:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: arm: how to operate leds on zaurus?
Message-ID: <20050711193454.GA2210@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2.6.12-rc5 (and newer) does not boot on sharp zaurus sl-5500. It
blinks with green led, fast; what does it mean? I'd like to verify if
it at least reaches .c code in setup.c. I inserted this code at
begining of setup.c:674...

#define locomo_writel(val,addr) ({ *(volatile u16 *)(addr) = (val); })
#define LOCOMO_LPT_TOFH         0x80
#define LOCOMO_LED              0xe8
#define LOCOMO_LPT0             0x00

      locomo_writel(LOCOMO_LPT_TOFH, LOCOMO_LPT0 + LOCOMO_LED);

...but that does not seem to do a trick -- it only breaks the boot :-(
(do I need to add some kind of IO_BASE?).
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
