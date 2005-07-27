Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVG0NjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVG0NjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 09:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVG0NjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 09:39:24 -0400
Received: from p509153F3.dip.t-dialin.net ([80.145.83.243]:62858 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id S262241AbVG0NjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 09:39:23 -0400
Date: Wed, 27 Jul 2005 15:39:05 +0200
From: Patrick Mau <mau@oscar.ping.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Question about "aic7yyy Domain Validation"
Message-ID: <20050727133905.GA20065@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo everyone,

I have a small question regarding the Domain Validation debugging
output from my machine. It has four identical IBM drives, two on each
channel.

There's always a message saying "target0:0:0: wide asynchronous.", even
without "verbose" booting. But in the verbose output below, there is
also a line saying 

scsi0: target 0 synchronous at 80.0MHz DT, offset = 0x3f

I assume that the first line should be considered as a debugging
message, but the normally not printed second line is the actual device
negotiation.

Am I correct about that? 
Are the drives running at 160MB/s synchronous ?

Would a patch be acceptable that removes the "wide asychronous" line
and would instead output the final settings ?

Thanks for your comments,
Patrick


PS: I will only include the first DV output with "aic7xxx=verbose"
Hopefully it's not too long:

Uniform CD-ROM driver Revision: 3.20
ahc_pci:2:10:0: Reading SEEPROM...done.
ahc_pci:2:10:0: Manual SE Termination
ahc_pci:2:10:0: BIOS eeprom is present
ahc_pci:2:10:0: Primary Low Byte termination Enabled
ahc_pci:2:10:0: Primary High Byte termination Enabled
ahc_pci:2:10:0: Downloading Sequencer Program... 422 instructions downloaded
ahc_pci:2:10:0: Features 0x1fef6, Bugs 0x40, Flags 0x20485500
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi0: Slave Alloc 0
(scsi0:A:0:0): Sending WDTR 0
(scsi0:A:0:0): Received WDTR 0 filtered to 0
 target0:0:0: FAST-5 SCSI 1.0 MB/s ST (1020 ns, offset 255)
scsi0: target 0 using 8bit transfers
(scsi0:A:0:0): Sending SDTR period 45, offset 0
(scsi0:A:0:0): Received SDTR period 45, offset 0
	Filtered to period 0, offset 0
 target0:0:0: asynchronous.
scsi0: target 0 using asynchronous transfers
  Vendor: IBM       Model: IC35L036UCD210-0  Rev: S5BA
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0: Slave Configure 0
 target0:0:0: asynchronous.
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
 target0:0:0: Beginning Domain Validation
(scsi0:A:0:0): Sending WDTR 1
(scsi0:A:0:0): Received WDTR 1 filtered to 1
 target0:0:0: FAST-5 WIDE SCSI 2.0 MB/s ST (1020 ns, offset 255)
scsi0: target 0 using 16bit transfers
(scsi0:A:0:0): Sending SDTR period 45, offset 0
(scsi0:A:0:0): Received SDTR period 45, offset 0
	Filtered to period 0, offset 0
 target0:0:0: wide asynchronous.
scsi0: target 0 using asynchronous transfers
(scsi0:A:0:0): Sending PPR bus_width 1, period 9, offset 7f, ppr_options 2
(scsi0:A:0:0): Received PPR width 1, period 9, offset 3f,options 2
	Filtered to width 1, period 9, offset 3f, options 2
 target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s ST (12.5 ns, offset 63)
scsi0: target 0 synchronous at 80.0MHz DT, offset = 0x3f
 target0:0:0: Ending Domain Validation
