Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbUJ1AyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbUJ1AyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUJ1Axm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:53:42 -0400
Received: from hostmaster.org ([212.186.110.32]:59035 "EHLO hostmaster.org")
	by vger.kernel.org with ESMTP id S262710AbUJ1AvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:51:17 -0400
Subject: Re: Dual Opteron box, what's the optimal memory placement for the
	CPUs?
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410272316160.3284@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410272316160.3284@dragon.hygekrogen.localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qhA3Ij49parpiTJXXfpB"
Date: Thu, 28 Oct 2004 02:51:15 +0200
Message-Id: <1098924675.11282.60.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qhA3Ij49parpiTJXXfpB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

That is indeed a very good question.

If you use node interleaving you end up with memory accesses to be
distributed matching the amount of memory installed on each node.
Assuming that processes prefer the first node you get better performance
with load < 1 and memory usage < $first_node_memory.

If you use a NUMA configuration you should get better performance from
almost equally distributed memory. Especially when the load goes up.

Tom

PS: I choosed NUMA with equally distributed memory.
--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

XT emulator finally available for Pentium-IV: install Windows XP today!




--=-qhA3Ij49parpiTJXXfpB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iQEVAwUAQYBCg2D1OYqW/8uJAQLgqAf/dxswsbIh3PNv7pMH+9h6U8TL2mEeHwlj
obm6Zj15ueEPK4BtPa6vcwsgITySCPEQgNhMqJyBDh2UkLqRMSrHEGW3VLD+pa+E
jPETYfIYa0A34+KzFqDQ5xY6x2S7Mt+Z/dTXCIEzIGMsmo+h4kaIaYS/9Lp4FxaW
/ZhOEiHTL6R9dGAHt8cLHyDqZJ4aEETcY4QqJmy0kg3A0RDFgzeCHiuv/CJPoYfu
eS3Ov8ZHTk7cPnr+lUDlNskfbg3Qwa0GRqYORKFyDFhGdHbGWYn/Jcmk2N1kjE8+
IR6paPBcgwme+2rN4lXL11+hCuOjtkbcE3SCGBQg6oduoLNe1AWHfA==
=eTRl
-----END PGP SIGNATURE-----

--=-qhA3Ij49parpiTJXXfpB--

