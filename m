Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267770AbUIXDsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbUIXDsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUIXDq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:46:28 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:57736 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266912AbUIWUa5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:30:57 -0400
From: tabris <tabris@tabris.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: undecoded slave?
Date: Thu, 23 Sep 2004 16:30:46 -0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200409222357.39492.tabris@tabris.net> <200409231314.55547.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200409231314.55547.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409231630.49153.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 23 September 2004 7:14 am, Bartlomiej Zolnierkiewicz wrote:
> [ use linux-ide@vger.kernel.org for ATA stuff ]
>
> On Thursday 23 September 2004 05:57, tabris wrote:
> > Probing IDE interface ide3...
> > hdg: Maxtor 4D060H3, ATA DISK drive
> > hdh: Maxtor 4D060H3, ATA DISK drive
> > ide-probe: ignoring undecoded slave
> >
> > Booted 2.6.9-rc2-mm2, and I no longer have an hdh. the error above
> > seems to be the only [stated] reason why.
>
> Please send hdparm -I output for both drives.

As you can see, both drives are the same brand/size/model.
Both are connected to the PDC20265 on my ASUS A7V266-E motherboard.

/dev/hdg:

ATA device, with non-removable media
        Model Number:       Maxtor 4D060H3
        Serial Number:      D3000000
        Firmware Revision:  DAK019K0
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 0
        Supported: 6 5 4 3
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      1
        sectors/track   63      63
        --
        CHS current addressable sectors:    4128705
        LBA    user addressable sectors:  120069936
        LBA48  user addressable sectors:  120069936
        device size with M = 1024*1024:       58627 MBytes
        device size with M = 1000*1000:       61475 MBytes (61 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 57     Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific 
minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
           *    SMART feature set
           *    Device Configuration Overlay feature set
           *    48-bit Address feature set
                Automatic Acoustic Management feature set
                SET MAX security extension
                Advanced Power Management feature set
           *    DOWNLOAD MICROCODE cmd
           *    SMART self-test
           *    SMART error logging
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct


/dev/hdh:

ATA device, with non-removable media
        Model Number:       Maxtor 4D060H3
        Serial Number:      D3000000
        Firmware Revision:  DAH017K0
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 0
        Supported: 6 5 4 3
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  120069936
        device size with M = 1024*1024:       58627 MBytes
        device size with M = 1000*1000:       61475 MBytes (61 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 57     Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific 
minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
           *    SMART feature set
           *    Device Configuration Overlay feature set
                Automatic Acoustic Management feature set
                SET MAX security extension
                Advanced Power Management feature set
           *    DOWNLOAD MICROCODE cmd
           *    SMART self-test
           *    SMART error logging
HW reset results:
        CBLID- above Vih
        Device num = 1 determined by the jumper
Checksum: correct


- --
tabris
- -
Tomorrow will be cancelled due to lack of interest.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBUzJ41U5ZaPMbKQcRAng0AJ4n5kAJCXwiO2JYu6wKa5RyS47+bQCfUisK
2d1CLQM7Lx1HlHZ6fKswZVk=
=oNxb
-----END PGP SIGNATURE-----
