Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268858AbUHUHk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268858AbUHUHk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 03:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268829AbUHUHk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 03:40:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46277 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268858AbUHUHkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 03:40:23 -0400
Subject: Re: Dumping kernel log (dmesg) and backtraces after a panic
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Chris Johns <cbjohns@mn.rr.com>
Cc: linux-kernel@vger.kernel.org, kaos@oss.sgi.com
In-Reply-To: <C14859EA-F318-11D8-9C0E-000A958E2366@mn.rr.com>
References: <C14859EA-F318-11D8-9C0E-000A958E2366@mn.rr.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-R2A3eFGSTIL24JMStuK2"
Organization: Red Hat UK
Message-Id: <1093074013.2792.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 21 Aug 2004 09:40:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-R2A3eFGSTIL24JMStuK2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-08-21 at 04:21, Chris Johns wrote:
> We're using Red Hat EL3 Linux (2.4.21 base kernel plus 300 or so Red=20
> Hat and/or community patches) and I'm dearly missing KDB already, since=20
> we previously used 2.4.21 from kernel.org and applied the appropriate=20
> KDB patch(es). Now with EL3, I'm not even sure what the right patch for=20
> KDB would be.
>=20
> The problem is how to debug a hang or panic without KDB. Specifically,=20
> I'd like to dump out real backtraces of all (or selected) processes=20
> instead of the pseudo-backtraces that the panic or Alt-Sysrq-t=20
> provides, and I'd like to dump out the kernel log buffer (dmesg) after=20
> a hang or panic.
>=20
> When I say "pseudo-backtraces", it seems that the oops/sysrq processing=20
> picks everything that looks like a text address from the stack of each=20
> thread (or the thread that caused the panic) and formats it, rather=20
> than walking the stack back correctly like KDB's 'bt' command does. And=20
> I don't know of any way of getting the 'dmesg' output after a=20
> hang/panic other than by using KDB.


why not use netdump and then analyze the dump on another machine with
"crash" (a gdb variant) ?

--=-R2A3eFGSTIL24JMStuK2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBJvxdxULwo51rQBIRAkTHAJ9/LJYubNp3UxKrkWobgc7xJ6LeegCgqJnk
hFX8AjBRQaPUfr9C4PIiD5g=
=fqnl
-----END PGP SIGNATURE-----

--=-R2A3eFGSTIL24JMStuK2--

