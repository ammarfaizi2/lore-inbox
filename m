Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUHXGvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUHXGvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUHXGv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:51:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40079 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266527AbUHXGvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:51:22 -0400
Subject: Re: [patch] lazy TSS's I/O bitmap copy ...
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1DZAkUvceXIR/HGTOQ1u"
Organization: Red Hat UK
Message-Id: <1093330271.2792.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 24 Aug 2004 08:51:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1DZAkUvceXIR/HGTOQ1u
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-08-23 at 23:23, Davide Libenzi wrote:
> The following patch implements a lazy I/O bitmap copy for the i386=20
> architecture. With I/O bitmaps now reaching considerable sizes, if the=20
> switched task does not perform any I/O operation, we can save the copy=20
> altogether. In my box X is working fine with the following patch, even if=
=20
> more test would be required.


the thing is that X will not hit your fault path, since it runs with
iopl() called... your patch is a nice optimisation for X as a result,
however as test, X is almost worthless ;(

--=-1DZAkUvceXIR/HGTOQ1u
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBKuVfxULwo51rQBIRArIhAJwNuogwxTErHBKj3oSQ0lfZdRdybQCff3tU
3DlQ4zrhFBEWIW0ulsn1WCU=
=RxZh
-----END PGP SIGNATURE-----

--=-1DZAkUvceXIR/HGTOQ1u--

