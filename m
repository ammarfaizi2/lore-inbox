Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTI2Pun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263634AbTI2Pun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:50:43 -0400
Received: from main.gmane.org ([80.91.224.249]:28812 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263632AbTI2Pum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:50:42 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet.2117@andreas-s.net>
Subject: 8139too & APIC incompatibility (2.6.0-test6-mm1, 2.4.20)
Date: Mon, 29 Sep 2003 15:47:29 +0000 (UTC)
Message-ID: <slrnbngl0o.4e0.usenet.2117@home.andreas-s.net>
X-Complaints-To: usenet@sea.gmane.org
X-TCPA-ist-scheisse: yes
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When APIC is activated, the following messages appear in syslog from
time to time:                                                                   
                                                                                
kernel: NETDEV WATCHDOG: eth1: transmit timed out
kernel: eth1: Tx queue start entry 4  dirty entry 0.
kernel: eth1:  Tx descriptor 0 is 00002000. (queue head)
kernel: eth1:  Tx descriptor 1 is 00002000.
kernel: eth1:  Tx descriptor 2 is 00002000.
kernel: eth1:  Tx descriptor 3 is 00002000.
kernel: eth1: link up, 100Mbps, full-duplex, lpa 0x45E1

After this has happened the first time, the card fails to send or
receive any more packages.

The problem exists in both tested Kernel versions (2.6.0-test6-mm1 and
2.4.20).

lspci -v:

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at d400 [size=256]
        Memory at cfffde00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at cffe0000 [disabled] [size=64K]
        Capabilities: [50] Power Management version 2


