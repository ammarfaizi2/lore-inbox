Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266017AbUFDVzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266017AbUFDVzp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 17:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265881AbUFDVzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 17:55:44 -0400
Received: from mail.aei.ca ([206.123.6.14]:1253 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S266017AbUFDVzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 17:55:41 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: DriveReady SeekComplete Error
Date: Fri, 4 Jun 2004 17:55:25 -0400
User-Agent: KMail/1.6.2
Cc: Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       mattia <mattia@nixlab.net>, Andrew Morton <akpm@osdl.org>
References: <E1BWBjw-0003QZ-1h@andromeda.hostvector.com> <200406041415.36566.bzolnier@elka.pw.edu.pl> <20040604121711.GZ1946@suse.de>
In-Reply-To: <20040604121711.GZ1946@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406041755.25993.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On June 4, 2004 08:17 am, Jens Axboe wrote:
> So we are back to step 1, why is his drive complaining. I'm guessing it
> doesn't have write back caching enabled and aborts the flush on those
> grounds - Ed, what is the output of hdparm -i on your booted system?

On 2.6.7-rc2 its:

Ed

root@bert:/home/knoppix# hdparm -iI /dev/hda

/dev/hda:

 Model=WDC AC26400R, FwRev=15.01J15, SerialNo=WD-WM6271600165
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=13328/15/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=512kB, MaxMultSect=16, MultSect=16
 CurCHS=13328/15/63, CurSects=12594960, LBA=yes, LBAsects=12594960
 IORDY=on/off, tPIO={min:160,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4

 * signifies the current active mode


ATA device, with non-removable media
        Model Number:       WDC AC26400R
        Serial Number:      WD-WM6271600165
        Firmware Revision:  15.01J15
Standards:
        Supported: 4 3 2 1
        Likely used: 4
Configuration:
        Logical         max     current
        cylinders       13328   13328
        heads           15      15
        sectors/track   63      63
        --
        bytes/track: 57600      bytes/sector: 600
        CHS current addressable sectors:   12594960
        LBA    user addressable sectors:   12594960
        device size with M = 1024*1024:        6149 MBytes
        device size with M = 1000*1000:        6448 MBytes (6 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 512.0kB    bytes avail on r/w long: 40     Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=160ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
           *    SMART feature set


