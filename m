Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbSJaJ6s>; Thu, 31 Oct 2002 04:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264798AbSJaJ6s>; Thu, 31 Oct 2002 04:58:48 -0500
Received: from codepoet.org ([166.70.99.138]:64203 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S264797AbSJaJ6r>;
	Thu, 31 Oct 2002 04:58:47 -0500
Date: Thu, 31 Oct 2002 03:05:12 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031100512.GA27985@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Rasmus Andersen <rasmus@jaquet.dk>, Adrian Bunk <bunk@fs.tum.de>,
	linux-kernel@vger.kernel.org
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031092440.B5815@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20021031092440.B5815@jaquet.dk>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu Oct 31, 2002 at 09:24:40AM +0100, Rasmus Andersen wrote:
> On Thu, Oct 31, 2002 at 01:53:14AM +0100, Adrian Bunk wrote:
>=20
> Hi Adrian,
> >=20
> > could you try to use "-Os" instead of "-O2" as gcc optimization option
> > when CONFIG_TINY is enabled? Something like the following (completely
> > untested) patch:
>=20
> I tried -Os once, and it didn't boot for me. So I dumped it.

I build all my kernels with -Os and it works just fine for me.

--- orig/Makefile	Tue Aug 20 06:44:25 2002
+++ linux-2.4.19/Makefile	Tue Aug 20 06:44:25 2002
@@ -88,7 +88,7 @@
=20
 CPPFLAGS :=3D -D__KERNEL__ -I$(HPATH)
=20
-CFLAGS :=3D $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
+CFLAGS :=3D $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -Os \
 	  -fno-strict-aliasing -fno-common
 ifndef CONFIG_FRAME_POINTER
 CFLAGS +=3D -fomit-frame-pointer

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9wQBXX5tkPjDTkFcRAgSYAKDIk4s+lTd+h6KBPetC+sW/zgDNsACfZ+d2
AvChziRmxM9ht4+/TjkRpaY=
=ubvW
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
