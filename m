Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314081AbSDZQdI>; Fri, 26 Apr 2002 12:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSDZQdI>; Fri, 26 Apr 2002 12:33:08 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:45751 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314081AbSDZQdH>;
	Fri, 26 Apr 2002 12:33:07 -0400
Date: Fri, 26 Apr 2002 18:31:26 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.2 is available
Message-Id: <20020426183126.3f4a4696.sebastian.droege@gmx.de>
In-Reply-To: <10571.1019796148@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.0+WRbBY(hkud(1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.0+WRbBY(hkud(1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
you've changed CONFIG_ZLIB_INFLATE and CONFIG_ZLIB_DEFLATE in the Makefile.in's
here's a patch (tested and works for me) ;)

Bye

--- linux-2.5.10/lib/zlib_inflate/Makefile.in~       Fri Apr 26 18:28:10 2002
+++ linux-2.5.10/lib/zlib_inflate/Makefile.in        Fri Apr 26 18:22:55 2002
@@ -15,4 +15,4 @@
 
 expsyms(inflate_syms.o)
 objlink(zlib_inflate.o infblock.o infcodes.o inffast.o inflate.o inftrees.o infutil.o inflate_syms.o)
-select(CONFIG_ZLIB_DEFLATE zlib_inflate.o)
+select(CONFIG_ZLIB_INFLATE zlib_inflate.o)

--- linux-2.5.10/lib/zlib_deflate/Makefile.in~       Fri Apr 26 18:28:25 2002
+++ linux-2.5.10/lib/zlib_deflate/Makefile.in        Fri Apr 26 18:22:46 2002
@@ -8,4 +8,4 @@
 
 expsyms(deflate_syms.o)
 objlink(zlib_deflate.o deflate.o deftree.o deflate_syms.o)
-select(CONFIG_ZLIB_INFLATE zlib_deflate.o)
+select(CONFIG_ZLIB_DEFLATE zlib_deflate.o)
--=.0+WRbBY(hkud(1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8yYDje9FFpVVDScsRAi2hAJ9xsz7UpD11pOMpr+3TnN0so266mwCfXOLK
uCQEnmWvnKl3vbzDBzNaa84=
=x2RL
-----END PGP SIGNATURE-----

--=.0+WRbBY(hkud(1--

