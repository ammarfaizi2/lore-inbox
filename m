Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262346AbSKCTrg>; Sun, 3 Nov 2002 14:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262411AbSKCTrf>; Sun, 3 Nov 2002 14:47:35 -0500
Received: from steve.prima.de ([62.72.84.2]:17033 "HELO steve.prima.de")
	by vger.kernel.org with SMTP id <S262346AbSKCTre>;
	Sun, 3 Nov 2002 14:47:34 -0500
Date: Sun, 3 Nov 2002 20:53:25 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: U160 on Adaptec 39160
Message-ID: <20021103195325.GA9689@oscar.homelinux.net>
Reply-To: Patrick Mau <mau@oscar.prima.de>
References: <4.3.2.7.2.20021103124403.00b4c860@mail.dns-host.com> <20021103133014.GJ23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103133014.GJ23425@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 05:30:14AM -0800, William Lee Irwin III wrote:
> On Sun, Nov 03, 2002 at 12:59:44PM +0100, Margit Schubert-While wrote:
> > Hi,
> > 	Anybody know why I'm not getting 160MB transfers ?
> > 	Kernel is Suse 2.4.19
> > 	MB is Intel D845PESVL + 2.4 P4 + 512MB DDR333 ram.
> > 	Adaptec card is in 3rd PCI slot.
> > 	AGP ATI 7500 vga
> > 	2 x U160 disks on channel B with special U160 cable and actively
> > 	terminated.
> > 	DVD + DAT on SE channel A. Nothing on U160 channel A.
> > 	Snips under from log and /proc
> > 	Thanks
> > 	Margit Schubert-While
> 
> 39160 does 80MB/s/channel, the 160MB/s happens pretty much only as
> the sum of both channels. I've had one for a couple of years, and it
> performs very well, though it won't ever quite live up to the marketing
> gimmick for bandwidth on a single channel. ISTR something about RAID
> across channels involved, but I just use disks directly instead.
> 
> Bill

Hi,

the Adaptec 39160 is indeed capable of doing 160MB/s/channel. Did I
misread the whole thread ? Here's the dmesg output of my system.
I get >40MB/s per disk and >80MB/s per channel.

Maybe it's because of your DVD and DAT device. I only have disks
connected to the adapter.

cheers,
Patrick

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: IC35L036UCD210-0  Rev: S5BA
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: IC35L036UCD210-0  Rev: S5BA
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
scsi0:A:1:0: Tagged Queuing enabled.  Depth 64
  Vendor: IBM       Model: IC35L036UWD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: IC35L036UWD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:0:0: Tagged Queuing enabled.  Depth 64
scsi1:A:1:0: Tagged Queuing enabled.  Depth 64
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdd at scsi1, channel 0, id 1, lun 0
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
 sdb: sdb1 sdb2 sdb3 sdb4
(scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdc: 71687340 512-byte hdwr sectors (36704 MB)
 sdc: sdc1 sdc2 sdc3 sdc4
(scsi1:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdd: 71687340 512-byte hdwr sectors (36704 MB)
 sdd: sdd1 sdd2 sdd3 sdd4

