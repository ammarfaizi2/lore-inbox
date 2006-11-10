Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946552AbWKJMs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946552AbWKJMs1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 07:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946557AbWKJMs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 07:48:27 -0500
Received: from palakse.guam.net ([202.128.0.38]:33683 "EHLO palakse.guam.net")
	by vger.kernel.org with ESMTP id S1946552AbWKJMs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 07:48:26 -0500
From: "Michael D. Setzer II" <mikes@kuentos.guam.net>
To: linux-kernel@vger.kernel.org
Date: Fri, 10 Nov 2006 22:48:19 +1000
MIME-Version: 1.0
Subject: Failure of sata_via with kernels since 2.6.15.6
Message-ID: <455501B3.13819.421AEC9@mikes.kuentos.guam.net>
X-PM-Encryptor: QDPGP, 4
X-mailer: Pegasus Mail for Windows (4.41)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've been working on the g4l since version 0.15 thru 0.21. I've recently found that later kernels 
no longer work with some sata controller. Below are the dmesg parts of the dmesg output of 
a 2.6.15.6 that works fine with the controller. All later kernels showed results similar to the 
2.6.18.2 kernel. I've even tried using the 2.6.15.6  .config file as a source to build newer 
kernels with the same results.  Unfortuntely, this machine is a primary server, so can only do 
very limited testing. Have also seen the same problem with latest Knoppix not seeing the 
SATA drive either. 


2.6.15.6 kernel dmesg 

sata_via 0000:00:0f.0: version 1.1
PCI: Calling quirk c02ab9ca for 0000:00:0f.0
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 2
sata_via 0000:00:0f.0: routed to hard irq line 2
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 18
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 18
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 490234752 sectors: LBA48
ata1: slow completion (cmd ef)
ata1: dev 0 configured for UDMA/133
scsi2 : sata_via
ata2: no device found (phy stat 00000000)
scsi3 : sata_via
  Vendor: ATA       Model: Maxtor 6L250S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
st: Version 20050830, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.3
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
 sda:<3>ata1: command 0x25 timeout, stat 0x50 host_stat 0x4
 sda1
sd 2:0:0:0: Attached scsi disk sda
sd 2:0:0:0: Attached scsi generic sg0 type 0



=======
2.6.18.2 kernel dmesg 

ard irq line 10
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 145
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 145
scsi2 : sata_via
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
scsi3 : sata_via
ata2: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xE407


+----------------------------------------------------------+
  Michael D. Setzer II -  Computer Science Instructor      
  Guam Community College  Computer Center                  
  mailto:mikes@kuentos.guam.net                            
  mailto:msetzerii@gmail.com
  http://www.guam.net/home/mikes
  Guam - Where America's Day Begins                        
+----------------------------------------------------------+

http://setiathome.berkeley.edu
Number of Seti Units Returned:  19,471
Processing time:  32 years, 290 days, 12 hours, 58 minutes
(Total Hours: 287,489)

BOINC TOTAL CREDITS SETI@HOME/EINSTEIN@HOME
Total Credits 2184657.881045 
Total Credits 245068.701712 


-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8 -- QDPGP 2.61c
Comment: http://community.wow.net/grt/qdpgp.html

iQA/AwUBRVPodCzGQcr/2AKZEQJC0QCfRIoXadnkx8wWkwYcRpDtocdqfdMAoNn9
4QDSM6iAqvaMbs1CXQx5OFju
=TJrv
-----END PGP SIGNATURE-----
