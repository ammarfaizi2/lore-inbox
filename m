Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269167AbTGJKEs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269168AbTGJKEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:04:48 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:31983 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S269167AbTGJKEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:04:44 -0400
Subject: Re: memset (was: Redundant memset in AIO read_events)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030710100417.83333.qmail@web11801.mail.yahoo.com>
References: <20030710100417.83333.qmail@web11801.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6zWRbGZMJlXzh9bqgD3t"
Organization: Red Hat, Inc.
Message-Id: <1057832361.5817.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 10 Jul 2003 12:19:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6zWRbGZMJlXzh9bqgD3t
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-10 at 12:04, Etienne Lorrain wrote:
>  Note that using memset() is better reserved to initialise variable-size
>  structures or buffers. Even if memset() is extremely optimised,
>  it is still not as fast as not doing anything.

this is not always true....
memset can be used as an optimized cache-warmup, which can avoid the
write-allocate behavior of normal writes, which means that if you memset
a structure first and then fill it, it can be halve the memory bandwidth
and thus half as fast. This assumes an optimized memset which we
*currently* don't have I think... but well, we can fix that ;)


--=-6zWRbGZMJlXzh9bqgD3t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/DT2pxULwo51rQBIRAjYZAJ0e3LDgB2zo/B3cTKzNPOJoeCf/VQCcDGV/
RNKxJXrywBqU1REePcf+zRg=
=ie72
-----END PGP SIGNATURE-----

--=-6zWRbGZMJlXzh9bqgD3t--
