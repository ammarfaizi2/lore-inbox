Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVCPObl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVCPObl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVCPObl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:31:41 -0500
Received: from colino.net ([213.41.131.56]:36850 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262599AbVCPObZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:31:25 -0500
Date: Wed, 16 Mar 2005 15:31:14 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: debian-powerpc@lists.debian.org
Subject: `dd` problem from cdrom
Message-ID: <20050316153114.374e095b@jack.colino.net>
X-Mailer: Sylpheed-Claws 1.0.1cvs22.2 (GTK+ 2.6.1; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using 2.6.10 and 2.6.11, trying to use dd from the ide cdrom in my
Ibook G4 fails like this:

[colin@jack /usr/src/linux-2.6.10]$ dd if=/dev/hdc of=/dev/null
dd: reading `/dev/hdc': Input/output error
0+0 records in
0+0 records out
[colin@jack /usr/src/linux-2.6.10]$ dmesg
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 0
Buffer I/O error on device hdc, logical block 0
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 8
Buffer I/O error on device hdc, logical block 1
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 16
Buffer I/O error on device hdc, logical block 2
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 24
Buffer I/O error on device hdc, logical block 3
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 32
Buffer I/O error on device hdc, logical block 4
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 40
Buffer I/O error on device hdc, logical block 5
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 48
Buffer I/O error on device hdc, logical block 6
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 56
Buffer I/O error on device hdc, logical block 7
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 0
Buffer I/O error on device hdc, logical block 0
[colin@jack /usr/src/linux-2.6.10]$ hdparm /dev/hdc

/dev/hdc:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 HDIO_GETGEO failed: Invalid argument


I didn't try older kernels yet; Any idea about this? Is it a kernel bug
or a configuration issue? 
-- 
Colin
