Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261745AbSKCLxG>; Sun, 3 Nov 2002 06:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261749AbSKCLxG>; Sun, 3 Nov 2002 06:53:06 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:21388 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261745AbSKCLxE>; Sun, 3 Nov 2002 06:53:04 -0500
Message-Id: <4.3.2.7.2.20021103124403.00b4c860@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 03 Nov 2002 12:59:44 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: U160 on Adaptec 39160
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Anybody know why I'm not getting 160MB transfers ?
	Kernel is Suse 2.4.19
	MB is Intel D845PESVL + 2.4 P4 + 512MB DDR333 ram.
	Adaptec card is in 3rd PCI slot.
	AGP ATI 7500 vga
	2 x U160 disks on channel B with special U160 cable and actively
	terminated.
	DVD + DAT on SE channel A. Nothing on U160 channel A.
	Snips under from log and /proc
	Thanks
	Margit Schubert-While

/var/log/boot.msg
--- snip ---
<6>SCSI subsystem driver Revision: 1.00
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
<4>        <Adaptec 3960D Ultra160 SCSI adapter>
<4>        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
<4>
<6>scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
<4>        <Adaptec 3960D Ultra160 SCSI adapter>
<4>        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
<4>
<4>  Vendor: PIONEER   Model: DVD-ROM DVD-303   Rev: 1.09
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>  Vendor: HP        Model: C1537A            Rev: L812
<4>  Type:   Sequential-Access                  ANSI SCSI revision: 02
<4>  Vendor: FUJITSU   Model: MAN3184MP         Rev: 0108
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>  Vendor: FUJITSU   Model: MAN3184MP         Rev: 0108
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
<4>scsi1:A:1:0: Tagged Queuing enabled.  Depth 32
<6>st: Version 20020205, bufsize 32768, wrt 30720, max init. bufs 4, s/g 
segs 16
<4>Attached scsi tape st0 at scsi0, channel 0, id 5, lun 0
<4>sd: allocated major 8
<7>sd: find_free_slot ...<7>sd: ... found 08:00
<4>Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
<7>sd: find_free_slot ...<7>sd: ... found 08:10
<4>Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
<4>(scsi1:A:0): 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
<4>SCSI device sda: 35885448 512-byte hdwr sectors (18373 MB)
<6>Partition check:
<6> sda: sda1 sda2
<4>(scsi1:A:1): 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
<4>SCSI device sdb: 35885448 512-byte hdwr sectors (18373 MB)
--- end snip ---

/proc/scsi/aic7xxx/1
-- snip ---
Adaptec AIC7xxx driver version: 6.2.8
aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

Serial EEPROM:
0x433a 0x433a 0x433a 0x433a 0x433a 0x433a 0x433a 0xc33a
0x433a 0x433a 0x433a 0x433a 0xc33a 0xc33a 0xc33a 0xc33a
0x0074 0x605d 0x2807 0x0010 0x0300 0xffff 0xffff 0xffff
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x0250 0x41cf

Channel A Target 0 Negotiation Settings
         User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
         Goal: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
         Curr: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
         Channel A Target 0 Lun 0 Settings
                 Commands Queued 4554
                 Commands Active 0
                 Command Openings 32
                 Max Tagged Openings 32
                 Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
         User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
         Goal: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
         Curr: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
         Channel A Target 1 Lun 0 Settings
                 Commands Queued 56
                 Commands Active 0
                 Command Openings 32
                 Max Tagged Openings 32
                 Device Queue Frozen Count 0
--- end snip ---

