Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132668AbRDBKdg>; Mon, 2 Apr 2001 06:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132670AbRDBKd0>; Mon, 2 Apr 2001 06:33:26 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:23352 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S132668AbRDBKdR> convert rfc822-to-8bit; Mon, 2 Apr 2001 06:33:17 -0400
Date: Mon, 2 Apr 2001 12:32:16 +0200
From: Christian Zander <phoenix@minion.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3 - new aic7xxx driver
Message-ID: <20010402123216.A4268@chronos>
Reply-To: Christian Zander <phoenix@minion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
X-Accept-Language: de, en, fr
X-Operating-System: Gnu/Linux [2.4.2][i686]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc: to my email address, I'm not subscribed to the list.

The new aic7xxx driver included with 2.4.3 doesn't appear to be
working properly with my setup. While the previous driver worked
flawlessly, the new code doesn't set up all of my scsi devices. This
is an excerpt from kernel messages as produced by the 2.4.2 driver:

: (scsi0) <Adaptec AIC-7850 SCSI host adapter> found at PCI 0/11/0
: (scsi0) Narrow Channel, SCSI ID=7, 3/255 SCBs
: (scsi0) Downloading sequencer code... 415 instructions downloaded
: scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 
          5.2.1/5.2.0
:        <Adaptec AIC-7850 SCSI host adapter>
: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, offset 8.
:   Vendor: PIONEER   Model: DVD-ROM DVD-303R Rev: 2.00
:   Type:   CD-ROM ANSI SCSI revision: 02
: (scsi0:0:2:0) Synchronous at 10.0 Mbyte/sec, offset 15.
:   Vendor: TEAC      Model: CD-R55S Rev: 1.0F
:   Type:   CD-ROM ANSI SCSI revision: 02
: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
: Detected scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
: sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
: Uniform CD-ROM driver Revision: 3.12
: sr1: scsi-1 drive

With the new driver it looks like this:

: SCSI subsystem driver Revision: 1.00
: ahc_pci:0:11:0: Host Adapter Bios disabled. Using default SCSI 
  device parameters
: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
:         <Adaptec 2902/04/10/15/20/30C SCSI adapter>
:         aic7850: Single Channel A, SCSI Id=7, 3/255 SCBs
: 
:   Vendor: TEAC      Model: CD-R55S Rev: 1.0F
:   Type:   CD-ROM ANSI SCSI revision: 02
: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
: (scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 15)
: sr0: scsi-1 drive
: Uniform CD-ROM driver Revision: 3.12

Same results with the 6.1.8 driver revision.

Thanks,

--
----------------------------------------------------------------------
 christian zander              paranoia, n.:  a healthy understanding
 zander@hdz.uni-dortmund.de    of the way the universe works.
----------------------------------------------------------------------

