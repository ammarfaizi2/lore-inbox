Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbUAJQDy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 11:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUAJQC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 11:02:28 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:65450 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265225AbUAJQBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 11:01:41 -0500
Date: Sat, 10 Jan 2004 08:01:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: rjwysocki@sisk.pl
Subject: [Bug 1827] New: USB storage-related system hand on AMD64
Message-ID: <70870000.1073750491@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1827

           Summary: USB storage-related system hand on AMD64
    Kernel Version: 2.6.1
            Status: NEW
          Severity: high
             Owner: ak@suse.de
         Submitter: rjwysocki@sisk.pl


Distribution: SuSE 9.0 64-bit (x86_64) 
Hardware Environment: 2 x AMD Opteron 240, Tyan Thunder K8W, 1 GB RAM (4 x 256, two 
nodes, dual-channel), Adaptec AHA19160 + SCSI CD-RW (Toshiba), LSI 53C1010 64-bit SCSI 
+ 2 x HDD (IBM), NEC-based USB 2.0 adapter (Manhattan), GeForce FX5200 (LeadTek), 
SATA HDD (Seagate), IDE DVD (Liteon) 
Software Environment: Out-of-the box SuSE 9.0 (downloadable version) + Linux 2.6.1 
Problem Description: The system hangs solid after a USB storage device has been 
disconnected 
 
Hint1: This occurs on 2.6.1-rc2-bk1 and 2.6.1-rc3 as well.  I'm almost sure it occurs on 
2.6.1-rc1, but I had no time to confirm it 
 
Hint2: The NEC-based USB 2.0 is involved, which is on a PCI connected to the bus via the 
AMD-8111 chip, so it may be a PCI bug 
 
Hint3: Here's a snippet from the kernel log: 
 
Jan  9 23:52:50 chimera kernel: hub 4-0:1.0: new USB device on port 3, assigned address 2 
Jan  9 23:52:56 chimera kernel: Initializing USB Mass Storage driver... 
Jan  9 23:52:56 chimera kernel: scsi2 : SCSI emulation for USB Mass Storage devices 
Jan  9 23:52:56 chimera kernel:   Vendor:           Model: TS256MJFLASHA     Rev: 1.00 
Jan  9 23:52:56 chimera kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02 
Jan  9 23:52:56 chimera kernel: SCSI device sdc: 506400 512-byte hdwr sectors (259 MB) 
Jan  9 23:52:56 chimera kernel: sdc: assuming Write Enabled 
Jan  9 23:52:56 chimera kernel: sdc: assuming drive cache: write through 
Jan  9 23:52:57 chimera kernel:  sdc: sdc1 
Jan  9 23:52:57 chimera kernel: Attached scsi removable disk sdc at scsi2, channel 0, id 0, 
lun 0 
Jan  9 23:52:57 chimera kernel: Attached scsi generic sg3 at scsi2, channel 0, id 0, lun 0,  
type 0 
Jan  9 23:52:57 chimera kernel: WARNING: USB Mass Storage data integrity not assured 
Jan  9 23:52:57 chimera kernel: USB Mass Storage device found at 2 
Jan  9 23:52:57 chimera kernel: drivers/usb/core/usb.c: registered new driver usb-storage 
Jan  9 23:52:57 chimera kernel: USB Mass Storage support registered. 
Jan  9 23:52:57 chimera kernel: Device not ready.  Make sure there is a disc in the drive. 
Jan  9 23:53:55 chimera kernel: usb 4-3: USB disconnect, address 2 
Jan  9 23:54:01 chimera kernel: Unable to handle kernel NULL pointer dereference at 
0000000000000008 RIP:  
Jan  9 23:54:01 chimera kernel: <ffffffff801848dd>{chrdev_open+285}PML4 39400067 PGD 
392bc067 PMD 0 
 
The hang occurs now. 
 
Note: It was confirmed only with the help of a USB pendrive.  I've not tried any other USB 
devices yet. 
 
Steps to reproduce: Put a USB pendrive into a USB port, wait 10 seconds and pull it out.


