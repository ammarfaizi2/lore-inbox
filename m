Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVDXRQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVDXRQk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 13:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVDXRQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 13:16:40 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:45698 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262279AbVDXRQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 13:16:37 -0400
From: "Tais M. Hansen" <tais.hansen@osd.dk>
Organization: OSD
To: linux-kernel@vger.kernel.org
Subject: Re: SATA/ATAPI
Date: Sun, 24 Apr 2005 19:16:30 +0200
User-Agent: KMail/1.8
Cc: Jeff Garzik <jgarzik@pobox.com>
References: <200504211941.43889.tais.hansen@osd.dk> <200504240008.58326.tais.hansen@osd.dk> <426BCF6E.2000000@pobox.com>
In-Reply-To: <426BCF6E.2000000@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1832793.vMXK1smSXA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504241916.34726.tais.hansen@osd.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1832793.vMXK1smSXA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 24 April 2005 18:55, Jeff Garzik wrote:
> > I've been digging through sr, scsi, sata_via, libata-scsi and
> > libata-core, littering the code with printk's.
> > My lack of knowledge on how the kernel handles devices, is really showi=
ng
> > now.
> > I've been unable to figure out what is supposed to tie sr to the devices
> > probed by sata_via. Also, littering sr with printk's gave me the idea
> > that sr is not even looking for cdrom devices. It loads, does the basic
> > module __init stuff and then silence. Should sr find devices itself or =
is
> > the kernel supposed to inform sr via some callback hook? I could really
> > be barking up the wrong tree here, and not even see it.
> > Enabling SCSI logging and kernel debug didn't really give me anything
> > useful.
> Did you turn on ATA_ENABLE_ATAPI in include/linux/libata.h?

Tried with it both defined and undefined. When it's defined an extra line i=
s=20
added (the last one below) when loading the sata_via module:

sata_via version 1.1
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
sata_via(0000:00:0f.0): routed to hard irq line 4
ata3: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD400 irq 20
ata4: SATA max UDMA/133 cmd 0xE000 ctl 0xD802 bmdma 0xD408 irq 20
ata3: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000=20
88:0007
ata3: dev 0 ATAPI, max UDMA/33
ata3: dev 0 configured for UDMA/33
scsi2 : sata_via
ata4: no device found (phy stat 00000000)
scsi3 : sata_via
ata3: command 0xa0 timeout, stat 0xd0 host_stat 0x1

=2D-=20
Regards,
Tais M. Hansen
OSD

___________________________________________________________
"If people had understood how patents would be granted when most of today's=
=20
ideas were invented and had taken out patents, the industry would be at a=20
complete standstill today." -Bill Gates (1991)

--nextPart1832793.vMXK1smSXA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCa9RyLf7B7mQNLngRAv+XAJ9BHI+viqLqCgyaa8PaeZXnwmKZ1wCfRJgb
02soRsnBa6GSKyAed+iXDww=
=6NV0
-----END PGP SIGNATURE-----

--nextPart1832793.vMXK1smSXA--
