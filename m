Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312334AbSDPLNR>; Tue, 16 Apr 2002 07:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312354AbSDPLNQ>; Tue, 16 Apr 2002 07:13:16 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:19725 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S312334AbSDPLNQ>;
	Tue, 16 Apr 2002 07:13:16 -0400
Date: Tue, 16 Apr 2002 15:17:43 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] drivers/net/eepro100: missing __devinit
Message-ID: <20020416111743.GB3418@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FN+gV9K+162wdwwF
Content-Type: multipart/mixed; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This patch adds missing __devinit modifiers for speedo_found1() and
do_eeprom_cmd() functions. Patch against 2.5.8. Compiles, but untested.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-eepro100-devinit
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/net/eepro100.c linux=
/drivers/net/eepro100.c
--- linux.vanilla/drivers/net/eepro100.c	Sun Apr 14 23:30:39 2002
+++ linux/drivers/net/eepro100.c	Sun Apr 14 23:46:30 2002
@@ -632,7 +632,7 @@
 	return -ENODEV;
 }
=20
-static int speedo_found1(struct pci_dev *pdev,
+static int __devinit speedo_found1(struct pci_dev *pdev,
 		long ioaddr, int card_idx, int acpi_idle_state)
 {
 	struct net_device *dev;
@@ -866,7 +866,7 @@
    interval for serial EEPROM.  However, it looks like that there is an
    additional requirement dictating larger udelay's in the code below.
    2000/05/24  SAW */
-static int do_eeprom_cmd(long ioaddr, int cmd, int cmd_len)
+static int __devinit do_eeprom_cmd(long ioaddr, int cmd, int cmd_len)
 {
 	unsigned retval =3D 0;
 	long ee_addr =3D ioaddr + SCBeeprom;

--WChQLJJJfbwij+9x--

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8vAhXBm4rlNOo3YgRAtC7AJ4qlie/S1wf0K3BhBIx+aPKP6znBwCgimM6
g6lrehAa1eSTrdb76U88BNU=
=Q0Eu
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
