Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbTEAIYm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 04:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTEAIYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 04:24:42 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:24302 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261164AbTEAIYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 04:24:40 -0400
Subject: Re: must-fix list for 2.6.0
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@digeo.com>
Cc: Rick Lindsley <ricklind@us.ibm.com>, solt@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org, frankeh@us.ibm.com
In-Reply-To: <20030430162108.09dbd019.akpm@digeo.com>
References: <20030430121105.454daee1.akpm@digeo.com>
	 <200304302311.h3UNB2H27134@owlet.beaverton.ibm.com>
	 <20030430162108.09dbd019.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9r9E7o4IbfvF3DqMyDq6"
Organization: Red Hat, Inc.
Message-Id: <1051778205.1406.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 01 May 2003 10:36:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9r9E7o4IbfvF3DqMyDq6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-05-01 at 01:21, Andrew Morton wrote:
> Rick Lindsley <ricklind@us.ibm.com> wrote:
> >
> > 	Why is this bad?
> > 	(a) if it does busy looping through sched_yield it will eat cycles whi=
ch
> > 	    might not have happened
>=20
> Things like OpenOffice _do_ busy loop on sched_yield().  It appears with
> that patch, OO will sit there chewing ~1% of CPU.  Not great, but not bad
> either..
>=20
> A few kernels ago, OpenOffice would take sixty seconds to just flop down =
a
> menu if there was a kernel build happening at the same time.  That is jus=
t
> utterly broken, so if we're going to leave the sched.c code as-is then we
> *require* that all applications be updated to not spin on sched_yield.
>=20
> There's just no question about that.  It may end up not being acceptable.

actually this is an ooffice bug and is since fixed..... newer ooffice
versions don't have this behavior anymore. Nuking a kernel feature
(basically making sched_yield() more posix compliant) for ONE
broken-since-fixed app doesn't sound like a good plan to me.

--=-9r9E7o4IbfvF3DqMyDq6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+sNydxULwo51rQBIRAp2vAJ44Nf8uFTm1GsY0m3nghkTgQ49NiwCdGDU2
SkDg1JNj1Ha27KYdpLmq+cw=
=KMbQ
-----END PGP SIGNATURE-----

--=-9r9E7o4IbfvF3DqMyDq6--
