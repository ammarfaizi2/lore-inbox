Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbUL1RXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUL1RXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 12:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbUL1RXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 12:23:53 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:3713 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S261193AbUL1RXv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 12:23:51 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Current saa7134 driver breaks KNC One Tv-Station DVR (card=24)
Date: Tue, 28 Dec 2004 18:21:53 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412281821.53919.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to modprobe saa7134 with this card results in a hanging modprobe 
process.

dmesg gets:
saa7130/34: v4l2 driver version 0.2.12 loaded
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 17 (level, low) -> IRQ 177
saa7134[0]: found at 0000:00:06.0, rev: 1, irq: 177, latency: 64, mmio: 
0xdfff9c00
saa7134[0]: subsystem: 1894:a006, board: KNC One TV-Station DVR 
[card=24,autodetected]
saa7134[0]: board init: gpio is 830000
saa7134[0]: i2c eeprom 00: 94 18 06 a0 06 80 00 01 00 00 00 00 00 00 01 00
saa7134[0]: i2c eeprom 10: 00 ff 86 0e ff 20 ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 20: 01 40 01 02 02 03 01 03 06 ff 01 df ff ff ff ff
saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
tuner: chip found at addr 0xc0 i2c-bus saa7134[0]
tuner: type set to 38 (Philips PAL/SECAM multi (FM1216ME MK3)) by saa7134[0]
tda9885/6/7: chip found @ 0x86
saa7134[0]/irq[10,-133081]: r=0x20 s=0x00 PE
saa7134[0]/irq: looping -- clearing PE (parity error!) enable bit

At that point, modprobe hangs; I can still use the box in other ttys, but [of 
course] the saa7134 card doesn't work.

This is reproducable at least with with 2.6.10-rc3-mm1, 2.6.10 and 2.6.10-ac1; 
the card used to work with earlier releases (I can't remember the last 
version that worked though, haven't used it for a while).

