Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbTHVASn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 20:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbTHVASn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 20:18:43 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:42115 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S262962AbTHVASl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 20:18:41 -0400
Subject: PCMCIA problem
From: Stian Jordet <liste@jordet.nu>
To: Linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1061511537.903.2.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 22 Aug 2003 02:18:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't really know wether this is kernel problem, pcmcia-cs problem or
a hardware problem. I have a very, very cheap mmc/sc card -> pcmcia
converter. When I insert it, I get these messages:

cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x37f
0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
hde: PCMCIA/SD ADAPTER, CFA DISK drive
hdf: probing with STATUS(0x50) instead of ALTSTATUS(0x0a)
hdf: PCMCIA/SD ADAPTER, CFA DISK drive
ide2 at 0x100-0x107,0x10e on irq 18
hde: max request size: 128KiB
hde: 125440 sectors (64 MB) w/1KiB Cache, CHS=490/8/32
 hde: hde1
hdf: max request size: 128KiB
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
ide-cs: hde: Vcc = 3.3, Vpp = 0.0
 hde: hde1

It seems to work perfect, but why on earth does it seem to try hdf for
anything? There is no card in the other slot? Anyone knows? It's the
same with 2.4.22-rc2 and 2.6.0-test3-latest-bk.

Best regards,
Stian

