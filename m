Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTK1Tgm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 14:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTK1Tgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 14:36:42 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:51133 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S261965AbTK1Tgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 14:36:41 -0500
Subject: Re: 2.6.0-test11: sbp2 trouble
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Ben Collins <bcollins@debian.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031128175950.GC1844@phunnypharm.org>
References: <1070036586.8571.15.camel@paragon.slim>
	 <20031128175950.GC1844@phunnypharm.org>
Content-Type: text/plain
Message-Id: <1070048217.9795.2.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 28 Nov 2003 20:36:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you do a ps and show me what the two knodemgrd's look like?

Here it goes:

[root@paragon root]# ps -ef|grep knode
root      9891     1  0 20:33 ?        00:00:00 [knodemgrd_0]
root      9892     1  0 20:33 ?        00:00:00 [knodemgrd_1]

Hope that helps. Also included some more dmesg output

ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[20]  MMIO=[feaff800-feafffff]  Max
Packet=[2048]
ohci1394_1: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=[feaff000-feaff7ff]  Max
Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800001eea32]
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0030e00050000aa0]
ieee1394: The root node is not cycle master capable; selecting a new
root node and resetting...
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
scsi3 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Error logging into SBP-2 device - login timed-out
ieee1394: Node added: ID:BUS[1-00:1023]  GUID[0030e001700104bf]
ieee1394: Host added: ID:BUS[1-02:1023]  GUID[00023c00c100cb72]
scsi4 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 1-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: IomintSA  Model: MCE3130AP-MO1300  Rev: 0011
  Type:   Optical Device                     ANSI SCSI revision: 02
ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect failed
ieee1394: sbp2: Error logging into SBP-2 device - login failed
ieee1394: sbp2: sbp2_reconnect_device failed!
ieee1394: sbp2: Error logging into SBP-2 device - login timed-out


