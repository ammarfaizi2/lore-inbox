Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272336AbTGYVIa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272334AbTGYUkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:40:55 -0400
Received: from coruscant.franken.de ([193.174.159.226]:43666 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272318AbTGYUi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:38:29 -0400
Date: Fri, 25 Jul 2003 22:51:00 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] netfilter conntrack missing include fix
Message-ID: <20030725205100.GL3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lXGjgdROvQphKPvG"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lXGjgdROvQphKPvG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

This is the 5th of a set of bugfixes (all tested against 2.4.22-pre7).
You might need to apply them incrementally (didn't test it in a
different order).  You will receive 2.6 merges of those patches soon.

Author: Martin Bene <martin.bene@icomedias.com>

Add an #include statement to ip_conntrack_core.h
This fixes a compile issue with ipt_connlimit (and probably others)


Please apply,


--- linux.old/include/linux/netfilter_ipv4/ip_conntrack_core.h	2003-07-14 0=
9:49:46.000000000 +0200
+++ linux/include/linux/netfilter_ipv4/ip_conntrack_core.h	2003-07-14 09:50=
:04.000000000 +0200
@@ -1,5 +1,6 @@
 #ifndef _IP_CONNTRACK_CORE_H
 #define _IP_CONNTRACK_CORE_H
+#include <linux/netfilter.h>
 #include <linux/netfilter_ipv4/lockhelp.h>
=20
 /* This header is used to share core functionality between the
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--lXGjgdROvQphKPvG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZg0XaXGVTD0i/8RAtvIAJ0ROEDC/9oJfD99lOqAxYdLpSjhJwCgrhU1
BtPM87mzWxFasolPzLl+hxI=
=+Wnj
-----END PGP SIGNATURE-----

--lXGjgdROvQphKPvG--
