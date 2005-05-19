Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbVESL2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVESL2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 07:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVESL2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 07:28:20 -0400
Received: from relay01.pair.com ([209.68.5.15]:6149 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S262365AbVESL1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 07:27:46 -0400
X-pair-Authenticated: 24.241.238.70
Message-ID: <428C7830.5070302@cybsft.com>
Date: Thu, 19 May 2005 06:27:44 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>, gregoire.favre@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
References: <20050516085832.GA9558@gmail.com>	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>	 <1116340465.4989.2.camel@mulgrave>  <20050517170824.GA3931@in.ibm.com>	 <1116354894.4989.42.camel@mulgrave>  <428C030E.8030102@cybsft.com> <1116476630.5867.2.camel@mulgrave>
In-Reply-To: <1116476630.5867.2.camel@mulgrave>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Wed, 2005-05-18 at 22:07 -0500, K.R. Foley wrote: 
> 
>>This also solves my problem that I reported in this thread
>>http://marc.theaimsgroup.com/?l=linux-scsi&m=111422854418964&w=2
> 
> 
> OK, I think the patch below is the extract of this.  Could you see if it
> works by simply patching vanilla 2.6.12-rc4 with no other SCSI patches
> (if it does, I'll push it for 2.6.12 final).
> 
> James
<snip>

James,

Below is what I get WHEN IT BOOTS. There are also a couple more logs and
notes in between.

#########################################################################
May 19 06:04:22 porky kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.2.36
May 19 06:04:22 porky kernel:         <Adaptec aic7899 Ultra160 SCSI
adapter>
May 19 06:04:22 porky kernel:         aic7899: Ultra160 Wide Channel A,
SCSI Id=7, 32/253 SCBs
May 19 06:04:22 porky kernel:
May 19 06:04:22 porky kernel:   Vendor: QUANTUM   Model:
ATLAS10K2-TY092L  Rev: DA40
May 19 06:04:22 porky kernel:   Type:   Direct-Access
   ANSI SCSI revision: 03
May 19 06:04:22 porky kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
May 19 06:04:22 porky kernel:  target0:0:0: Beginning Domain Validation
May 19 06:04:22 porky kernel: (scsi0:A:0): 6.600MB/s transfers (16bit)
May 19 06:04:22 porky kernel: (scsi0:A:0): 80.000MB/s transfers
(40.000MHz, offset 127, 16bit)
May 19 06:04:22 porky kernel:  target0:0:0: Ending Domain Validation
May 19 06:04:22 porky kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.2.36
May 19 06:04:22 porky kernel:         <Adaptec aic7899 Ultra160 SCSI
adapter>
May 19 06:04:22 porky kernel:         aic7899: Ultra160 Wide Channel B,
SCSI Id=7, 32/253 SCBs
May 19 06:04:22 porky kernel:
May 19 06:04:22 porky kernel:   Vendor: SEAGATE   Model: SX118273LC
   Rev: 6679
May 19 06:04:22 porky kernel:   Type:   Direct-Access
   ANSI SCSI revision: 02
May 19 06:04:22 porky kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
May 19 06:04:22 porky kernel:  target1:0:0: Beginning Domain Validation
May 19 06:04:22 porky kernel: (scsi1:A:0): 6.600MB/s transfers (16bit)
May 19 06:04:22 porky kernel: (scsi1:A:0:0): parity error detected in
Data-in phase. SEQADDR(0x1a6) SCSIRATE(0x80)
May 19 06:04:22 porky kernel: (scsi1:A:0:0): parity error detected in
Message-in phase. SEQADDR(0x1a6) SCSIRATE(0x80)
May 19 06:04:22 porky kernel: (scsi1:A:0:0): Unexpected busfree in
Message-out phase
May 19 06:04:22 porky kernel: SEQADDR == 0x16b
May 19 06:04:22 porky kernel:  target1:0:0: Wide Transfers Fail
May 19 06:04:22 porky kernel: (scsi1:A:0): 3.300MB/s transfers
May 19 06:04:22 porky kernel:  target1:0:0: Domain Validation skipping
write tests
May 19 06:04:22 porky kernel: (scsi1:A:0): 20.000MB/s transfers
(20.000MHz, offset 15)
May 19 06:04:22 porky kernel:  target1:0:0: Ending Domain Validation
May 19 06:04:22 porky kernel: SCSI device sda: 17783239 512-byte hdwr
sectors (9105 MB)
May 19 06:04:22 porky kernel: SCSI device sda: drive cache: write back
May 19 06:04:22 porky kernel: SCSI device sda: 17783239 512-byte hdwr
sectors (9105 MB)
May 19 06:04:22 porky kernel: SCSI device sda: drive cache: write back
May 19 06:04:22 porky kernel:  sda: sda1 sda2 sda3
May 19 06:04:22 porky kernel: Attached scsi disk sda at scsi0, channel
0, id 0, lun 0
May 19 06:04:22 porky kernel: SCSI device sdb: 35566480 512-byte hdwr
sectors (18210 MB)
May 19 06:04:22 porky kernel: SCSI device sdb: drive cache: write through
May 19 06:04:22 porky kernel: SCSI device sdb: 35566480 512-byte hdwr
sectors (18210 MB)
May 19 06:04:22 porky kernel: SCSI device sdb: drive cache: write through
May 19 01:04:03 porky rc.sysinit: -e
May 19 06:04:22 porky kernel:  sdb: sdb1
May 19 01:04:04 porky udevsend[1251]: starting udevd daemon
May 19 06:04:22 porky kernel: Attached scsi disk sdb at scsi1, channel
0, id 0, lun 0
May 19 01:04:05 porky scsi.agent[1263]: disk at
/devices/pci0000:00/0000:00:1e.0/0000:04:05.0/host0/target0:0:0/0:0:0:0
May 19 06:04:23 porky kernel: Attached scsi generic sg0 at scsi0,
channel 0, id 0, lun 0,  type 0
May 19 01:04:05 porky scsi.agent[1288]: disk at
/devices/pci0000:00/0000:00:1e.0/0000:04:05.1/host1/target1:0:0/1:0:0:0
May 19 06:04:23 porky kernel: Attached scsi generic sg1 at scsi1,
channel 0, id 0, lun 0,  type 0

###############################################################################

Even with the patch that you posted last night something still isn't
quite right. Notice in the output below that the faster drive is setup
at 80MB/s instead of 160MB/s. It's like going back to the days before
U160 stuff worked properly :)

###############################################################################
May 18 21:56:25 porky kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.2.36
May 18 21:56:25 porky kernel:         <Adaptec aic7899 Ultra160 SCSI
adapter>
May 18 21:56:25 porky kernel:         aic7899: Ultra160 Wide Channel A,
SCSI Id=7, 32/253 SCBs
May 18 21:56:25 porky kernel:
May 18 21:56:25 porky kernel:   Vendor: QUANTUM   Model:
ATLAS10K2-TY092L  Rev: DA40
May 18 21:56:25 porky kernel:   Type:   Direct-Access
   ANSI SCSI revision: 03
May 18 21:56:25 porky kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
May 18 21:56:25 porky kernel:  target0:0:0: Beginning Domain Validation
May 18 21:56:25 porky kernel: WIDTH IS 1
May 18 21:56:25 porky kernel: (scsi0:A:0): 6.600MB/s transfers (16bit)
May 18 21:56:25 porky kernel: (scsi0:A:0): 80.000MB/s transfers
(40.000MHz, offset 127, 16bit)
May 18 21:56:25 porky kernel:  target0:0:0: Ending Domain Validation
May 18 21:56:25 porky kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.2.36
May 18 21:56:25 porky kernel:         <Adaptec aic7899 Ultra160 SCSI
adapter>
May 18 21:56:25 porky kernel:         aic7899: Ultra160 Wide Channel B,
SCSI Id=7, 32/253 SCBs
May 18 21:56:25 porky kernel:
May 18 21:56:25 porky kernel:   Vendor: SEAGATE   Model: SX118273LC
   Rev: 6679
May 18 21:56:25 porky kernel:   Type:   Direct-Access
   ANSI SCSI revision: 02
May 18 21:56:25 porky kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
May 18 21:56:25 porky kernel:  target1:0:0: Beginning Domain Validation
May 18 21:56:25 porky kernel:  target1:0:0: Domain Validation skipping
write tests
May 18 21:56:25 porky kernel: (scsi1:A:0): 20.000MB/s transfers
(20.000MHz, offset 15)
May 18 21:56:25 porky kernel:  target1:0:0: Ending Domain Validation
May 18 21:56:25 porky kernel: SCSI device sda: 17783239 512-byte hdwr
sectors (9105 MB)
May 18 21:56:25 porky kernel: SCSI device sda: drive cache: write back
May 18 21:56:25 porky kernel: SCSI device sda: 17783239 512-byte hdwr
sectors (9105 MB)
May 18 21:56:25 porky kernel: SCSI device sda: drive cache: write back
May 18 21:56:25 porky kernel:  sda: sda1 sda2 sda3
May 18 21:56:25 porky kernel: Attached scsi disk sda at scsi0, channel
0, id 0, lun 0
May 18 21:56:25 porky kernel: SCSI device sdb: 35566480 512-byte hdwr
sectors (18210 MB)
May 18 21:56:25 porky kernel: SCSI device sdb: drive cache: write through
May 18 16:56:04 porky rc.sysinit: -e
May 18 21:56:25 porky kernel: SCSI device sdb: 35566480 512-byte hdwr
sectors (18210 MB)
May 18 16:56:06 porky udevsend[1281]: starting udevd daemon
May 18 21:56:25 porky kernel: SCSI device sdb: drive cache: write through
May 18 16:56:06 porky scsi.agent[1293]: disk at
/devices/pci0000:00/0000:00:1e.0/0000:04:05.0/host0/target0:0:0/0:0:0:0
May 18 21:56:25 porky kernel:  sdb: sdb1
May 18 16:56:06 porky scsi.agent[1318]: disk at
/devices/pci0000:00/0000:00:1e.0/0000:04:05.1/host1/target1:0:0/1:0:0:0
May 18 21:56:25 porky kernel: Attached scsi disk sdb at scsi1, channel
0, id 0, lun 0
May 18 16:56:06 porky udevsend[1334]: starting udevd daemon
May 18 21:56:25 porky kernel: Attached scsi generic sg0 at scsi0,
channel 0, id 0, lun 0,  type 0
May 18 16:56:11 porky start_udev: Starting udev:  succeeded
May 18 21:56:25 porky kernel: Attached scsi generic sg1 at scsi1,
channel 0, id 0, lun 0,  type 0

#################################################################################

And then finally the output this morning of booting 2.6.12-rc2 (with RT
patches applied, which is irrelevant to this conversation). This one
does properly setup all of the drives.

#################################################################################
May 19 05:52:00 porky kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.2.36
May 19 05:52:00 porky kernel:         <Adaptec aic7899 Ultra160 SCSI
adapter>
May 19 05:52:00 porky kernel:         aic7899: Ultra160 Wide Channel A,
SCSI Id=7, 32/253 SCBs
May 19 05:52:00 porky kernel:
May 19 05:52:00 porky kernel: (scsi0:A:0): 160.000MB/s transfers
(80.000MHz DT, offset 127, 16bit)
May 19 05:52:00 porky kernel:   Vendor: QUANTUM   Model:
ATLAS10K2-TY092L  Rev: DA40
May 19 05:52:00 porky kernel:   Type:   Direct-Access
   ANSI SCSI revision: 03
May 19 05:52:00 porky kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
May 19 05:52:00 porky kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.2.36
May 19 05:52:00 porky kernel:         <Adaptec aic7899 Ultra160 SCSI
adapter>
May 19 05:52:00 porky kernel:         aic7899: Ultra160 Wide Channel B,
SCSI Id=7, 32/253 SCBs
May 19 05:52:00 porky kernel:
May 19 05:52:00 porky kernel: (scsi1:A:0): 20.000MB/s transfers
(20.000MHz, offset 15)
May 19 05:52:00 porky kernel:   Vendor: SEAGATE   Model: SX118273LC
   Rev: 6679
May 19 05:52:00 porky netfs: Mounting other filesystems:  succeeded
May 19 05:52:00 porky kernel:   Type:   Direct-Access
   ANSI SCSI revision: 02
May 19 05:52:00 porky kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
May 19 05:52:00 porky kernel: SCSI device sda: 17783239 512-byte hdwr
sectors (9105 MB)
May 19 05:52:00 porky kernel: SCSI device sda: drive cache: write back
May 19 05:52:00 porky kernel: SCSI device sda: 17783239 512-byte hdwr
sectors (9105 MB)
May 19 05:52:00 porky kernel: SCSI device sda: drive cache: write back
May 19 05:52:00 porky kernel:  sda: sda1 sda2 sda3
May 19 05:52:00 porky kernel: Attached scsi disk sda at scsi0, channel
0, id 0, lun 0


-- 
   kr
