Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbTEFA0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 20:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTEFA0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 20:26:17 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:31104 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S262157AbTEFA0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 20:26:15 -0400
Subject: pcmcia -> mmc adapter = call trace in kernel 2.5.x (since a long
	time)
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1052181542.783.4.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (Preview Release)
Date: 06 May 2003 02:39:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this at boot:

cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x37f
0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
hde: PCMCIA/SD ADAPTER, CFA DISK drive
hdf: probing with STATUS(0x58) instead of ALTSTATUS(0xb0)
hdf: PCMCIA/SD ADAPTER, CFA DISK drive
ide2 at 0x100-0x107,0x10e on irq 18
hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hde: task_no_data_intr: error=0x04 { DriveStatusError }
hde: 125440 sectors (64 MB) w/1KiB Cache, CHS=490/8/32
 hde: hde1
 hde: hde1
Badness in kobject_register at lib/kobject.c:293
Call Trace: [<c0234708>]  [<c01900d4>]  [<c0295e50>]  [<c0295dd0>] 
[<c0295de0>]  [<c02caa4a>]  [<c02c609f>]  [<c02bf2c3>]  [<c031bd9a>] 
[<c02c4583>]  [<c02c5186>]  [<c02cf006>]  [<c0319765>]  [<c02cf55b>] 
[<c031b60e>]  [<c0311a55>]  [<c0311c4c>]  [<c0312893>]  [<c0313bdf>] 
[<c0313cf3>]  [<c031bfe3>]  [<c03127a0>]  [<c03122cd>]  [<c0279a93>] 
[<c031bfe3>]  [<c031b60e>]  [<c0311a55>]  [<c0311c4c>]  [<c0312893>] 
[<c0313bdf>]  [<c0313cf3>]  [<c031bfe3>]  [<c03127a0>]  [<c03122cd>] 
[<c03120ff>]  [<c0311f16>]  [<c03127a0>]  [<c0313e33>]  [<c01a2d3a>] 
[<c0157d93>]  [<c0157df4>]  [<c01a2d3a>]  [<c01a3894>]  [<c02cf9b7>]
[<c03181a8>]  [<c0199d89>]  [<c031bfe3>]  [<c031b60e>]  [<c0311a55>] 
[<c03196fe>]  [<c02ceea2>]  [<c02cf950>]  [<c03173a5>]  [<c031a335>] 
[<c031ae8a>]  [<c0199ed0>]  [<c0333ed1>]  [<c013d1de>]  [<c013d331>] 
[<c01478af>]  [<c0147fd6>]  [<c011999c>]  [<c0188e71>]  [<c0232cf4>] 
[<c013d69c>]  [<c0141fe5>]  [<c014603b>]  [<c014614e>]  [<c0151c4a>] 
[<c014a108>]  [<c0149f42>]  [<c0149f9f>]  [<c014a42b>]  [<c0169d88>] 
[<c014a4c5>]  [<c010954b>]
hdf: status error: status=0x48 { DriveReady DataRequest }
 
hdf: drive not ready for command
hdf: 125440 sectors (64 MB) w/1KiB Cache, CHS=490/8/32
 hdf:hdf: status error: status=0x78 { DriveReady DeviceFault
SeekComplete DataRequest }
 
hdf: drive not ready for command
ide2: reset: success
hdf: status error: status=0x79 { DriveReady DeviceFault SeekComplete
DataRequest Error }
hdf: status error: error=0x79 { UncorrectableError SectorIdNotFound
AddrMarkNotFound }, LBAsect=7991417, sector=0
hdf: drive not ready for command
ide2: reset: success
hdf: status error: status=0x79 { DriveReady DeviceFault SeekComplete
DataRequest Error }
hdf: status error: error=0x79 { UncorrectableError SectorIdNotFound
AddrMarkNotFound }, LBAsect=7991417, sector=0
end_request: I/O error, dev hdf, sector 0
Buffer I/O error on device hdf, logical block 0
hdf: drive not ready for command
hdf: status timeout: status=0xe1 { Busy }
 
hdf: drive not ready for command
ide2: reset: success
hdf: status error: status=0x79 { DriveReady DeviceFault SeekComplete
DataRequest Error }
hdf: status error: error=0x79 { UncorrectableError SectorIdNotFound
AddrMarkNotFound }, LBAsect=7991417, sector=0
hdf: drive not ready for command
ide2: reset: success
hdf: status error: status=0x79 { DriveReady DeviceFault SeekComplete
DataRequest Error }
hdf: status error: error=0x79 { UncorrectableError SectorIdNotFound
AddrMarkNotFound }, LBAsect=7991417, sector=0
end_request: I/O error, dev hdf, sector 0
Buffer I/O error on device hdf, logical block 0
hdf: drive not ready for command
 unable to read partition table
 hdf:hdf: status timeout: status=0xe1 { Busy }
 
hdf: drive not ready for command
ide2: reset: success
hdf: status error: status=0x79 { DriveReady DeviceFault SeekComplete
DataRequest Error }
hdf: status error: error=0x79 { UncorrectableError SectorIdNotFound
AddrMarkNotFound }, LBAsect=7991417, sector=0
hdf: drive not ready for command
ide2: reset: success
hdf: status error: status=0x79 { DriveReady DeviceFault SeekComplete
DataRequest Error }
hdf: status error: error=0x79 { UncorrectableError SectorIdNotFound
AddrMarkNotFound }, LBAsect=7991417, sector=0
end_request: I/O error, dev hdf, sector 0
Buffer I/O error on device hdf, logical block 0
hdf: drive not ready for command
 unable to read partition table
ide-cs: hde: Vcc = 3.3, Vpp = 0.0
 hde: hde1

But, the damn thing actually works fine. It's just rather annoying that
it fills the screen with garbage when I'm about to log in.

Best regards,
Stian

