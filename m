Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288992AbSAFRKD>; Sun, 6 Jan 2002 12:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288993AbSAFRJx>; Sun, 6 Jan 2002 12:09:53 -0500
Received: from CPE0020afe4a174.cpe.net.cable.rogers.com ([24.114.142.183]:34053
	"EHLO warthog.ern-e.org") by vger.kernel.org with ESMTP
	id <S288992AbSAFRJp>; Sun, 6 Jan 2002 12:09:45 -0500
Date: Sun, 6 Jan 2002 12:10:05 -0500 (EST)
From: elim <elim@warthog.ern-e.org>
To: <linux-kernel@vger.kernel.org>
Subject: slow scsi disk perf (sym53c875 and IBM drives)
Message-ID: <Pine.LNX.4.33L2.0201061159330.23448-100000@warthog.ern-e.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hiya,

I've been having relatively poor scsi disk performance for as long as I
can remember now. I've experienced this with ~2.2.12 all the way up to
2.4.17.

I'm not much of a scsi buff but I've read some suggestions such as proper
termination, queue depths, etc but nothing seems to have helped. My
understanding is that I should be getting better performance than I'm
getting with these drives.

Any suggestions would be appreciated and if this is not the right forum to
ask.. please direct me to the proper place.

Thanks and regards.

PS: kindly cc me on replies.

hdparm output:

/dev/sda:
 Timing buffered disk reads:  64 MB in 10.94 seconds =  5.85 MB/sec

/dev/sdb:
 Timing buffered disk reads:  64 MB in  8.66 seconds =  7.39 MB/sec

/dev/sdc:
 Timing buffered disk reads:  64 MB in 10.88 seconds =  5.88 MB/sec

SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 12, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected with Symbios NVRAM
sym53c875-0: rev 0x26 on pci bus 0 device 12 function 0 irq 10
sym53c875-0: Symbios format NVRAM, ID 7, Fast-20, Parity Checking
sym53c875-0: on-chip RAM at 0xe0502000
sym53c875-0: restart (scsi reset).
sym53c875-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx-1.7.3c-20010512
sym53c875-0-<0,*>: FAST-10 WIDE SCSI 20.0 MB/s (100.0 ns, offset 15)
  Vendor: IBM       Model: DCHS09W           Rev: 6363
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym53c875-0-<1,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 15)
  Vendor: IBM       Model: DGHS09U           Rev: 03E0
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c875-0-<4,*>: FAST-10 WIDE SCSI 20.0 MB/s (100.0 ns, offset 15)
  Vendor: IBM       Model: DCHS09W           Rev: 6363
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym53c875-0-<0,0>: tagged command queue depth set to 8
sym53c875-0-<1,0>: tagged command queue depth set to 8
sym53c875-0-<4,0>: tagged command queue depth set to 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 4, lun 0
SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
Partition check:
 sda: sda1 < sda5 sda6 sda7 >
SCSI device sdb: 17774160 512-byte hdwr sectors (9100 MB)
 sdb: sdb1 sdb2
SCSI device sdc: 17774160 512-byte hdwr sectors (9100 MB)
 sdc: sdc1

