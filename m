Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276112AbRI1PLI>; Fri, 28 Sep 2001 11:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276109AbRI1PKt>; Fri, 28 Sep 2001 11:10:49 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:25866 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S276108AbRI1PKd>; Fri, 28 Sep 2001 11:10:33 -0400
Date: Fri, 28 Sep 2001 14:54:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: clemens <therapy@endorphin.org>
Cc: David Grant <davidgrant79@hotmail.com>,
        Steven Joerger <steven@spock.2y.net>, linux-kernel@vger.kernel.org
Subject: Re: ide drive problem?
Message-ID: <20010928145448.A21526@suse.cz>
In-Reply-To: <20010928041519.968EA4FA00@spock> <OE55yDnSI4nHp4PlNMu00004f47@hotmail.com> <20010928135222.A2722@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010928135222.A2722@ghanima.endorphin.org>; from therapy@endorphin.org on Fri, Sep 28, 2001 at 01:52:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 01:52:22PM +0200, clemens wrote:
> Hi David, Hi Steve
> 
> i get:
> 
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> on:
> 
> Linux version 2.4.9-ac7 (root@ghanima) (gcc version 2.95.4 20010902 (Debian
> prerelease)) #1 SMP Wed Sep 26 14:39:37 CEST 2001
> 
> HPT370: IDE controller on PCI bus 00 dev 98
> PCI: Found IRQ 15 for device 00:13.0
> HPT370: chipset revision 3
> HPT370: not 100% native mode: will probe irqs later
>     ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
>     ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
> hde: ST360021A, ATA DISK drive
> 
> even thou i have VT8363/8365 (=KT133) as north bridge, and VT82C686A as
> southbridge, at least the south bridge could not be blamed for that, since
> a. i don't even use it, hde is my hpt370 controller, and
> b. it's the A revision and not the infamous 686B revision (see
> http://www.viahardware.com/686bfaq.shtm for more infos on "the" 686B bug)
> 
> what kernel, harddisc do you both have?
> 
> clemens
> 
> p.s.: i don't know if "BadCRC" has anything to do with bad blocks, but
> /sbin/badblocks doesn't even show a single bad block on my brand new seagate 
> disc, so i guess, that's not the source of the troubles.

It means that the drive detected a bad CRC on the UDMA transaction.
Unless these are frequent, they are harmless, since the transaction
will be retried..

-- 
Vojtech Pavlik
SuSE Labs
