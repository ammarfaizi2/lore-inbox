Return-Path: <linux-kernel-owner+w=401wt.eu-S932634AbWLMJU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbWLMJU6 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 04:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWLMJU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 04:20:58 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:47499 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932631AbWLMJU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 04:20:56 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 04:20:56 EST
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Greg.Chandler@wellsfargo.com
Subject: Re: Interphase Tachyon drivers missing.
Date: Wed, 13 Dec 2006 10:14:08 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, "Martin K. Petersen" <mkp@mkp.net>
References: <E8C008223DD5F64485DFBDF6D4B7F71D023BAAD3@msgswbmnmsp25.wellsfargo.com>
In-Reply-To: <E8C008223DD5F64485DFBDF6D4B7F71D023BAAD3@msgswbmnmsp25.wellsfargo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1421790.5n2URe5kJO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612131014.13281.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1421790.5n2URe5kJO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Greg.Chandler@wellsfargo.com wrote:
> I went to upgrade my kernel on a couple of boxes yesterday and noticed
> that the Interphase Tachyon chipset Fibre Channel driver was removed
> from the kernel.  I think 2.6.1 was the last one it was still in.  Was
> there a reason it was pulled?
> If not, do I have to volunteer to put it back in or can someone with
> more skill re-add it?

I suppose you're talking about the cpqfc driver? I have tried to clean it u=
p=20
but gave up. Next try was to rewrite, but due to lack of time there is no=20
progress in the last month. The old driver was that horrible coded that noo=
ne=20
can maintain it. It was originally written for something like Linux 2.2 and=
=20
was never even forward ported completely to 2.4. With the major changes in=
=20
Linux' driver model that went into 2.6 it was nearly unusable anyway. Not=20
that the use of it in 2.4 can be encouraged. One of the main problems is th=
e=20
severe lack of error handling which you can see alone from the fact that=20
there are tons of function returning void even in the critical I/O-path's.

I have heard of at least 3 different people before you (not counting me) th=
at=20
would like to have a driver for this one. One even donated some hardware to=
=20
me around last christmas. But nevertheless my lack of time stopped my work =
on=20
this.

Martin, you were hacking on something there too but never showed up some co=
de.=20
Is there anything new?

Eike

--nextPart1421790.5n2URe5kJO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFf8RlXKSJPmm5/E4RAlKYAJ9Ch+CVxChrIifdWuhnjEES+7qONgCgprK9
IGDd0XAGI9zYjnzcJh0idOE=
=OXKq
-----END PGP SIGNATURE-----

--nextPart1421790.5n2URe5kJO--
