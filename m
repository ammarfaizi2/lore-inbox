Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTIZSYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 14:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbTIZSYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 14:24:39 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:34564 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S261555AbTIZSYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 14:24:31 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [BUG?] SIS IDE DMA errors
Date: Sat, 27 Sep 2003 02:22:00 +0800
User-Agent: KMail/1.5.2
Cc: M?ns Rullg?rd <mru@users.sourceforge.net>, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <200309262332.30091.mhf@linuxmail.org> <20030926165957.GA11150@ucw.cz>
In-Reply-To: <20030926165957.GA11150@ucw.cz>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309270222.00517.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 September 2003 00:59, Vojtech Pavlik wrote:
> On Fri, Sep 26, 2003 at 11:32:30PM +0800, Michael Frank wrote:
> > On Friday 26 September 2003 22:07, M?ns Rullg?rd wrote:
> > > Michael Frank <mhf@linuxmail.org> writes:
> > > 
> > > > Suspect chipset related issue which should be looked into.
> > > 
> > > That's what someone told me three months ago, too.  Nothing happened,
> > > though.
> > > 
> > 
> > OK, now that we are two, we copy the IDE maintainer ;)
> 
> Actually, it's me who wrote the 961 and 963 support. It works fine for
> most people. Did you check you cabling?

It is 80 conductor cable. 

2.4.22-pre7 was terrible for me - since pre9 or so it has almost gone away,
the cable is the same. These days I get the message only once a week or so.

Interesting is that we both use IBM drives albeit different generations.

I found the udma setting affects speed but not the dma-timer-expiry problem.

/dev/hda:

ATA device, with non-removable media
powers-up in standby; SET FEATURES subcmd spins-up.
        Model Number:       IC35L090AVV207-0
        Serial Number:      VNVC00G3CABSMD
        Firmware Revision:  V23OA63A
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 3a
        Supported: 6 5 4 3
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      1
        sectors/track   63      63
        --
        CHS current addressable sectors:    4128705
        LBA    user addressable sectors:  160836480
        LBA48  user addressable sectors:  160836480
        device size with M = 1024*1024:       78533 MBytes
        device size with M = 1000*1000:       82348 MBytes (82 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 52     Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
                Release interrupt
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command
           *    Device Configuration Overlay feature set
           *    48-bit Address feature set
                Automatic Acoustic Management feature set
                SET MAX security extension
                Address Offset Reserved Area Boot
                SET FEATURES subcommand required to spinup after power up
                Power-Up In Standby feature set
                Advanced Power Management feature set
           *    READ/WRITE DMA QUEUED
           *    General Purpose Logging feature set
           *    SMART self-test
           *    SMART error logging
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        46min for SECURITY ERASE UNIT.
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct


> > Regards
> > Michael

