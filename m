Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264160AbUEXIr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264160AbUEXIr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUEXIoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:44:21 -0400
Received: from zeus.kernel.org ([204.152.189.113]:38815 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264160AbUEXIds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:33:48 -0400
Date: Mon, 24 May 2004 04:33:15 -0400
From: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: [PATCH 8/14 linux-2.6.7-rc1] prism54: Fix prism54.org bugs 39, 73
Message-ID: <20040524083315.GI3330@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U/fW6JBK3GqE0Htg"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--U/fW6JBK3GqE0Htg
Content-Type: multipart/mixed; boundary="owpTafYe/1tj88Rh"
Content-Disposition: inline


--owpTafYe/1tj88Rh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


2004-04-07      Margit Schubert-While <margitsw@t-online.de>

        * Bugs 39 and 73

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--owpTafYe/1tj88Rh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="08-fix_bug_39_73.patch"
Content-Transfer-Encoding: quoted-printable

2004-04-07	Margit Schubert-While <margitsw@t-online.de>

	* Bugs 39 and 73

Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v
retrieving revision 1.73
retrieving revision 1.74
diff -u -r1.73 -r1.74
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	20 Mar 2004 1=
6:58:36 -0000	1.73
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	7 Apr 2004 04=
:12:12 -0000	1.74
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.73 2004/03/20 1=
6:58:36 mcgrof Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.74 2004/04/07 0=
4:12:12 msw Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
@@ -425,9 +425,9 @@
 	/* reset the mgmt receive queue */
 	for (counter =3D 0; counter < ISL38XX_CB_MGMT_QSIZE; counter++) {
 		isl38xx_fragment *frag =3D &cb->rx_data_mgmt[counter];
-		frag->size =3D MGMT_FRAME_SIZE;
+		frag->size =3D cpu_to_le16(MGMT_FRAME_SIZE);
 		frag->flags =3D 0;
-		frag->address =3D priv->mgmt_rx[counter].pci_addr;
+		frag->address =3D cpu_to_le32(priv->mgmt_rx[counter].pci_addr);
 	}
=20
 	for (counter =3D 0; counter < ISL38XX_CB_RX_QSIZE; counter++) {

--owpTafYe/1tj88Rh--

--U/fW6JBK3GqE0Htg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbNLat1JN+IKUl4RAmUqAJ45rKRhks2oZO8QMCWlizh+U6oiuwCePKrt
rDWXKz8QrFGiw2X+Dvn6Iic=
=O8Mi
-----END PGP SIGNATURE-----

--U/fW6JBK3GqE0Htg--
