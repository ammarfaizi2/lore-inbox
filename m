Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136450AbREINhX>; Wed, 9 May 2001 09:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136452AbREINhN>; Wed, 9 May 2001 09:37:13 -0400
Received: from ns.viventus.no ([195.18.200.139]:265 "EHLO viventus.no")
	by vger.kernel.org with ESMTP id <S136450AbREINhK>;
	Wed, 9 May 2001 09:37:10 -0400
From: Rafael Martinez <rafael@viewpoint.no>
To: linux-kernel@vger.kernel.org
Reply-To: rafael@viewpoint.no
Subject: IO errors with 2.4.4 + System hangs a few seconds 
Date: Wed, 09 May 2001 15:39:21 +0100 (CEST)
X-Mailer: XCmail 1.2 - with PGP support, PGP engine version 0.5 (Linux)
X-Mailerorigin: http://www.fsai.fh-trier.de/~schmitzj/Xclasses/XCmail/
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Message-ID: <auto-000000189557@viventus.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hei

I have IO problems with a 2.4.4. kernel patched with linux-aic7xxx-6.1.13.

Trying to do a simple "cat file1 >> file2" a get in console this error:  
cat: file: Input/output error

And in /var/log/messages:

kernel: attempt to access beyond end of device
kernel: 08:11: rw=0, want=1887469700, limit=53785588
kernel: attempt to access beyond end of device
kernel: 08:11: rw=0, want=1887469700, limit=53785588
kernel: attempt to access beyond end of device
kernel: 08:11: rw=0, want=1887469700, limit=53785588
kernel: attempt to access beyond end of device
kernel: 08:11: rw=0, want=545305784, limit=53785588
kernel: attempt to access beyond end of device
kernel: 08:11: rw=0, want=87078212, limit=53785588
kernel: attempt to access beyond end of device

[ ........... ]
[ x lines, it can change from time to time, from 1 to 20 times]


This doesn't happen with all the files. With some files it happens with
others it doesn't.

Another problem is that the system hangs sometimes for a few seconds (from
2-3 up to 20sec) before giving me the control again . In this time I would
not get any respons from the system when I try to run a command, they just
hang, when the system comes back, I get all the results from the different
commands fast. I am not talking about heavy processes (w, free, ps ax, ls....) 

Any ideas? Do you need more info? 

Thanks for your time.
Rafael Martinez



--------------------------------------------
Machine Info:
--------------------------------------------
Intel SPKA4 4 x Xeon/700/1Mb
2Gb RAM

Redhat 7.1 with all the updates and 2.4.4
--------------------------------------------
SCSI system info:
--------------------------------------------
SCSI subsystem driver Revision: 1.00
kernel: ahc_pci:0:1:0: Host Adapter Bios disabled. Using default SCSI device parameters
kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
kernel:         aic7899: Ultra160 Wide Channel A,SCSI Id=7, 32/255 SCBs
kernel: 
kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
kernel:         aic7899: Ultra160 Wide Channel B,SCSI Id=7, 32/255 SCBs
kernel: 
kernel: scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
kernel:         <Adaptec aic7880 Ultra SCSI adapter>
kernel:         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs
kernel: 
kernel:   Vendor: QUANTUM   Model: ATLAS_V__9_WLS  Rev: 0230
kernel:   Type:   Direct-Access                    ANSI SCSI revision: 03
kernel:  (scsi0:A:0): 160.000MB/s transfers(80.000MHz DT, offset 63, 16bit)
kernel: scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
kernel:   Vendor: ESG-SHV   Model: SCA HSBP M9     Rev: 0.10
kernel:   Type:   Processor                         ANSI SCSI revision: 02
kernel: megaraid: v1.14g-ac2 (Release Date: Mar 22,2001; 19:34:02)
kernel: megaraid: found 0x101e:0x1960:idx 0:bus 9:slot 0:func 0
kernel: scsi3 : Found a MegaRAID controller at 0xf8808000, IRQ: 17
kernel: scsi3 : Enabling 64 bit support
kernel: megaraid: [C158:3.11] detected 1 logical drives
kernel: scsi3 : AMI MegaRAID C158 254 commands 16 targs 2 chans 40 luns
kernel: scsi3: scanning channel 1 for devices.
kernel:   Vendor: ESG-SHV   Model: SCA HSBP M9      Rev: 0.10
kernel:   Type:   Processor                         ANSI SCSI revision: 02
kernel: scsi3: scanning channel 2 for devices.
kernel: scsi3: scanning virtual channel for logical drives.
kernel:   Vendor: MegaRAID  Model: LD0 RAID5 52527R Rev: C158
kernel:   Type:   Direct-Access                     ANSI SCSI revision: 02
kernel: Detected scsi disk sda at scsi0, channel 0,id 0, lun 0
kernel: Detected scsi disk sdb at scsi3, channel 2,id 0, lun 0
kernel: SCSI device sda: 17930694 512-byte hdwr sectors (9181 MB)
kernel: Partition check:
kernel:  sda: sda1 sda2
kernel: SCSI device sdb: 107575296 512-byte hdwr sectors (55079 MB)
kernel:  sdb: sdb1
kernel: Detected scsi generic sg1 at scsi1, channel 0, id 6, lun 0, type 3
kernel: Detected scsi generic sg2 at scsi3, channel 0, id 6, lun 0, type 3
---------------------------------------------


