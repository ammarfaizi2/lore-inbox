Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271235AbTHNWR3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 18:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271276AbTHNWR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 18:17:29 -0400
Received: from ol.freeshell.org ([192.94.73.20]:52962 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S271235AbTHNWR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 18:17:27 -0400
Date: Thu, 14 Aug 2003 22:17:25 +0000 (UTC)
From: Ognen Duzlevski <maketo@sdf.lonestar.org>
To: linux-kernel@vger.kernel.org
Subject: thinkpad / d-link 690TXD pcmcia problem
Message-ID: <Pine.NEB.4.33.0308142215400.22210-100000@sdf.lonestar.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I don't know if this is the right place to ask this question but I tried
Google and irc and couldn't ind an answer. I have an old Thinkpad 760EL
and a 8139 based d-link 690txd ethernet card which just wont work properly
under 2.4.18.

The card gets recognized, however in the process the following is printed
out:

PCI: No IRQ known for interrupt pin A of device 00:02.0
PCI: No IRQ known for interrupt pin B of device 00:02.1
Yenta IRQ list 06b8, PCI irq0
Socket status: 30000020
Yenta IRQ list 06b8, PCI irq0
Socket status: 30000006
cs: cb_alloc(bus 1): vendor 0x1186, device 0x1340
PCI: Enabling device 01:00.0 (0000 -> 0003)
PCI: No IRQ known for interrupt pin A of device 01:00.0
cs: IO port probe 0x0c00-0x0cff: clean
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x268-0x26f
0x330-0x337 0x388-0x38f 0x3b8-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: excluding 0xa68-0xa6f
8139too Fast Ethernet driver 0.9.25
PCI: No IRQ known for interrupt pin A device 01:00.0
PCI: Setting latency timer of device 01:00.0 to 64
divert: allocating divert_blk for eth0
eth0: D-Link DFE-690TXD (RealTek RTL8139) at 0xc5073000,
00:40:05:0b:8a:66, IRQ 0
eth0: Identified 8139 chip type 'RTL-8139C'

All looks more or less fine and dandy, however there is no network
connectivity. If I do ifdown eth0 and then ifup eth0, I get:

SIOCSIFFLAGS: Device of resource busy

After a slight wait, ifup returns with the message "failed" (I am using
dhcp).

Any ideas?

Thanks (and please don't kill me for posting to this mailing list, I know
it is for discussion of kernel development issues).

Ognen


