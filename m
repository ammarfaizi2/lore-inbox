Return-Path: <linux-kernel-owner+w=401wt.eu-S1161108AbWLPP4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbWLPP4W (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbWLPP4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:56:21 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:56613 "EHLO
	mailout09.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161108AbWLPP4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:56:20 -0500
Message-ID: <45841710.9040900@t-online.de>
Date: Sat, 16 Dec 2006 16:56:00 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.19.1, sata_sil: sata dvd writer doesn't work
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3210B696DE4E5678A0AE65C3"
X-ID: G-r+BmZDZe4C5yCHzzkKK9BuCjPqAuXyeNwDoXojN66U1sMoyvYdgB
X-TOI-MSGID: 14b774ac-877c-4225-8d66-416890e623ae
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3210B696DE4E5678A0AE65C3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi folks,

I've got a problem with a Samsung SATA dvd writer: It
doesn't play video DVDs. If I connect the same drive
via an adapter to USB, then there is no such problem.


dmesg says:

ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x1)
ata2.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: model number mismatch 'TSSTcorpCD/DVDW SH-S183A' !=3D '=D1=C5=CC=
h=F5=B3N=F5

This is reproducible.


lspci:
01:07.0 RAID bus controller: Silicon Image, Inc. SiI 3512 [SATALink/SATAR=
aid] Serial ATA Controller (rev 01)
01:07.0 0104: 1095:3512 (rev 01)

/proc/scsi/scsi:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: TSSTcorp Model: CD/DVDW SH-S183A Rev: SB01
  Type:   CD-ROM                           ANSI SCSI revision: 05


I already asked Samsung's hotline for a firmware update,
but there is none available. They haven't heard of this
problem before, either. My wild guess would be that this
is a driver problem.

Kernels tried: 2.6.19.1, 2.6.18.3


What would be your suggestion to track down this problem?


Regards

Harri





--------------enig3210B696DE4E5678A0AE65C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFhBcWUTlbRTxpHjcRAuv/AKCG4T3OYTdhLZef2kDwm7OsSpfs1gCfUOYp
mFPIDsfvo+CHTxvNm12dWmc=
=WKDi
-----END PGP SIGNATURE-----

--------------enig3210B696DE4E5678A0AE65C3--
