Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbTILUG2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbTILUG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:06:27 -0400
Received: from ausadmmsps308.aus.amer.dell.com ([143.166.224.103]:14095 "HELO
	AUSADMMSPS308.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S261871AbTILUE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:04:59 -0400
X-Server-Uuid: 5333cdb1-2635-49cb-88e3-e5f9077ccab5
Message-ID: <36696BAFD8467644ABA0050BE35890591258B0@ausx2kmpc106.aus.amer.dell.com>
From: Gary_Lerhaupt@Dell.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: usb uhci I/O errors in 2.4.22
Date: Fri, 12 Sep 2003 15:04:51 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 137CF963740938-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In using a TEAC usb floppy on a uhci system here running 2.4.22, I am seeing
multitudes of I/O errors and other weirdness.  In researching this issue, I
was surprised in not being able to find any other references to this same
problem, but I have been able to reproduce across a couple different systems
running various kernels.  Anyone?

Despite the I/O errors, the floppy is mountable and usable and generally,
once it is mounted, the I/O errors subside.  

hub.c: new USB device 00:1d.0-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x644/0x0) is not claimed by any active
driver.
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: TEAC      Model: FD-05PUB          Rev: 1026
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdc at scsi1, channel 0, id 0, lun 0
usb-uhci.c: interrupt, status 3, frame# 1220
SCSI device sdc: 2880 512-byte hdwr sectors (1 MB)
sdc: Write Protect is off
 sdc: sdc1 sdc2 sdc3 sdc4
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
USB Mass Storage support registered.
 I/O error: dev 08:21, sector 0
 I/O error: dev 08:21, sector 0
 I/O error: dev 08:21, sector 0
 I/O error: dev 08:21, sector 64
usb-uhci.c: interrupt, status 3, frame# 836
 I/O error: dev 08:22, sector 0
 I/O error: dev 08:22, sector 0
 I/O error: dev 08:22, sector 0
 I/O error: dev 08:22, sector 64
 I/O error: dev 08:23, sector 0
 I/O error: dev 08:23, sector 0
 I/O error: dev 08:23, sector 0
 I/O error: dev 08:23, sector 64
usb-uhci.c: interrupt, status 3, frame# 1092
 I/O error: dev 08:24, sector 0
 I/O error: dev 08:24, sector 0
 I/O error: dev 08:24, sector 0
 I/O error: dev 08:24, sector 64
 I/O error: dev 08:21, sector 0
 I/O error: dev 08:21, sector 0
 I/O error: dev 08:21, sector 0
 I/O error: dev 08:21, sector 64
usb-uhci.c: interrupt, status 3, frame# 68
 I/O error: dev 08:22, sector 0
 I/O error: dev 08:22, sector 0
 I/O error: dev 08:22, sector 0
 I/O error: dev 08:22, sector 64
usb-uhci.c: interrupt, status 3, frame# 1476
 I/O error: dev 08:23, sector 0
 I/O error: dev 08:23, sector 0
 I/O error: dev 08:23, sector 0
 I/O error: dev 08:23, sector 64
 I/O error: dev 08:24, sector 0
 I/O error: dev 08:24, sector 0
 I/O error: dev 08:24, sector 0
 I/O error: dev 08:24, sector 64
usb.c: USB disconnect on device 00:1d.0-1 address 2
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 24
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 24
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 24
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 24
sdc: Unit Not Ready, sense:
Info fld=0xa00 (nonstd), Current 00:00: sense key Not Ready
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08 
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdc : block size assumed to be 512 bytes, disk size 1GB.  
sdc: test WP failed, assume Write Enabled
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table

Gary Lerhaupt
Dell Linux Development

