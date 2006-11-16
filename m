Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161881AbWKPGgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161881AbWKPGgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 01:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161882AbWKPGf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 01:35:59 -0500
Received: from mail.ggsys.net ([69.26.161.131]:43174 "EHLO mail.ggsys.net")
	by vger.kernel.org with ESMTP id S1161881AbWKPGf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 01:35:58 -0500
Subject: Re: qstor driver -> irq 193: nobody cared
From: Alberto Alonso <alberto@ggsys.net>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <455A09A5.2020200@rtr.ca>
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca>
	 <1163180185.28843.13.camel@w100>  <4556AC74.3010000@rtr.ca>
	 <1163363479.3423.8.camel@w100>  <45588132.9090200@rtr.ca>
	 <1163479852.3340.9.camel@w100>  <4559F2EE.7080309@rtr.ca>
	 <1163528258.3340.23.camel@w100>  <455A09A5.2020200@rtr.ca>
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Thu, 16 Nov 2006 00:35:52 -0600
Message-Id: <1163658952.3416.13.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the long delay, I've been called on too
many issues at work this week.

Anyway, the patch basically made the drives not usable.
Here is the log from the boot process:


libata version 1.20 loaded.
sata_qstor 0000:01:03.0: version 0.05
ata1: SATA max UDMA/133 cmd 0xF8820400 ctl 0xF8820440 bmdma 0x0 irq 185
ata2: SATA max UDMA/133 cmd 0xF8824400 ctl 0xF8824440 bmdma 0x0 irq 185
ata3: SATA max UDMA/133 cmd 0xF8828400 ctl 0xF8828440 bmdma 0x0 irq 185
ata4: SATA max UDMA/133 cmd 0xF882C400 ctl 0xF882C440 bmdma 0x0 irq 185
ata1: SATA link up 3.0 Gbps (SStatus 123)
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023
88:407f
ata1: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_qstor
ata2: SATA link up 3.0 Gbps (SStatus 123)
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023
88:407f
ata2: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_qstor
ata3: SATA link up 3.0 Gbps (SStatus 123)
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023
88:407f
ata3: dev 0 ATA-7, max UDMA/133, 976771055 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_qstor
ata4: SATA link up 3.0 Gbps (SStatus 123)
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023
88:407f
ata4: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_qstor
  Vendor: ATA       Model: ST3500641AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3500641AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3500641AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3500641AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 976771055 512-byte hdwr sectors (500107 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 976771055 512-byte hdwr sectors (500107 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
sd 3:0:0:0: Attached scsi generic sg3 type 0

[...]

md: md3 stopped.
ata1: command 0x25 timeout, stat 0xff host_stat 0x0
ata1: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xff { Busy }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sda, sector 976772992
Buffer I/O error on device sda, logical block 122096624
ata1: command 0x25 timeout, stat 0xff host_stat 0x0
ata1: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xff { Busy }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sda, sector 976772992
Buffer I/O error on device sda, logical block 122096624
ata2: command 0x25 timeout, stat 0xff host_stat 0x0
ata2: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata2: status=0xff { Busy }
sd 1:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdb, sector 976772992
Buffer I/O error on device sdb, logical block 122096624
ata2: command 0x25 timeout, stat 0xff host_stat 0x0
ata2: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata2: status=0xff { Busy }
sd 1:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdb, sector 976772992
Buffer I/O error on device sdb, logical block 122096624
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770816
Buffer I/O error on device sdc, logical block 976770816
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770817
Buffer I/O error on device sdc, logical block 976770817
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770818
Buffer I/O error on device sdc, logical block 976770818
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770819
Buffer I/O error on device sdc, logical block 976770819
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770820
Buffer I/O error on device sdc, logical block 976770820
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770821
Buffer I/O error on device sdc, logical block 976770821
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770822
Buffer I/O error on device sdc, logical block 976770822
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770823
Buffer I/O error on device sdc, logical block 976770823
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770816
Buffer I/O error on device sdc, logical block 976770816
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770817
Buffer I/O error on device sdc, logical block 976770817
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770818
Buffer I/O error on device sdc, logical block 976770818
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770819
Buffer I/O error on device sdc, logical block 976770819
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770820
Buffer I/O error on device sdc, logical block 976770820
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770821
Buffer I/O error on device sdc, logical block 976770821
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770822
Buffer I/O error on device sdc, logical block 976770822
ata3: command 0x25 timeout, stat 0xff host_stat 0x0
ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xff { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 976770823
Buffer I/O error on device sdc, logical block 976770823
ata4: command 0x25 timeout, stat 0xff host_stat 0x0
ata4: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata4: status=0xff { Busy }
sd 3:0:0:0: SCSI error: return code = 0x8000002
sdd: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdd, sector 976772992
Buffer I/O error on device sdd, logical block 122096624
ata4: command 0x25 timeout, stat 0xff host_stat 0x0
ata4: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata4: status=0xff { Busy }
sd 3:0:0:0: SCSI error: return code = 0x8000002
sdd: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdd, sector 976772992
Buffer I/O error on device sdd, logical block 122096624

[...]

md3 is software RAID 5 composed of sda through sdd, which are
the disks attached to the qstor.

I went back to the old kernel to be able to use this
array.

Any ideas?


Thanks,

Alberto


On Tue, 2006-11-14 at 13:23 -0500, Mark Lord wrote:
> Alberto Alonso wrote:
> > Sounds good, let me know if you need me to do any
> > testing or help on the programming. 
> 
> Okay, try this (untested) and see if it cleans things up.
> I'm also including the old "printk" patch, so that we can
> tell whether the "fix" is actually working or not.
> 
> Thanks
-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups

