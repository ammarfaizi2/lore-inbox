Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKOAK6>; Tue, 14 Nov 2000 19:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129045AbQKOAKu>; Tue, 14 Nov 2000 19:10:50 -0500
Received: from mout1.freenet.de ([194.97.50.132]:63709 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S129040AbQKOAKd>;
	Tue, 14 Nov 2000 19:10:33 -0500
Date: Wed, 15 Nov 2000 00:42:07 +0100 (CET)
From: Gert Wollny <wollny@cns.mpg.de>
To: James M <dart@windeath.2y.net>
cc: linux-kernel@vger.kernel.org, twaugh@redhat.com
Subject: Re: Parport/IMM/Zip Oops Revisited -- Filesys problem? Viro please
 look
In-Reply-To: <3A11C123.84DE0A95@windeath.2y.net>
Message-ID: <Pine.LNX.4.10.10011150012390.684-100000@bolide.beigert.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Nov 2000, James M wrote:
>    Was just trying to find out why I can mount in 11pre1 and 11pre2 when
> Gert can't mount at all, so I removed my VFAT factory formatted zipdisk
> and put in an Ext2 formatted one.....**BOOM**

Actually i never tried to mount in my testings, just did "modprobe imm". I
did not even load sd.o, which reads the size of the medium. Output after 
successfull modprobe:
kernel: imm: Version 2.04 (for Linux 2.4.0) 
kernel: imm_connect 1 
kernel: imm: Found device at ID 6, Attempting to use EPP 32 bit 
kernel: imm: Found device at ID 6, Attempting to use PS/2 
kernel: imm: Communication established at 0x378 with ID 6 using PS/2 
kernel: device_check 0 
kernel: scsi1 : Iomega VPI2 (imm) interface 
kernel: scsi : 2 hosts. 
kernel:   Vendor: IOMEGA    Model: ZIP 250           Rev: J.45 
kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02 

Even without a disk this works (if parport_pc is preloaded).  


Anyway the disk in the drive was a 250MB vfat formatted one. But OTOH, the
oops trace points to ext2. 

For completeness: With the disk "modprobe sd"  gives 

kernel: Detected scsi removable disk sda at scsi1, channel 0, id 6, lun 0 
kernel: SCSI device sda: hdwr sector= 512 bytes. Sectors= 489532 [239 MB] [0.2 GB] 
kernel: sda: Write Protect is off 
kernel:  sda: sda4 

Refering to my last message - so far i didn't check, if an ext2 formated
disk works with test6. But "modprobe imm" worked.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
