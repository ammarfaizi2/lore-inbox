Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbTIPVXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 17:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbTIPVXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 17:23:53 -0400
Received: from m23.limsi.fr ([192.44.78.23]:13015 "EHLO m23.limsi.fr")
	by vger.kernel.org with ESMTP id S262053AbTIPVXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 17:23:43 -0400
Date: Tue, 16 Sep 2003 23:23:02 +0200
From: Olivier Galibert <olivier.galibert@limsi.fr>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephan von Krawczynski <skraw@ithnet.com>, neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030916212301.GC17045@m23.limsi.fr>
References: <20030916195345.GB68728@dspnet.fr.eu.org> <Pine.LNX.4.44.0309161814410.15569-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309161814410.15569-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 06:16:58PM -0300, Marcelo Tosatti wrote:
> Which card and driver are you using for IO? 3ware?

  Bus  6, device   2, function  0:
    SCSI storage controller: Adaptec AIC-7902 U320 (rev 3).
  Bus  6, device   2, function  1:
    SCSI storage controller: Adaptec AIC-7902 U320 (#2) (rev 3).

0:
Adaptec AIC79xx driver version: 1.3.10
Adaptec AIC7902 Ultra320 SCSI adapter
aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
Allocated SCBs: 32, SG List Length: 85

Target 0 Negotiation Settings
        User: 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
        Goal: 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
        Curr: 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
        Transmission Errors 0
        Channel A Target 0 Lun 0 Settings
                Commands Queued 6712736
                Commands Active 0
                Command Openings 32
                Max Tagged Openings 32
                Device Queue Frozen Count 0

1:
Adaptec AIC79xx driver version: 1.3.10
Adaptec AIC7902 Ultra320 SCSI adapter
aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
Allocated SCBs: 64, SG List Length: 85

Serial EEPROM:
0x17c8 0x17c8 0x17c8 0x17c8 0x17c8 0x17c8 0x17c8 0x17c8 
0x17c8 0x17c8 0x17c8 0x17c8 0x17c8 0x17c8 0x17c8 0x17c8 
0x09f4 0x0146 0x2807 0x0010 0xffff 0xffff 0xffff 0xffff 
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x0410 0xb3d7 

Target 0 Negotiation Settings
        User: 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, 16bit)
        Transmission Errors 0
        Channel A Target 0 Lun 0 Settings
                Commands Queued 5523328
                Commands Active 0
                Command Openings 32
                Max Tagged Openings 32
                Device Queue Frozen Count 0
        Channel A Target 0 Lun 1 Settings
                Commands Queued 14646734
                Commands Active 0
                Command Openings 32
                Max Tagged Openings 32
                Device Queue Frozen Count 0
Target 1 Negotiation Settings
        User: 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, 16bit)
        Transmission Errors 0
        Channel A Target 1 Lun 0 Settings
                Commands Queued 4
                Commands Active 0
                Command Openings 32
                Max Tagged Openings 32
                Device Queue Frozen Count 0
        Channel A Target 1 Lun 1 Settings
                Commands Queued 4
                Commands Active 0
                Command Openings 32
                Max Tagged Openings 32
                Device Queue Frozen Count 0

dmesg:
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs

scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs

blk: queue f7965018, I/O limit 524287Mb (mask 0x7fffffffff)
(scsi0:A:0): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
scsi1:A:0:0: DV failed to configure device.  Please file a bug report against this driver.
scsi1:A:1:0: DV failed to configure device.  Please file a bug report against this driver.
  Vendor: SEAGATE   Model: ST373307LC        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7913e18, I/O limit 524287Mb (mask 0x7fffffffff)
  Vendor: SUPER     Model: GEM318            Rev: 0   
  Type:   Processor                          ANSI SCSI revision: 02
blk: queue f7913018, I/O limit 524287Mb (mask 0x7fffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
(scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, 16bit)
  Vendor: transtec  Model:                   Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f78cbc18, I/O limit 524287Mb (mask 0x7fffffffff)
  Vendor: transtec  Model:                   Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f78cba18, I/O limit 524287Mb (mask 0x7fffffffff)
(scsi1:A:1): 160.000MB/s transfers (80.000MHz DT, 16bit)
  Vendor: transtec  Model:                   Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f78cb618, I/O limit 524287Mb (mask 0x7fffffffff)
  Vendor: transtec  Model:                   Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f78cb418, I/O limit 524287Mb (mask 0x7fffffffff)
scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
scsi1:A:0:1: Tagged Queuing enabled.  Depth 32
scsi1:A:1:0: Tagged Queuing enabled.  Depth 32
scsi1:A:1:1: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdc at scsi1, channel 0, id 0, lun 1
Attached scsi disk sdd at scsi1, channel 0, id 1, lun 0
Attached scsi disk sde at scsi1, channel 0, id 1, lun 1
SCSI device sda: 143374744 512-byte hdwr sectors (73408 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
SCSI device sdb: 2788016128 512-byte hdwr sectors (1427464 MB)
 sdb: sdb1
SCSI device sdc: 2788016128 512-byte hdwr sectors (1427464 MB)
 sdc: sdc1
SCSI device sdd: 4101521408 512-byte hdwr sectors (2099979 MB)
 sdd: sdd1
SCSI device sde: 4101521408 512-byte hdwr sectors (2099979 MB)
 sde: sde1
Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 3


> How much RAM do you have?

8Gb, currently down to 4Gb using mem=4G so that things actually work.

  OG.
