Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRCTUUd>; Tue, 20 Mar 2001 15:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130793AbRCTUUX>; Tue, 20 Mar 2001 15:20:23 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:65032 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130768AbRCTUUO>; Tue, 20 Mar 2001 15:20:14 -0500
X-Apparently-From: <quintaq@yahoo.co.uk>
Date: Tue, 20 Mar 2001 20:21:41 +0000
From: quintaq@yahoo.co.uk
To: <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <3AB79464.A7A95A54@coplanar.net>
In-Reply-To: <20010318165246Z131240-406+1417@vger.kernel.org> <3AB65C51.3DF150E5@bigfoot.com> <3AB65F14.26628BEF@coplanar.net> <20010319222113Z131588-406+1752@vger.kernel.org> <3AB7811D.97601E82@internet-factory.de>
	<3AB79464.A7A95A54@coplanar.net>
Reply-To: <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.4.62 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010320202020Z130768-406+2207@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First, thank you very much Mark, Tim, Jeremy and Holger for your continuing contributions which, I think, are at last casting some light on my "problem".

> Yes this is why I originally replied to the post... but he's not using a
> PIIXx at
> all,
> but the IDE chip on an Intel 815 motherboard.  I'm not sure if they use
> the same
> driver
> , but I don't think so.
> 

I found a helpful post from Peter Denison on 6th January this year which suggests that it is at least the same driver.

"Description:
Includes new PCI device IDs for the Intel i815E chipset, and corrects some
of the names for the associated parts of the chipset. This has effects in
the EEPro100 network driver and the PCI IDE driver.
Detail & Justification:
The Intel ICH2 (I/O Controller Hub 2) is used in several chipsets, not
just the 820 (Camino) chipset it is accredited to in the PCI ID database.
Nor is the IDE portion of the ICH2 really a PIIX4 chip, though it is very
similar and PIIX driver works on both. These changes are just
internal macro naming and minor user interface tweaks."


> try hdparm -t /dev/hda1 instead of hda5 (if those are on opposite ends
> of the
> disk)
> 
> include output of fdisk so we can see partition layout, and results of
> hdparm on
> different areas.

Here is my fdisk output :

Disk /dev/hda: 255 heads, 63 sectors, 3737 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1       932   7486258+   b  Win95 FAT32
/dev/hda2           933      3737  22531162+   5  Extended
/dev/hda5           933       935     24066   83  Linux
/dev/hda6           936       952    136521   82  Linux swap
/dev/hda7           953      3737  22370481   83  Linux


I also ran hdparm -tT /dev/hda1:
 
Timing buffer-cache reads:   128 MB in  1.28 seconds =100.00 MB/sec
 Timing buffered disk reads:  64 MB in  4.35 seconds = 14.71 MB/sec

Which obviously gives much the same result as my usual hdparm -tT /dev/hda

I then tried hdparm -tT /dev/hda7:

 Timing buffer-cache reads:   128 MB in  1.28 seconds =100.00 MB/sec
 Timing buffered disk reads:  64 MB in  2.12 seconds = 30.19 MB/sec

As you would expect, I get almost identical results with several repetitions.

Does this solve the mystery ?

Regards,

Geoff

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

