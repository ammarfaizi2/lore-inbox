Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266037AbUAUUAL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 15:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbUAUUAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 15:00:11 -0500
Received: from mailwasher.lanl.gov ([192.16.0.25]:56266 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S266037AbUAUT7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 14:59:50 -0500
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
From: Stephen Smoogen <smoogen@lanl.gov>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1074293952.1321.5.camel@smoogen2.lanl.gov>
References: <1074289406.5752.5.camel@smoogen2.lanl.gov>
	 <2582475408.1074292759@aslan.btc.adaptec.com>
	 <1074293952.1321.5.camel@smoogen2.lanl.gov>
Content-Type: text/plain
Organization: CCN-2 ESM/SSC
Message-Id: <1074715181.21214.30.camel@smoogen1.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Wed, 21 Jan 2004 12:59:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully this wont spark more contention, but here is the additional
info I have dug up:

The cabling goes from the onboard scsi card to a removable carrier tray
to another disk to a terminator. Cabling was pulled out and looked at
for cuts, breaks, and other possible problems.. none seen. 

07/26/2001   Supermicro 370DL3/370DLE/P3TDL3/P3TDLE BIOS R1.31A
PentiumIII(tm), 866MHz
133MHz Host Bus, PC133 SDRAM
Checking NVRAM..
1024 MB OK
WAIT...

(C) American Megatrends Inc.,
63-0726-009999-00101111-072601-AMIBIOS-3DL0726-Y2KC-5

*** Press <Ctrl><A> for SCSISelect(TM) Utility! ***

Adaptec SCSI BIOS v3.10
(c) 2001 Adaptec, Inc. All Rights Reserved.
*** Press <Ctrl><A> for SCSISelect(TM) Utility! ***

Slot  Ch  ID  LUN  Vendor     Product              Size   Sync  Bus
*******************************************************************
 00   A    0   0   IBM        DDYS-T18350N         17GB   160    16
 00   A    4   0   IBM        DDYS-T18350N         17GB   160    16
 00   A    6   0

Putting in the debug options Justin sent in a seperate email.. I dont
get much more data.

Red Hat nash verSCSI subsystem driver Revision: 1.00
sion 3.3.10 starting
Loading scPCI: Found IRQ 10 for device 01:03.0
si_mod module
Lahc_pci:1:3:0: Reading SEEPROM...oading sd_mod modone.
dule
Loading aiahc_pci:1:3:0: Manual LVD Termination
c7xxx module
ahc_pci:1:3:0: BIOS eeprom is present
ahc_pci:1:3:0: Secondary High byte termination Enabled
ahc_pci:1:3:0: Secondary Low byte termination Enabled
ahc_pci:1:3:0: Primary Low Byte termination Enabled
ahc_pci:1:3:0: Primary High Byte termination Enabled
ahc_pci:1:3:0: Downloading Sequencer Program... 423 instructions
downloaded
ahc_pci:1:3:0: Features 0x1def6, Bugs 0x40, Flags 0x20485560
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.3.4
        <Adaptec aic7892 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

blk: queue f7ecb374, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:0:0): Sending PPR bus_width 1, period 9, offset 7f, ppr_options
2
(scsi0:A:0:0): Received PPR width 1, period 9, offset 3f,options 2
        Filtered to width 1, period 9, offset 3f, options 2
(scsi0:A:0): 6.600MB/s transfers (16bit)
scsi0: target 0 using 16bit transfers
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
scsi0: target 0 synchronous at 80.0MHz DT, offset = 0x3f
(scsi0:A:0): 80.000MB/s transfers (80.000MHz DT, offset 63)
scsi0: target 0 using 8bit transfers
(scsi0:A:0): 3.300MB/s transfers
scsi0: target 0 using asynchronous transfers
scsi0: Unexpected busfree while idle
SEQADDR == 0x1
scsi0: Unexpected busfree while idle
SEQADDR == 0x1
scsi0: Unexpected busfree while idle
SEQADDR == 0x1
scsi0: Unexpected busfree while idle
SEQADDR == 0x1

wait 30-40 minutes

scsi0: Unexpected busfree while idle
SEQADDR == 0x1
(scsi0:A:4:0): Sending PPR bus_width 1, period 9, offset 7f, ppr_options
2
(scsi0:A:4:0): Received PPR width 1, period 9, offset 3f,options 2
        Filtered to width 1, period 9, offset 3f, options 2
(scsi0:A:4): 6.600MB/s transfers (16bit)
scsi0: target 4 using 16bit transfers
(scsi0:A:4): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
scsi0: target 4 synchronous at 80.0MHz DT, offset = 0x3f
  Vendor: IBM       Model: DDYS-T18350N      Rev: S9YB
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7ecb474, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:4): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
scsi0:A:4:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 4, lun 0
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda:
Mounting /proc filesystem
Creating root device
Mounting root filesystem
mount: error 6 mounting ext2
pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
Freeing unused kernel memory: 116k freed
Kernel panic: No init found.  Try passing init= option to kernel.

A good boot looks like the following:

Loading aic7xxx module
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7892 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

blk: queue c364fe14, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: IBM       Model: DDYS-T18350N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7c9a014, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: IBM       Model: DDYS-T18350N      Rev: S9YB
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7c9a414, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
scsi0:A:4:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 4, lun 0
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
(scsi0:A:4): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
 sdb:
Mounting /proc filesystem



On Fri, 2004-01-16 at 15:59, Stephen Smoogen wrote:
> On Fri, 2004-01-16 at 15:39, Justin T. Gibbs wrote:
> > > Booting problems with aic7xxx with stock kernel 2.4.24.
> > 
> > ...
> > 
> > > Unexpected busfree while idle
> > > SEQ 0x01
> > 
> > A problem with similar symptoms was corrected in driver version 6.2.37
> > back in August of last year.  Can you try using the latest driver source
> > from here:
> > 
> > 	http://people.FreeBSD.org/~gibbs/linux/SRC/
> > 
> > and see if your problem persists?  The aic79xx driver archive at the
> > above location includes both the aic7xxx and aic79xx drivers.  If this
> > does not resolve your problem there are other debugging options we can
> > enable that may aid in tracking down the problem.
> 
> Hi I did that already; sorry for not being clearer about it in the bug
> report. For some of my systems I had patched my kernel to have the
> latest source code from your site for our aic79xx machines. I ran that
> kernel on these other systems and it locked up in a similar state.
> 
>  I am ready for the additional debugging options :). Thanks for your
> quick response.
-- 
Stephen John Smoogen		smoogen@lanl.gov
Los Alamos National Lab  CCN-5 Sched 5/40  PH: 4-0645
Ta-03 SM-1498 MailStop B255 DP 10S  Los Alamos, NM 87545
-- So shines a good deed in a weary world. = Willy Wonka --

