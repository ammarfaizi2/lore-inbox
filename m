Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVCJQE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVCJQE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVCJQBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:01:47 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:34461 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262674AbVCJQBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:01:16 -0500
Subject: Re: [patch 1/1] /proc/$$/ipaddr and per-task networking bits
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1110469087.6291.103.camel@laptopd505.fenrus.org>
References: <1110464202.9190.7.camel@localhost.localdomain>
	 <1110464782.6291.95.camel@laptopd505.fenrus.org>
	 <1110468517.9190.24.camel@localhost.localdomain>
	 <1110469087.6291.103.camel@laptopd505.fenrus.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lnbetjzYWWsTEKacdZRu"
Date: Thu, 10 Mar 2005 17:00:29 +0100
Message-Id: <1110470430.9190.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.6 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lnbetjzYWWsTEKacdZRu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El jue, 10-03-2005 a las 16:38 +0100, Arjan van de Ven escribi=F3:
> but.... tasks don't have an IP address. Hosts do. Hosts can have
> multiple IP addresses. Both ipv4 and ipv6.  Users don't have IP
> addresses either (they do have user IDs so that link is clear).=20
> I think I'm missing something big here. What does it *mean* for a task
> to have an IP address. Once that is clear maybe I can start to
> understand the rest, but until the meaning of "task has an IP address"
> is better explained/more clear I think I'm stuck. (and no the output in
> a log isn't a meaning, it's only a result)

I think I've explained it well, more concretely, it tries to fill the
ipaddr member of the task_struct structure with the IP address
associated to the user running @current task/process,if available.
Then, it will be attached within the proc fs in an entry called ipaddr,
under the proper pid directory.

The whole thing is almost self-explaining by just looking at the code.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-lnbetjzYWWsTEKacdZRu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCMG8dDcEopW8rLewRAotNAKDJAN936oH3QOn1jwgLgUCQuWl4PACfeAbU
DQCgPK7//kl7jfN+allPb4o=
=fU+A
-----END PGP SIGNATURE-----

--=-lnbetjzYWWsTEKacdZRu--

