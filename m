Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264566AbUBIBx7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 20:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbUBIBx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 20:53:59 -0500
Received: from mhub-m6.tc.umn.edu ([160.94.23.36]:12271 "EHLO
	mhub-m6.tc.umn.edu") by vger.kernel.org with ESMTP id S264566AbUBIBx4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 20:53:56 -0500
Subject: Disassembling with gdb (Re: Linux 2.6.3-rc1)
From: Matthew Reppert <repp0017@tc.umn.edu>
To: Andre Tomt <andre@tomt.net>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4026B064.5080900@tomt.net>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org>
	 <200402071722.10242.bzolnier@elka.pw.edu.pl> <4025D0F2.1020400@tomt.net>
	 <200402082234.22043.bzolnier@elka.pw.edu.pl>  <4026B064.5080900@tomt.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OE2qpy+1iPxVjWVu5/FS"
Message-Id: <1076291631.545.7001.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 08 Feb 2004 19:53:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OE2qpy+1iPxVjWVu5/FS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-02-08 at 15:55, Andre Tomt wrote:
> Bartlomiej Zolnierkiewicz wrote:
>   >>Unable to handle kernel virtual paging request at virtual address=20
> 24748b24
> >>
> >>EIP is at ide_pci_register_host_proc+0x27/0x40 [ide_core]
> >=20
> >=20
> > Can you disassemble ide_pci_register_host_proc using gdb?
>=20
> I'd need a walkthrough, not very familiar with gdb other than getting a=20
> backtrace out of it

 - Go to the directory you compiled the kernel in
 - do: gdb vmlinux
 - you're in gdb, now do: 'x/i ide_pci_register_host_proc' This will
   disassemble starting at ide_pci_register_host_proc, and needs (I
   believe) debugging symbols present ... well, try it, and if gdb
   complains that it can't, that's that
 - Keep entering "x/i"; this will make gdb keep disassembling the next
   instruction. Keep doing this until you're past
   <ide_pci_register_host_proc+0x27>, I assume.
 - to get out of gdb, hit ^D or type "quit"

Matt

--=-OE2qpy+1iPxVjWVu5/FS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAJugvA9ZcCXfrOTMRAv+6AJoDzbVYfUUIfDJTSZuo91kRiHndqwCglyi/
u0jvIzmN11dWfHfxzht0ZyY=
=0Akb
-----END PGP SIGNATURE-----

--=-OE2qpy+1iPxVjWVu5/FS--

