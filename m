Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265220AbTLRPJQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 10:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbTLRPJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 10:09:16 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:51654 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265220AbTLRPJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 10:09:03 -0500
Date: Thu, 18 Dec 2003 10:09:00 -0500 (EST)
From: Adam K Kirchhoff <adamk@voicenet.com>
X-X-Sender: adamk@thorn.ashke.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0 sbp2 problems.
Message-ID: <Pine.LNX.4.58.0312181006220.1692@thorn.ashke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

	I agave 2.6.0 a shot this morning and have run into a slight
problem:  it refuses to work with my firewire harddrive.

	This is the relevent dmesg output:

ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[ffafe000-ffafe7ff]  Max
Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0001080037017e7b]
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0006ca0e0400880a]
ieee1394: unsolicited response packet received - no tlabel match
ieee1394: The root node is not cycle master capable; selecting a new root
node and resetting...
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: unsolicited response packet received - no tlabel match
sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: WDC WD12  Model: 00JB-00CRA1       Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 06
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
 sdb:<3>ieee1394: sbp2: aborting sbp2 command
0x28 00 00 00 00 00 00 00 08 00
ieee1394: sbp2: aborting sbp2 command
0x00 00 00 00 00 00
ieee1394: sbp2: reset requested
ieee1394: sbp2: Generating sbp2 fetch agent reset
ieee1394: sbp2: aborting sbp2 command
0x00 00 00 00 00 00
ieee1394: sbp2: reset requested
ieee1394: sbp2: Generating sbp2 fetch agent reset
ieee1394: sbp2: aborting sbp2 command
0x00 00 00 00 00 00
ieee1394: sbp2: reset requested
ieee1394: sbp2: Generating sbp2 fetch agent reset
ieee1394: sbp2: aborting sbp2 command
0x00 00 00 00 00 00
scsi: Device offlined - not ready after error recovery: host 1 channel 0
id 0 lun 0
SCSI error : <1 0 0 0> return code = 0x6050000
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
scsi1 (0:0): rejecting I/O to offline device
Buffer I/O error on device sdb, logical block 0
 unable to read partition table
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0

This drive works fine with 2.4.21.  Please let me know if there's any more
information that's needed, or if there's something I can do to help
troubleshoot this problem.

Adam


