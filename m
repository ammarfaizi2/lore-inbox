Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbTFRMME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 08:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbTFRMME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 08:12:04 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:2970 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S265178AbTFRMMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 08:12:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.23126.341995.691398@gargle.gargle.HOWL>
Date: Wed, 18 Jun 2003 14:25:58 +0200
From: mikpe@csd.uu.se
To: linux-kernel@vger.kernel.org
Subject: Cardbus/3c575 hotplugging dysfunctional in 2.5.72
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.72, my laptop with a Cardbus 3c575 NIC and RH9 user-space
(hotplug-2002_04_01-17 and kernel-pcmcia-cs-3.1.31-13) no longer
brings eth0 up automatically on insertion of the NIC. cardmgr
_is_ running. A manual ifup eth0 brings it up however.

This all worked fine up to 2.5.71.

The only relevant diff in the dmesg logs is:
--- dmesg-2.5.71	2003-06-18 14:17:44.000000000 +0200
+++ dmesg-2.5.72	2003-06-18 14:17:52.000000000 +0200
@@ -3,4 +3,3 @@
 05:00.0: 3Com PCI 3c575 Boomerang CardBus at 0x1800. Vers LK1.1.19
 PCI: Setting latency timer of device 05:00.0 to 64
 eth0: Dropping NETIF_F_SG since no checksum feature.
-eth0: Setting full-duplex based on MII #0 link partner capability of 01e1.

2.5.72 discovers the device, the 100Mbps link led on the NIC
lights up, but nothing further happens.

Any ideas?

/Mikael
