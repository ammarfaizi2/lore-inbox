Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289909AbSAKJWq>; Fri, 11 Jan 2002 04:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289907AbSAKJWa>; Fri, 11 Jan 2002 04:22:30 -0500
Received: from [199.217.175.51] ([199.217.175.51]:39045 "EHLO
	core.federated.com") by vger.kernel.org with ESMTP
	id <S289905AbSAKJW0>; Fri, 11 Jan 2002 04:22:26 -0500
From: Jim Studt <jim@federated.com>
Message-Id: <200201110922.g0B9MDJl021581@core.federated.com>
Subject: Problem with ServerWorks CNB20LE and lost interrupts
To: linux-kernel@vger.kernel.org
Date: Fri, 11 Jan 2002 03:22:13 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL94 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately my most recent load of servers cam with ServerWorks
CNB20LE chipsets.  They work ok with linux, except when I use the PCI
slots, their interrupts get lost.

I am hoping someone is familiar with such a problem and might suggest
either a solution or at least a plan of attack.

I encountered it first with the ieee1394 ohci driver, but that is 
experimental, so I installed a 3c59x card instead and confirm the
problem there as well.

The 3c59x will receive exactly one packet after being ifconfig-ed up.
This packet's data will be corrupt.  It gets turned to zeros after 4-8 bytes
or so of data.  No more packets will be received until I "ifconfig down"
and back up.

The machines are dual processor boxes with a single processor installed.
I have tried many kernels with no appreciable difference, 2.4.17 is typical.

All of the devices on the primary bus work correctly, it is just the
ones on the secondary base that are goofed.  For instance, on this
machine it is just the last one that is ill.

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:07.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
00:09.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
00:0b.0 SCSI storage controller: Adaptec 7892P (rev 02)
00:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
01:0d.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]


-- 
                                     Jim Studt, President
                                     The Federated Software Group, Inc.
