Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUDQDHa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 23:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUDQDHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 23:07:30 -0400
Received: from main.gmane.org ([80.91.224.249]:16569 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262389AbUDQDH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 23:07:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: [2.6.5] Oversized FB logos
Date: Fri, 16 Apr 2004 20:07:24 -0700
Message-ID: <pan.2004.04.17.03.07.22.362894@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-186-145.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm coming up with a grandma-proof laptop so I made a 800x580 PPM boot
logo and added it into my 2.6 kernel source. The machine does boot using
the image, HOWEVER, the first 11 lines of kernel messages after switching
to FB mode appear on top of the logo.

Console: switching to colour frame buffer device 100x37
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M

As expected, though, the first line of kernel messages prints;
the console won't function without at least one line anyway.

This renders the concept of the friendly logo to prevent grandma from
bugging out from all the kernel messages pretty useless.

Note that I'd be using bootsplash for this but vesafb only works up to
8bit color and bootsplash requires 16bit color.

Are boot logos in any way supported in this fashion? I'm tempted to just
nuke the emit_log_char call in printk.c, which I think might serve my
purpose temporarily...

Any hints/help provided would be highly appreciated. Thanks

-- 
Joshua Kwan


