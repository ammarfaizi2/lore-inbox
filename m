Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266577AbUF3KZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266577AbUF3KZw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 06:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUF3KZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 06:25:52 -0400
Received: from math.ut.ee ([193.40.5.125]:42210 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S266577AbUF3KZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 06:25:50 -0400
Date: Wed, 30 Jun 2004 13:25:48 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: irq 11: nobody cared? (usb?)
Message-ID: <Pine.GSO.4.44.0406301318300.15010-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got this from 2.6.7 + BK as of 20040629.

irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<e09960b0>] (usb_hcd_irq+0x0/0x60 [usbcore])
[<c02684b0>] (e100_intr+0x0/0x110)
Disabling IRQ #11

First boot of the same kernel ran fine for a day, then USB mouse hung
(replug cured it). Then on next reboot it disabled irq 11 and e100 and
one usb port along with it (mouse is in another usb port and worked
fine). I rebooted it again and now it's working fine again.

I looked into the logs of the first accident and it's mostly the same (a
couple of X restarts to check whether it revives the mouse):

irq 11: nobody cared!
Stack pointer is garbage, not printing tracehandlers:
[__crc_xprt_create_proto+526825/4343765] (usb_hcd_irq+0x0/0x60 [usbcore])
[e100_intr+0/272] (e100_intr+0x0/0x110)
Disabling IRQ #11
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:03:00.0 into 4x mode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:03:00.0 into 4x mode
usb 1-2: USB disconnect, address 2
usb 2-2: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1f.4-2

-- 
Meelis Roos (mroos@linux.ee)

