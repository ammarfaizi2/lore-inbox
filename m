Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268522AbTANCfv>; Mon, 13 Jan 2003 21:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268523AbTANCfv>; Mon, 13 Jan 2003 21:35:51 -0500
Received: from pD9E6AF2E.dip.t-dialin.net ([217.230.175.46]:2688 "EHLO fefe.de")
	by vger.kernel.org with ESMTP id <S268522AbTANCfu>;
	Mon, 13 Jan 2003 21:35:50 -0500
Date: Tue, 14 Jan 2003 03:44:35 +0100
From: Felix von Leitner <felix-linuxkernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: usb broken in 2.5?
Message-ID: <20030114024435.GA1293@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.57 USB does not work.  The mainboard devices are still detected,
and apparently also the USB devices are found, but then the USB code
tries to remap them and fails.  It tries again with 1.5 Mb/s and fails
again.

> usb_control/bulk_msg: timeout
> usb.c: USB device not accepting new address=3 (error=-110)

The same problem also happens with the WOLK kernel patch, which appears
to also include a newer version of the USB code.

This is an excerpt from /proc/pci:

  Bus  0, device  16, function  0:
    USB Controller: VIA Technologies, Inc. USB (rev 128).
      IRQ 21.
      Master Capable.  Latency=32.
      I/O at 0xdc00 [0xdc1f].
  Bus  0, device  16, function  1:
    USB Controller: VIA Technologies, Inc. USB (#2) (rev 128).
      IRQ 21.
      Master Capable.  Latency=32.
      I/O at 0xe000 [0xe01f].
  Bus  0, device  16, function  2:
    USB Controller: VIA Technologies, Inc. USB (#3) (rev 128).
      IRQ 21.
      Master Capable.  Latency=32.
      I/O at 0xe400 [0xe41f].
  Bus  0, device  16, function  3:
    USB Controller: VIA Technologies, Inc. USB 2.0 (rev 130).
      IRQ 19.
      Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0xe6033000 [0xe60330ff].

Any ideas?  On 2.5 and WOLK the kernel also says that no IRQ is know and
that it is using ACPI to route the IRQs.

Felix
