Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSJNV52>; Mon, 14 Oct 2002 17:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSJNV52>; Mon, 14 Oct 2002 17:57:28 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:57362 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S262201AbSJNV50>; Mon, 14 Oct 2002 17:57:26 -0400
Date: Mon, 14 Oct 2002 23:03:15 +0100
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: JBD Documentation added in BK-current
Message-ID: <20021014230314.A19801@computer-surgery.co.uk>
References: <20021008212310.A13265@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008212310.A13265@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Oct 08, 2002 at 09:23:10PM +0200
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2002 at 09:23:10PM +0200, Sam Ravnborg wrote:
> The JBD documentation have been added in BK-current.
> But 'compiling' the documentation result in a lot of SGML related
> errors.
>=20
> Someone knowing SGML that care to take a look?

Well. I'm not surprised there are a few I couldn't find an SGML reference
for the linuxdoc dtd , or a tutorial when I wrote it, so I guessed by looki=
ng
at other documents and source code.=20

I thought I'd checked the warnings

> [I'm cleaning up the mess in the Makefile after JBD was added right now].

Did I really make it that messy?
I'm a little behind with bk pulling and it takes 2-3hours to do each pull
here, so I can't be sure until tomorrow .

but if the line number haven't changed...

>   DB2PS   Documentation/DocBook/journal-api.ps
> Using catalogs: /etc/sgml/sgml-docbook-3.1.cat
> Using stylesheet: /usr/share/sgml/docbook/utils-0.6.9/docbook-utils.dsl#p=
rint
> Working on: /home/sam/src/linux/kernel/bk/clean3/Documentation/DocBook/jo=
urnal-api.sgml
> jade:/.../journal-api.sgml:211:5:E: document type does not allow element =
"PARA" here; missing one of "FOOTNOTE", "MSGTEXT", "CAUTION", "IMPORTANT", =
"NOTE", "TIP", "WARNING", "BLOCKQUOTE", "INFORMALEXAMPLE" start-tag
> jade:/.../journal-api.sgml:212:7:E: end tag for "PARA" omitted, but OMITT=
AG NO was specified
> jade:/.../journal-api.sgml:212:7:E: end tag for "PARA" omitted, but OMITT=
AG NO was specified

Oops, there are errant <para> tag journal-api.tmpl line 211. Delete the lin=
e.

> jade:/.../journal-api.sgml:248:9:E: end tag for "PARA" omitted, but OMITT=
AG NO was specified
> jade:/.../journal-api.sgml:248:9:E: end tag for "SECT1" omitted, but OMIT=
TAG NO was specified

Hmm, can't see what these asre unless they are run-on errors form above.

Hang on. yup they seem to be.... , the trivial patch follows.

You also mentioned in private mail to me that you think there is
a requirement for BKL to be held on some journal calls. Could
someone else preferably part of the ext3 maintance team give me
cahpter and verse on this situationin 2.4 and 2.5 so I can
ensure the docs are correct, assuming they aren't already which is quite
likely since the docs were written by inspection of the ext3/jbd code=20
and reading of various other docs avaliable (as mention in the sgml).


diff -Nru a/Documentation/DocBook/journal-api.tmpl b/Documentation/DocBook/=
journal-api.tmpl
--- a/Documentation/DocBook/journal-api.tmpl	Mon Oct 14 22:46:55 2002
+++ b/Documentation/DocBook/journal-api.tmpl	Mon Oct 14 22:46:55 2002
@@ -208,7 +208,6 @@
 if you allow unprivileged userspace to trigger codepaths containing these
 calls.
=20
-<para>
 </sect1>
 <sect1>
 <title>Summary</title>


TTFN
--=20
Roger.
Master of Peng Shui.  (Ancient oriental art of Penguin Arranging)
GPG Key FPR: CFF1 F383 F854 4E6A 918D  5CFF A90D E73B 88DE 0B3E

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9qz8hqQ3nO4jeCz4RAt2+AKCFsh9YC+Ocw532Hs4P5SESeJ6ntACdFOWX
XXI6j3TCupsSVJADhutY5tg=
=HsxL
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
