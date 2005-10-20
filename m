Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbVJTG2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbVJTG2i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 02:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbVJTG2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 02:28:38 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:2207 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751770AbVJTG2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 02:28:37 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: large files unnecessary trashing filesystem cache?
Date: Thu, 20 Oct 2005 08:28:23 +0200
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, gfiala@s.netic.de
References: <200510182201.11241.gfiala@s.netic.de> <200510191754.17963.ioe-lkml@rameria.de> <20051019124927.643a0603.akpm@osdl.org>
In-Reply-To: <20051019124927.643a0603.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart188302518.QbqInUOHnv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510200828.29204.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart188302518.QbqInUOHnv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wednesday 19 October 2005 21:49, Andrew Morton wrote:
> Ingo Oeser <ioe-lkml@rameria.de> wrote:
> > > > app which does setrlimit()+exec():
> > > >=20
> > > > 	limit-cache-usage -s 1000 my-fave-backup-program <args>
> > > >=20
> > > > Which will cause every file which my-fave-backup-program reads or w=
rites to
> > > > be limited to a maximum pagecache residency of 1000 kbytes.
> > >=20
> > > Or make it another 'ulimit' parameter...
> > Which is already there: There is an ulimit for "maximum RSS",=20
> > which is at least a superset of "maximum pagecache residency".
>=20
> RSS is a quite separate concept from pagecache.
=20
Yes I know, but the amount of pagecache which is RESIDENT for a process
is not that seperate from RSS, I think.=20

I always thought RSS is the amount of mapped and anonymous=20
pages of a process, which are in physical memory (aka resident).=20

So I consider the amount of mapped pagecache pages of=20
a process which are in physical memory (aka resident) a subset.

Or do you care about page cache pages not mapped into the process?
Is this the point I miss?

Please enlighten me :-)


Regards

Ingo Oeser


--nextPart188302518.QbqInUOHnv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDVzkNU56oYWuOrkARAsUCAKCZ3ailL01+j3sPxmPxJePftHKUNQCgxysw
S+sA1+LwNz7BYZugNrlNyzs=
=uMmH
-----END PGP SIGNATURE-----

--nextPart188302518.QbqInUOHnv--
