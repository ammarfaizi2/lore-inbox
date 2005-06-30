Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263143AbVF3Uox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263143AbVF3Uox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbVF3Um6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:42:58 -0400
Received: from zlynx.org ([199.45.143.209]:49166 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S263143AbVF3Ujy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:39:54 -0400
Subject: Re: reiser4 plugins
From: Zan Lynx <zlynx@acm.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Hubert Chan <hubert@uhoreg.ca>, Hans Reiser <reiser@namesys.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200506301847.j5UIlp6u012775@laptop11.inf.utfsm.cl>
References: <200506301847.j5UIlp6u012775@laptop11.inf.utfsm.cl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jpBZ0eT4ro1HhmUwdp4Z"
Date: Thu, 30 Jun 2005 14:37:49 -0600
Message-Id: <1120163870.12258.107.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jpBZ0eT4ro1HhmUwdp4Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-06-30 at 14:47 -0400, Horst von Brand wrote:
[snip]
> Let me moderate that a bit: I'd be happy to have (some) files behaving
> strangely, /if in exchange I get something very worthwhile/. I.e., Unix
> filesystem sockets, named pipes, virtual filesystems all behave in weird
> ways, but this downside is more than compensated by huge advantages (even
> being able to do things that would otherwise be impossible). But all I se=
e
> is that file-is-directory advocates explain over and over how they are
> bending over backards to get the whole mess working exactly like true
> directories (nothing more, in the end quite a bit less). The uses I've se=
en
> discussed don't really need files-as-directories (you get most of the
> advantages by just tar(1)-ing up the contents, or packing them in some
> other way; OpenOffice /has/ structured files, XML inside zipped files, Ja=
va
> also uses zip files for its structuring needs, etc), or are ideas that
> might be nice to have on exclusively one-user, isolated machines, like
> "keep /my/ annotations/icon/application name/whatever with the file's
> data", but that break down in multiuser (even serially, one user after th=
e
> other) systems or when files are shared (via network, or simply by sendin=
g
> by mail or by copying from one machine to the other). In my rather ample
> experience, that situation is rare today, rapidly dwindling in the arena
> where Linux is mostly used. So this particular case of strange semantics
> for files has no upsides I can see, only downsides. The downsides have be=
en
> discussed to death, and AFAICS there are fundamental problems with the id=
ea
> that can't be fixed or sanely worked around. So why bother?

Structured files are fine when they're small but quickly become
disgusting as they get bigger.  Either you slowly rewrite the whole
thing or you "fast save" by writing new sections to the end of it that
replace existing sections.  That's how you end up with documents that
contain "deleted" information that was supposed to be confidential.

Having the filesystem track each part for you and then creating a
structured file when needed (and without needing to remember to run a
special tool) is a far better idea.  (reiser4 doesn't do this but its a
possible idea)

Another advantage to file-as-directory is being able to access all the
file's meta-data through a single channel: file names and text data.
It removes the need for chmod, chown, touch, getxattr, chacl and all the
rest of the special tools needed to work with Unix files.  It also makes
it far easier to add new meta-data in the future, because no new tools
have to be written to use it.

So that's two reasons to bother.
--=20
Zan Lynx <zlynx@acm.org>

--=-jpBZ0eT4ro1HhmUwdp4Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCxFgdG8fHaOLTWwgRAu+OAKCCowDFSVSV3SnhoXN5bLJMGRAxGgCdEyFf
iQFXIZg+qh27ZWlRrezLEKY=
=n4I9
-----END PGP SIGNATURE-----

--=-jpBZ0eT4ro1HhmUwdp4Z--

