Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbUBXX5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUBXX5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:57:06 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:48266 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262539AbUBXXwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:52:53 -0500
Date: Tue, 24 Feb 2004 18:52:45 -0500 (EST)
From: Adam K Kirchhoff <adamk@voicenet.com>
X-X-Sender: adamk@thorn.ashke.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.3 and SBP2 problems.
Message-ID: <Pine.LNX.4.58.0402241847580.917@thorn.ashke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

	I reported this problem back in 2.6.0 and it still seems to exist
in 2.6.3.  Basically, my firewire hard drive no longer wants to work.
I've googled around, and came up with another post to the mailing list
suggesting setting serialize_io to 1 in the sbp2 driver, but that didn't
help at all.

	This has happened with two separate ohci controllers each on a
separate machine.  The first is identified as a lucent FW323 chip, and the
second is an Audigy firewire port.  The drive works with both cards under
2.4.25.

	This is the output from dmesg:

ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16]
MMIO=[e9021000-e90217ff]  Max Packet=[2048]
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0006ca0e0400880a]
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[0030dd8000304ddb]
ieee1394: unsolicited response packet received - no tlabel match
sbp2: $Rev: 1096 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io = 1)
scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: WDC WD12  Model: 00JB-00CRA1       Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 06
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda:<3>ieee1394: sbp2: aborting sbp2 command
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
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 lun 0
SCSI error : <1 0 0 0> return code = 0x50000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
scsi1 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda, logical block 0
 unable to read partition table
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0

Any ideas?

Adam

