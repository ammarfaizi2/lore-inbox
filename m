Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313668AbSDHPMm>; Mon, 8 Apr 2002 11:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313669AbSDHPMl>; Mon, 8 Apr 2002 11:12:41 -0400
Received: from charger.oldcity.dca.net ([207.245.82.76]:45549 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S313668AbSDHPMk>; Mon, 8 Apr 2002 11:12:40 -0400
Date: Mon, 8 Apr 2002 11:12:39 -0400
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@zip.com.au>
Subject: vortex eeprom
Message-ID: <20020408151238.GD7174@localhost>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: debian SID Gnu/Linux 2.4.19-pre4 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am trying to understand the vortex driver.
I believe that I am not looking at the correct documentation.

I read The following doc :

PCI/EISA Bus-Master Adaptater Driver Technical Reference
Members of the 3Com EtherLink III and Fast Etherlink families of adapters
Manual Part Number 09-0681-001B

The reason I believe there is a better doc is that the driver read info1
and info2 fields from the EEPROM and then does :

 if (vp->info1 & 0x8000) {
    vp->full_duplex =3D 1;
    if (print_info)
       printk(KERN_INFO "Full duplex capable\n");
 }      =20

 ...

 if (print_info) {
    printk(KERN_INFO "  Enabling bus-master transmits and %s receives.\n",
          (vp->info2 & 1) ? "early" : "whole-frame" );
 }

But in my doc both these bits are marked 'reserved'.

I understand that these bits could be defined in more recent chipset but
in the doc I am looking at the full duplex capability is defined in
another field in the EEPROM:

   Capabilities Word (offset 0x10) : supportsFullDuplex bit (bit 1)

Christophe

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Ce que l'on con=E7oit bien s'=E9nonce clairement,
Et les mots pour le dire arrivent ais=E9ment.
   Nicolas Boileau, L'Art po=E9tique

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8sbNmj0UvHtcstB4RAhkvAJ4lhp76XoT3vZUxDbSrXeCv0G2e7QCfSs5Z
Oa9ZAI0TUiVaZ8ZrSBojy9k=
=Ho1+
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
