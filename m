Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281416AbRLOBjc>; Fri, 14 Dec 2001 20:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281504AbRLOBjW>; Fri, 14 Dec 2001 20:39:22 -0500
Received: from chmls20.mediaone.net ([24.147.1.156]:32953 "EHLO
	chmls20.mediaone.net") by vger.kernel.org with ESMTP
	id <S281416AbRLOBjJ>; Fri, 14 Dec 2001 20:39:09 -0500
Subject: Re: Problems downgrading from Kernel 2.4.8 to 2.2.20
From: jlm <jsado@mediaone.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20011214235044.GB29591@emma1.emma.line.org>
In-Reply-To: <1008372849.273.8.camel@PC2> 
	<20011214235044.GB29591@emma1.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 14 Dec 2001 20:42:26 -0500
Message-Id: <1008380546.176.0.camel@PC2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-14 at 18:50, Matthias Andree wrote:
> On Fri, 14 Dec 2001, jlm wrote:
> 
> > I am trying to downgrade, to see if an issue with the 2.4.x series
> > kernel is also present in the 2.2.x series. I have successfully
> > downloaded, compiled and installed a 2.2.20 kernel and added the
> > necessary lines to lilo in order to have it as an option and to boot
> > into the same root partition as the 2.4.8 uses.
> > 
> > I am getting an error when I boot up 2.2.20. Right after the partition
> > check it says this:
> > Invalid session number or type of track
> 
> Now that looks strange. Show some context around this line.
I've copied pretty much every thing that I could:

hda: Maxtor 5T030h3, ATA DISK drive
hdb: ST320413A, ATA DISK drive
hdc: QUANTUM FIREBALL SE2.1A, ATA DISK drive
hdd: FX240S, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7, 0x3f6 on irq 14
ide1 at 0x170-px177, 0x376 on irq 15
hda: Maxtor 5T030h3, 29311MB w/2048kB Cache, CHS=59554/16/63
hdb: ST320413A, 19092MB w/512kB Cache, CHS=38792/16/63, (U)DMA
hdc: QUANTUM FIREBALL SE2.1A, 2014MB w/80kB Cache, CHS=4092/16/63,
(U)DMA
hdd: ATAPI 24x CD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC0 is a post-1991 82077
tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
eth0: ADMtek Centaur-P rev17 at 0xe400, 00:60:08:ED:34:1A, IRQ 5.
partitoin check:
hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdb: hdb1 hdb2 hdb3
hdc: [PTBL] [1023/64/63] hdc1 hdc2
Invalid session # or type of track
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
...

Compairing with dmesg from the current 2.4.16 kernel (I was using 2.4.8)
shows most lines to be nearly identical to what I've got written above.
Particularly, the partition check is exact, and so are the CHS values
for each of the drives. Possibly of note is that the eth0 address listed
in dmesg is 0xf0800000, not the 0xe400 shown above. The rest of the
differences are mostly driver revision numbers and reformatting of
lines.
> 
> > hda: lost interrupt
> 
> That looks stranger. I'd suggest to try Andre's IDE patch from any
> kernel.org mirror, /pub/linux/kernel/people/hedrick, but it seems
> there's no 2.2.20 ide patch yet.

-- 
MACINTOSH = Machine Always Crashes If Not The Operating System Hangs
"Life would be so much easier if we could just look at the source code."
- Dave Olson

