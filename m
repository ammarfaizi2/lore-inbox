Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTLUTZb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbTLUTZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:25:30 -0500
Received: from port-212-202-41-241.reverse.qsc.de ([212.202.41.241]:60546 "EHLO
	schillernet.dyndns.org") by vger.kernel.org with ESMTP
	id S263969AbTLUTZV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:25:21 -0500
Date: Sun, 21 Dec 2003 20:24:49 +0100 (CET)
Message-Id: <20031221.202449.884020653.rene.rebe@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: linux1394-devel@lists.sourceforge.net
Subject: Re: ieee1394 / sbp2 problem accessing iBook in target disk mode
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <200312122232.hBCMWgdq032418@hirsch.in-berlin.de>
References: <200312120112.02778.rene.rebe@gmx.net>
	<200312122232.hBCMWgdq032418@hirsch.in-berlin.de>
X-Mailer: Mew version 3.1 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > sbp2: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
> > scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
> > blk: queue e5fb0014, I/O limit 4095Mb (mask 0xffffffff)
> > ieee1394: sbp2: Logged into SBP-2 device
> > ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
> > ieee1394: sbp2: Logged into SBP-2 device
> > ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
> > scsi singledevice 3 0 0 0
> > scsi singledevice 1 0 0 0
> >   Vendor: AAPL      Model: FireWire Target   Rev: 0000
> >   Type:   Direct-Access                      ANSI SCSI revision: 03

Using a LaCie Firewire disk the sbp2 code works perfectly:

ohci1394: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000393fffeb0203a]
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[00d04b3b030766bf]
ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
sbp2: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
blk: queue c5e0e814, I/O limit 4095Mb (mask 0xffffffff)
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
scsi singledevice 1 0 0 0
  Vendor: WDC WD16  Model: 00BB-00DWA0       Rev: 15.0
  Type:   Direct-Access                      ANSI SCSI revision: 06
blk: queue c45bbc14, I/O limit 4095Mb (mask 0xffffffff)
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
 /dev/scsi/host1/bus0/target0/lun0: p1 p2

$ cat /proc/bus/ieee1394/devices

Node[0-00:1023]  GUID[00d04b3b030766bf]:
  Vendor ID: `LaCie   ' [0x00d04b]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
    LSPD(2) MAX_REC(64) CYC_CLK_ACC(255)
  Unit Directory 0:
    Vendor/Model ID: LaCie    [00d04b] / LaCie Hard Drive Firewire    [000001]
    Software Specifier ID: 00609e
    Software Version: 010483
    Driver: SBP2 Driver
    Length (in quads): 8

Sincerely yours,
  René Rebe
    - ROCK Linux stable release maintainer

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de
http://gsmp.tfh-berlin.de/gsmp http://gsmp.tfh-berlin.de/rene

