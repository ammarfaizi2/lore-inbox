Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbUCNRCx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 12:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbUCNRCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 12:02:52 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:32389 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261444AbUCNRCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 12:02:51 -0500
To: <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com
Subject: Tulip 21040 hangs with ifconfig promisc
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 14 Mar 2004 17:54:38 +0100
Message-ID: <m3wu5nnzch.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is:
Linux version ~2.6.4 (Red Hat Linux 3.3.2-1)) SMP kernel, UNI CPU.
(as of Mar 12 in bkcvs/linux-2.5/).

Acorp VIA77 mobo - AMD-K6 3D 500 MHz + VIA MVP3 chipset.
SMC EtherPower^2 (dual DECchip 21040 + 21050 PCI-PCI bridge)
All running out of ramdisk.

Doing "ifconfig eth0 promisc" kills the ethernet. Interrupts are gone,
nothing in dmesg. -promisc nor ifconfig down/up doesn't fix it,
only driver rmmod/insmod does.

de2104x PCI Ethernet driver v0.6 (Sep 1, 2003)
eth0: 21040 at 0xca81e000, 00:00:c0:d8:66:e0, IRQ 11
eth1: 21040 at 0xca820000, 00:00:c0:16:1b:c0, IRQ 12
eth0: enabling interface
eth0: set link 10baseT-HD
eth0:    mode 0xfffc0040, sia 0xffffffc4,0xffff8f01,0xffffffff,0xffff0000
eth0:    set mode 0xfffc0000, set sia 0x8f01,0xffff,0x0
eth0: link up, media 10baseT-HD
device eth0 entered promiscuous mode

Any idea?
-- 
Krzysztof Halasa, B*FH
