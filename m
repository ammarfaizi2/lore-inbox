Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUAPN4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 08:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265493AbUAPN4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 08:56:19 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:52355 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265477AbUAPN4P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 08:56:15 -0500
Subject: Re: [PATCH] rwlock_is_locked undefined for UP systems
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Prashanth T <prasht@in.ibm.com>
Cc: rml@tech9.net, linux-kernel@vger.kernel.org
In-Reply-To: <4007EAE7.2030104@in.ibm.com>
References: <4007EAE7.2030104@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-L+r5ouUt+J1LLFEK0t3V"
Organization: Red Hat, Inc.
Message-Id: <1074261350.4434.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 16 Jan 2004 14:55:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-L+r5ouUt+J1LLFEK0t3V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-16 at 14:45, Prashanth T wrote:
> Hi,
>     I had to use rwlock_is_locked( ) with linux2.6 for kdb and noticed th=
at
> this routine to be undefined for UP.  I have attached the patch for 2.6.1
> below to return 0 for rwlock_is_locked( ) on UP systems.
> Please let me know.

I consider any user of this on UP to be broken, just like UP use of
spin_is_locked() is always a bug..... better a compiletime bug than a
runtime bug I guess...

--=-L+r5ouUt+J1LLFEK0t3V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAB+1mxULwo51rQBIRAkQsAKCbm1wBePb6l6iXKXKMaZYfDQtkawCfSrSX
LyneYLI7SZJIhbcYLH16rM4=
=T1cl
-----END PGP SIGNATURE-----

--=-L+r5ouUt+J1LLFEK0t3V--
