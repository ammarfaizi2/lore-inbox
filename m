Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbTLATvV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 14:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTLATvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 14:51:21 -0500
Received: from vitelus.com ([64.81.243.207]:28874 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S263957AbTLATvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 14:51:17 -0500
Date: Mon, 1 Dec 2003 11:50:32 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: USB timeout with printer
Message-ID: <20031201195032.GC3385@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a HP LaserJet 1300 that I'm using over USB.

(drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 8 if 0 alt 1 proto 2 vid 0x03F0 pid 0x1017)

What's getting to be very annoying is that usually within a day after
printing something, I get the message usb 1-2: control timeout on
ep0in, and the printer needs to be power cycled. I get other weird
errors sometimes, like "drivers/usb/class/usblp.c: usblp0: error -110
reading printer status". I don't have any evidence that this is
Linux's fault, but it seems like a fairly likely possibility, at least
if you consider it an incompatibility with the printer rather than a bug.
My mouse uses USB and it works fine. I'm using an expensive Belkin
USB cable. The kernel version is 2.6.0-test9-bk17. Here is some
information on my USB controller:

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at c800 [size=32]
        Capabilities: <available only to root>

I think this may have started a few -test revisions ago, but I'm not
sure. I only purchased the printer fairly recently so it's not like I
can say that it's worked for years.
