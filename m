Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136712AbREHA33>; Mon, 7 May 2001 20:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136711AbREHA3U>; Mon, 7 May 2001 20:29:20 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:56282 "HELO
	smtp2.pandora.be") by vger.kernel.org with SMTP id <S136712AbREHA3H>;
	Mon, 7 May 2001 20:29:07 -0400
Message-ID: <3AF73DCD.7090705@aquazul.com>
Date: Tue, 08 May 2001 02:29:01 +0200
From: Mourad De Clerck <mourad@aquazul.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-ac4 i686; en-US; 0.8.1; Debian GNU) Gecko/20010412
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just tried 2.4.4ac5, and it stopped with an ext2fs error (Block 
bitmap for group 16 not in...) Reiserfs was compiled in the kernel too, 
and it too was complaining (they weren't able to mount my (ext2) root 
partition for some reason)

I've gone back to ac4, with an identical kernel config, and it works 
flawlessly...

I'm using an adaptec 2940uw - i'm assuming it's something to do with 
this entry in the changelog of ac5:
* Update aic7xxx to 6.1.12   (Justin Gibbs)

I'm using an epox kp6-bs, which is a bx based SMP board - i appended 
some output from the scsi and acpi (this is ac4)

If anyone needs more info (dmesg/kernelconfig), just ask - but please cc 
me as i'm not subscribed to linux-kernel

Mourad DC


SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.11
       <Adaptec 2940 Ultra SCSI adapter>
       aic7880: Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DDRS-34560W       Rev: S92A
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DDRS-34560W       Rev: S97B
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DCAS-32160        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IOMEGA    Model: ZIP 100           Rev: J.03
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: QUANTUM   Model: VIKING 2.3 WSE    Rev: 8808
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:0:1:0: Tagged Queuing enabled.  Depth 253
scsi0:0:2:0: Tagged Queuing enabled.  Depth 253
scsi0:0:3:0: Tagged Queuing enabled.  Depth 253
scsi0:0:9:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 3, lun 0
Attached scsi removable disk sdd at scsi0, channel 0, id 4, lun 0
Attached scsi disk sde at scsi0, channel 0, id 9, lun 0
(scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
SCSI device sda: 8925000 512-byte hdwr sectors (4570 MB)
Partition check:
/dev/scsi/host0/bus0/target1/lun0: p1 p2 < p5 p6 >
(scsi0:A:2): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
SCSI device sdb: 8925000 512-byte hdwr sectors (4570 MB)
/dev/scsi/host0/bus0/target2/lun0: p1
(scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 15)
SCSI device sdc: 4226725 512-byte hdwr sectors (2164 MB)
/dev/scsi/host0/bus0/target3/lun0: p1 p2 p3
SCSI device sdd: 196608 512-byte hdwr sectors (101 MB)
sdd: Write Protect is off
/dev/scsi/host0/bus0/target4/lun0: p4
(scsi0:A:9): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
SCSI device sde: 4446801 512-byte hdwr sectors (2277 MB)
/dev/scsi/host0/bus0/target9/lun0: p1
   ACPI-0411: *** Warning: Reference \_PR_.CPU0 at AML 903 not found
ACPI: Core Subsystem version [20010427]
ACPI: Subsystem enabled


