Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbTGTUXD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 16:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268256AbTGTUXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 16:23:03 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:12160 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S268231AbTGTUW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 16:22:59 -0400
Date: Sun, 20 Jul 2003 21:37:58 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org
Subject: SiI3112 lost interrupts
Message-ID: <20030720203758.GB1247@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nick: darksatanic
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   I bought a SiI3112-based SATA adapter (Adaptec 1210SA) and a 120Gb
drive for my computer a while ago. Unfortunately, I can't get them to
work in any sensible manner at the moment.

   I'm running 2.4.22-pre6-ac1, so by all accounts the chip should be
recognised (it is), and put into some form of DMA mode (it isn't) on
boot up. Any attempts to access the disk appear to work, but take a
_very_ long time, and cause lots of lost interrupts. 

   The relevant sections from the logs when the machine starts up look
like this:

Adaptec AAR-1210SA: IDE controller at PCI slot 00:0b.0
PCI: Found IRQ 10 for device 00:0b.0
Adaptec AAR-1210SA: chipset revision 2
Adaptec AAR-1210SA: not 100% native mode: will probe irqs later
ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
ALI15X3: IDE controller at PCI slot 00:0f.0
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
ide2: BM-DMA at 0x9000-0x9007, BIOS settings: hde:DMA, hdf:pio
ide3: BM-DMA at 0x9008-0x900f, BIOS settings: hdg:pio, hdh:pio
hda: ST3120026AS, ATA DISK drive
hdc: no response (status = 0xfe)
hde: Maxtor 90648D3, ATA DISK drive
blk: queue c0340238, I/O limit 4095Mb (mask 0xffffffff)
hdg: Pioneer DVD-ROM ATAPIModel DVD-120S, ATAPI CD/DVD-ROM drive
ide0 at 0xd4816080-0xd4816087,0xd481608a on irq 10
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
ide3 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: host protected area => 1
hda: lost interrupt
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63
hda: lost interrupt
hda: lost interrupt
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 12656448 sectors (6480 MB) w/512KiB Cache, CHS=787/255/63, UDMA(33)
Partition check:
/dev/ide/host0/bus0/target0/lun0:<3>hda: lost interrupt
p1 p2 p3
/dev/ide/host2/bus0/target0/lun0: p1

   I've tried most, if not all, of the "fixes" that people have
suggested on LKML for this chipset (all the hdparm invocations, for
example), and haven't managed to change any of the symptoms I
mentioned above. Can anyone suggest any way that I can get this [for
me] rather expensive and currently useless piece of hardware working
under Linux?

   I know that Andre Hedrick has fixed some things in an unreleased
patch, but it's unclear exactly which problems he's fixed, or when the
patch is going to be released. Is anyone in a position to say whether
my problem is going to be fixed by his changes, or when that patch is
going to be released, if ever?

   Thanks,
   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
           --- There are three mistaiks in this sentance. ---            

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Gv2mssJ7whwzWGARApxwAKClgjkxcCOoTeY28J4u85EoV0cjVgCfSb0g
GLtwrQJFhRmLuHz+MD7NrV4=
=jb2g
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
