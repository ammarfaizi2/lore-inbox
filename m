Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbRE3Pl2>; Wed, 30 May 2001 11:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261471AbRE3PlS>; Wed, 30 May 2001 11:41:18 -0400
Received: from nick.dcs.qmw.ac.uk ([138.37.88.61]:62991 "EHLO dcs.qmw.ac.uk")
	by vger.kernel.org with ESMTP id <S261459AbRE3PlP>;
	Wed, 30 May 2001 11:41:15 -0400
Date: Wed, 30 May 2001 16:41:05 +0100 (BST)
From: Matt Bernstein <mb@dcs.qmw.ac.uk>
To: <linux-xfs@oss.sgi.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Oops with 2.4.3-XFS
In-Reply-To: <Pine.LNX.4.33.0105161159400.2837-100000@nick.dcs.qmw.ac.uk>
Message-ID: <Pine.LNX.4.33.0105301632280.26680-100000@nick.dcs.qmw.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

After some more testing it's entirely plausible (though unfortunately we
don't have anything conclusive) that we have a hardware problem.

Having added a new drive (hdc as reported below) and booted root=/dev/hdc2
with nothing mounted on hda, we have thus far failed to recreate the crash.

VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD400BB-00AUA1, ATA DISK drive
hdc: FUJITSU MPG3102AT E, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(66)
hdc: 20015856 sectors (10248 MB) w/512KiB Cache, CHS=19857/16/63, UDMA(33)

On May 16 Matt Bernstein wrote:

>We have managed to get a Debian potato system (with the 2.4 updates from
>http://people.debian.org/~bunk/debian plus xfs-tools which we imported
>from woody) to run 2.4.3-XFS.
>
>However, in testing a directory with lots (~177000) of files, we get the
>following oops (copied by hand, and run through ksymoops on a Red Hat box
>since the Debian one segfaulted :( )
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7FRSV1vU/2MhEp5cRApffAKDJcNLh6pp/iXyHjdWRC/x/zpabfwCgszG0
6mClfT2pCZwNjo2etYuI0mI=
=hE/Z
-----END PGP SIGNATURE-----

