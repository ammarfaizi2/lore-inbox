Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269329AbUJFR3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269329AbUJFR3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269310AbUJFR0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:26:20 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:8949 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S269320AbUJFRTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:19:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: [PATCH] RFC. User space backtrace on segv
Date: Wed, 6 Oct 2004 19:17:06 +0200
User-Agent: KMail/1.6.2
Cc: "LinuxSH (sf)" <linuxsh-dev@lists.sourceforge.net>,
       "Linux-SH (m17n)" <linux-sh@m17n.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1097080652.5420.34.camel@cambridge> <1097080781.5420.36.camel@cambridge>
In-Reply-To: <1097080781.5420.36.camel@cambridge>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_XiCZBygY2gawbWI";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410061917.11641.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_XiCZBygY2gawbWI
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mittwoch, 6. Oktober 2004 18:39, Alex Bennee wrote:
> On Wed, 2004-10-06 at 17:37, Alex Bennee wrote:
> > Hi,
> >=20
> > I hacked up this little patch to dump the stack and attempt to generate
> > a back-trace for errant user-space tasks.
> >  <snip>
>=20

Note that there already is similar functionality on s390, possibly on
other architectures as well. In kernel/sysctl.c, there is code
to make the behavior run-time selectable. The sysctl is currently called=20
KERN_S390_USER_DEBUG_LOGGING and compiled in only for s390, but it might
be a good idea to define this in an architecture independent way, e.g.
with a config option that is always selected on s390, sh and possibly
other archs.

	Arnd <><

--Boundary-02=_XiCZBygY2gawbWI
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBZCiX5t5GS2LDRf4RAp//AKCfAN/7KORG8Qd4bqE71/6IoKGLPQCfdde/
TH3YQt3Gxl8HmnPaMC8ySaM=
=OQ9T
-----END PGP SIGNATURE-----

--Boundary-02=_XiCZBygY2gawbWI--
