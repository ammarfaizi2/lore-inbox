Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266373AbTGJPQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269296AbTGJPQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:16:14 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:38684 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S266373AbTGJPQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:16:13 -0400
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
From: Anders Karlsson <anders@trudheim.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Oleg Drokin <green@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F0D761E.2050702@gmx.net>
References: <3F0D761E.2050702@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qvJ0F9BWLZ05xjo/+1HD"
Organization: Trudheim Technology Limited
Message-Id: <1057851052.7753.6.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 Rubber Turnip www.usr-local-bin.org 
Date: 10 Jul 2003 16:30:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qvJ0F9BWLZ05xjo/+1HD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Apologies for chipping in, but I saw something similar to what was
described in the thread. I'm running 2.4.22-pre3-ac1 with the FreeS/WAN
2.0.1 patches and noticed last night that when booting this kernel, if
an ext3 filesystem had exceeded its mount count and required checking,
the e2fsck process would hang sometime during the fsck and the system
would become unresponsive, but SysRq would still work. Alt-SysRq-P would
show e2fsck and some register details. I did not note them down, but
booting 2.4.21-rc7-ac1 and letting that kernel check the filesystem
would work. Booting back into 2.4.22-pre3-ac1 would then also work.

This might or might not be related to the original problem. I do use
nmi_watchdog=3D1, NMI count is 1 presently, so I guess that works. The ram
is memtested, so that is not an issue, heavy filesystem usage works
normally, it was just e2fsck that would not work. I have not tried -pre2
or -pre4 yet, but that is on the cards.

If there is anything I can try, let me know.

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-qvJ0F9BWLZ05xjo/+1HD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA/DYasLYywqksgYBoRAkjmAJ0S1G2QdXHwSVGX0wz+GZmtKAXWQwCguQYp
iHpMB3qAIVbErZquSnW+6Q8=
=pD56
-----END PGP SIGNATURE-----

--=-qvJ0F9BWLZ05xjo/+1HD--

