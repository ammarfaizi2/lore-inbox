Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264181AbTEWUg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbTEWUg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:36:28 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:63679 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264181AbTEWUg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:36:27 -0400
Date: Fri, 23 May 2003 17:48:51 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: p2@ace.ulyssis.sutdent.kuleuven.ac.be, mikep@linuxtr.net
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Fix multiline string
Message-ID: <20030523204851.GW2939@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V4yrq4dHtCqH+JvC"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V4yrq4dHtCqH+JvC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Detected when using gcc 3.3.

--=20
Eduardo


diff -purN linux-2.4.orig/drivers/net/tokenring/olympic.c linux-2.4/drivers=
/net/tokenring/olympic.c
--- linux-2.4.orig/drivers/net/tokenring/olympic.c	2003-05-22 20:13:15.0000=
00000 -0300
+++ linux-2.4/drivers/net/tokenring/olympic.c	2003-05-22 20:13:15.000000000=
 -0300
@@ -655,8 +655,8 @@ static int olympic_open(struct net_devic
 	printk(" stat_ring[7]: %p\n", &(olympic_priv->olympic_rx_status_ring[7]) =
 );
=20
 	printk("RXCDA: %x, rx_ring[0]: %p\n",readl(olympic_mmio+RXCDA),&olympic_p=
riv->olympic_rx_ring[0]);
-	printk("Rx_ring_dma_addr =3D %08x, rx_status_dma_addr =3D
-%08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_ad=
dr) ;=20
+	printk("Rx_ring_dma_addr =3D %08x, rx_status_dma_addr =3D %08x\n",
+			olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ;=
=20
 #endif
=20
 	writew((((readw(olympic_mmio+RXENQ)) & 0x8000) ^ 0x8000) | i,olympic_mmio=
+RXENQ);

--V4yrq4dHtCqH+JvC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+zokzcaRJ66w1lWgRAro/AJ9yD9ztmNMEWjNWxmN0mMB6GMPa7gCfTD6a
zZIC5hevp+N6oaN5ABWQFow=
=G2Ef
-----END PGP SIGNATURE-----

--V4yrq4dHtCqH+JvC--
