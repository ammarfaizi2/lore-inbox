Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313818AbSDPSoF>; Tue, 16 Apr 2002 14:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313820AbSDPSoE>; Tue, 16 Apr 2002 14:44:04 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:14404 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313818AbSDPSoD>;
	Tue, 16 Apr 2002 14:44:03 -0400
Date: Tue, 16 Apr 2002 20:43:29 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org,
        Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: [PATCH] IDE TCQ #4
Message-Id: <20020416204329.4c71102f.sebastian.droege@gmx.de>
In-Reply-To: <20020416180914.GR1097@suse.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.jPOuSAbgMMj,2X"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.jPOuSAbgMMj,2X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2002 20:09:14 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Tue, Apr 16 2002, Sebastian Droege wrote:
> > Hi,
> > just one short question:
> > My hda supports TCQ but my hdb doesn't
> > Is it safe to enable TCQ in kernel config?
> 
> yes, should be safe.
> 
> -- 
> Jens Axboe
> 
Ok it really works ;)
But there's another problem in 2.5.8 with ide patches until 37 applied (they don't appear with 2.5.8 and ide patches until 35), the unexpected interrupts (look at the relevant dmesg output at the bottom). They appear with and without TCQ enabled.
If you need more informations, just ask :)

Bye

Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
Intel Corp. 82371AB PIIX4 IDE: IDE controller on PCI slot 00:07.1
Intel Corp. 82371AB PIIX4 IDE: chipset revision 1
Intel Corp. 82371AB PIIX4 IDE: not 100% native mode: will probe irqs later
PIIX: Intel Corp. 82371AB PIIX4 IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTTA-351010, ATA DISK drive
hdb: WDC WD800BB-00BSA0, ATA DISK drive
hdc: CD-W512EB, ATAPI CD/DVD-ROM drive
hdd: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide: unexpected interrupt 0 14
hda: tagged command queueing enabled, command queue depth 32
hda: 19807200 sectors (10141 MB) w/466KiB Cache, CHS=19650/16/63, UDMA(33)
ide: unexpected interrupt 0 14
hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(33)
ide: unexpected interrupt 1 15
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [1232/255/63] p1 p2
 /dev/ide/host0/bus0/target1/lun0: p1 p2
--=.jPOuSAbgMMj,2X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8vHDUe9FFpVVDScsRAk0dAKCxYWT3vZE3ej292MUk+Kyk+c5cAwCg6sZZ
bvwlzbDplNkx2pDtK17fgzo=
=x+9n
-----END PGP SIGNATURE-----

--=.jPOuSAbgMMj,2X--

