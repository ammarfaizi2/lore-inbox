Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131833AbRASSNb>; Fri, 19 Jan 2001 13:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136358AbRASSNV>; Fri, 19 Jan 2001 13:13:21 -0500
Received: from exit1.i-55.com ([204.27.97.1]:40166 "EHLO exit1.i-55.com")
	by vger.kernel.org with ESMTP id <S131833AbRASSNL>;
	Fri, 19 Jan 2001 13:13:11 -0500
Message-ID: <3A6881F9.17F7B9F6@mailhost.cs.rose-hulman.edu>
Date: Fri, 19 Jan 2001 12:05:45 -0600
From: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Patch for aic7xxx 2.4.0 test12 hang
In-Reply-To: <200101191756.f0JHuns30179@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> 
> >This is a temporary patch to keep the scsi driver from eating
> >your data.... I am working on a real fix....
> >
> >Leslie Donaldson
> 
> What is the firmware revision of your Seagate drives? 

Not using seagate drives this is with quantum

see bottom....

> There
> were several models shipped in the recent past with firware that
> would cause the drive to drop off the bus under high load.

Ummm o the controller card...

00:06.0 SCSI storage controller: Adaptec 7899A (rev 01)
        Subsystem: Adaptec: Unknown device f620
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
        BIST result: 00
        I/O ports at 8000 [size=256]
        Memory at 000000000c864000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 000000000c800000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

00:06.1 SCSI storage controller: Adaptec 7899A (rev 01)
        Subsystem: Adaptec: Unknown device f620
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 23
        BIST result: 00
        I/O ports at 8400 [size=256]
        Memory at 000000000c865000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 000000000c820000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2


> There is also a known issue with U160 modes and the currently
> embedded aic7xxx driver.  

That's true the problem is the TCQ command seems to be sequencing wrong.

>You might want to try the Adaptec
> supported driver from here:
> 
> http://people.FreeBSD.org/~gibbs/linux/
> 
> 6.09 BETA should be released later today.

I'll try it later  tonight, 

> --
> Justin


Jan 19 11:23:40 shadowdragon kernel: SCSI subsystem driver Revision:
1.00 
Jan 19 11:23:40 shadowdragon kernel: (scsi0) <Adaptec AIC-7899 Ultra
160/m SCSI host adapter> found at PCI 0/6/0 
Jan 19 11:23:40 shadowdragon kernel: (scsi0) Wide Channel A, SCSI ID=7,
32/255 SCBs 
Jan 19 11:23:40 shadowdragon kernel: (scsi0) Downloading sequencer
code... 392 instructions downloaded 
Jan 19 11:23:41 shadowdragon pcmcia: Starting PCMCIA services:
Jan 19 11:23:40 shadowdragon kernel: (scsi1) <Adaptec AIC-7899 Ultra
160/m SCSI host adapter> found at PCI 0/6/1 
Jan 19 11:23:40 shadowdragon kernel: (scsi1) Wide Channel B, SCSI ID=7,
32/255 SCBs 
Jan 19 11:23:40 shadowdragon kernel: (scsi1) Downloading sequencer
code... 392 instructions downloaded 
Jan 19 11:23:40 shadowdragon kernel: scsi0 : Adaptec AHA274x/284x/294x
(EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0 
Jan 19 11:23:40 shadowdragon kernel:        <Adaptec AIC-7899 Ultra
160/m SCSI host adapter> 
Jan 19 11:23:40 shadowdragon kernel: scsi1 : Adaptec AHA274x/284x/294x
(EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0 
Jan 19 11:23:40 shadowdragon kernel:        <Adaptec AIC-7899 Ultra
160/m SCSI host adapter> 
Jan 19 11:23:40 shadowdragon kernel: (scsi0:0:3:0) Synchronous at 5.0
Mbyte/sec, offset 8. 
Jan 19 11:23:40 shadowdragon kernel:   Vendor: FUJITSU   Model:
M2512A            Rev: 1408 
Jan 19 11:23:40 shadowdragon kernel:   Type:   Optical
Device                     ANSI SCSI revision: 02 
Jan 19 11:23:40 shadowdragon kernel: (scsi0:0:4:0) Synchronous at 10.0
Mbyte/sec, offset 8. 
Jan 19 11:23:40 shadowdragon kernel:   Vendor: TOSHIBA   Model: CD-ROM
XM-5701TA  Rev: 0167 
Jan 19 11:23:40 shadowdragon kernel:   Type:  
CD-ROM                             ANSI SCSI revision: 02 
Jan 19 11:23:40 shadowdragon kernel: (scsi1:0:0:0) Synchronous at 80.0
Mbyte/sec, offset 31. 
Jan 19 11:23:40 shadowdragon kernel:   Vendor: QUANTUM   Model: ATLAS
10K 18WLS   Rev: UC81 
Jan 19 11:23:40 shadowdragon kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 03 
Jan 19 11:23:40 shadowdragon kernel: (scsi1:0:0:0) DISABLED TAGGED
QUEUING, queue depth 0. 
Jan 19 11:23:40 shadowdragon kernel: Detected scsi removable disk sda at
scsi0, channel 0, id 3, lun 0 
Jan 19 11:23:40 shadowdragon kernel: Detected scsi disk sdb at scsi1,
channel 0, id 0, lun 0 
Jan 19 11:23:40 shadowdragon kernel: sda : READ CAPACITY failed. 
Jan 19 11:23:40 shadowdragon kernel: sda : status = 1, message = 00,
host = 0, driver = 28  
Jan 19 11:23:40 shadowdragon kernel: sda : extended sense code = 2  
Jan 19 11:23:40 shadowdragon kernel: sda : block size assumed to be 512
bytes, disk size 1GB.   
Jan 19 11:23:40 shadowdragon kernel: Partition check: 
Jan 19 11:23:40 shadowdragon kernel:  sda: I/O error: dev 08:00, sector
0 
Jan 19 11:23:41 shadowdragon pcmcia:  modules
Jan 19 11:23:40 shadowdragon kernel:  unable to read partition table 
Jan 19 11:23:40 shadowdragon kernel: SCSI device sdb: 35877972 512-byte
hdwr sectors (18370 MB) 
Jan 19 11:23:40 shadowdragon kernel:  sdb: sdb1 sdb2 sdb3 sdb4 
Jan 19 11:23:40 shadowdragon kernel: Detected scsi CD-ROM sr0 at scsi0,
channel 0, id 4, lun 0 
Jan 19 11:23:40 shadowdragon kernel: Uniform CD-ROM driver Revision:
3.11 


-- 
/----------------------------\ Current Contractor: None
|    Leslie F. Donaldson     | Current Customer  : None
|    Computer Contractor     | Skills:
Unix/OS9/VMS/Linux/SUN-OS/C/C++/assembly
| Have Computer will travel. | WWW  :
http://www.cs.rose-hulman.edu/~donaldlf
\----------------------------/ Email: mail://donaldlf@cs.rose-hulman.edu
Goth Code V1.1: GoCS$$ TYg(T6,T9) B11Bk!^1 C6b-- P0(1,7) M+ a24 n---
b++:+
                H6'11" g m---- w+ r+++ D--~!% h+ s10 k+++ R-- Ssw
LusCA++
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
