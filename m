Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131781AbRA3SPP>; Tue, 30 Jan 2001 13:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131832AbRA3SPF>; Tue, 30 Jan 2001 13:15:05 -0500
Received: from nat-20.kulnet.kuleuven.ac.be ([134.58.0.20]:61284 "EHLO
	scoezie.kotnet.org") by vger.kernel.org with ESMTP
	id <S131799AbRA3SO7>; Tue, 30 Jan 2001 13:14:59 -0500
Date: Tue, 30 Jan 2001 19:17:28 +0100 (CET)
From: Davy Preuveneers <davy.preuveneers@student.kuleuven.ac.be>
To: linux-kernel@vger.kernel.org
Subject: Parallel zip-disk can't use EPP 32 bit with 2.4.x kernels
Message-ID: <Pine.LNX.4.21.0101301846510.812-100000@scoezie.kotnet.org>
Organization: "kotnet" <www.kotnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I'm running the 2.4.x kernels, I'm having a little problem with my
parallel zip-disk. The ppa module can't use the EPP 32 protocol and uses
the PS/2 protocol instead (which is much slower), as shown by the boot
message of kernel 2.4.1:

   ppa: Version 2.07 (for Linux 2.4.x)
   ppa: Found device at ID 6, Attempting to use EPP 32 bit
   ppa: Found device at ID 6, Attempting to use PS/2
   ppa: Communication established with ID 6 using PS/2 
   scsi0 : Iomega VPI0 (ppa) interface
     Vendor: IOMEGA    Model: ZIP 100           Rev: J.03
     Type:   Direct-Access                      ANSI SCSI revision: 02
   Detected scsi removable disk sda at scsi0, channel 0, id 6, lun 0
   SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
   sda: Write Protect is off
   sda: sda4

Kernels 2.2.x use the EPP 32 bit protocol while the 2.4.x versions don't,
although I have used the same options when compiling the new 2.4.1 kernel.
When I change the parallel port configuration in the BIOS from ECP/EPP to
EPP only (version 1.9), the 2.4.x kernels use the EPP 32 bit protocol as 
well, but then I can't use ECP with dma anymore.

Does anyone know what the problem is?

Davy


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
