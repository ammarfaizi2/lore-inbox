Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVDRSux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVDRSux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 14:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVDRSux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 14:50:53 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:18313 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261199AbVDRSum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 14:50:42 -0400
Subject: [PATCH 0/7] procfs privacy
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7PkIN7kTsWfYeZ/KazZD"
Date: Mon, 18 Apr 2005 20:46:16 +0200
Message-Id: <1113849977.17341.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7PkIN7kTsWfYeZ/KazZD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

As extracted from grsecurity's config. documentation: "non-root
users will only be able to view their own processes, and restricts
them from viewing network-related information, and viewing kernel
symbol and module information."

This is a procfs "privacy" split-up patch based in grsecurity procfs
restrictions
with some changes, more concretely, the restricted sections and entries
are:

- /proc/bus
   /pci
- /proc/net
- /proc/config.gz
- /proc/kallsyms
- /proc/ioports
- /proc/iomem
- /proc/devices
- /proc/cmdline
- /proc/version
- /proc/uptime
- /proc/cpuinfo
- /proc/partitions
- /proc/stat
- /proc/interrupts
- /proc/slabinfo
- /proc/diskstats
- /proc/modules
- /proc/schedstat

Signed-off-by: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
---

linux-2.6.11-lorenzo/drivers/pci/proc.c  |    4 ++--
linux-2.6.11-lorenzo/fs/proc/base.c      |   10 +++++++++-
linux-2.6.11-lorenzo/fs/proc/proc_misc.c |   25
+++++++++++++------------
linux-2.6.11-lorenzo/fs/proc/root.c      |    4 ++--
linux-2.6.11-lorenzo/kernel/configs.c    |    2 +-
linux-2.6.11-lorenzo/kernel/kallsyms.c   |    2 +-
linux-2.6.11-lorenzo/kernel/resource.c   |    4 ++--
7 files changed, 30 insertions(+), 21 deletions(-)

--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-7PkIN7kTsWfYeZ/KazZD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZAB4DcEopW8rLewRAvylAJ4sZ+S+8XQXw2r4s0iRABwBwUXaUQCgnayG
Fqu2ci227cLUDsfpH5gbzWQ=
=RVhI
-----END PGP SIGNATURE-----

--=-7PkIN7kTsWfYeZ/KazZD--

