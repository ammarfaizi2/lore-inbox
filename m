Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUCHJjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbUCHJjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:39:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14742 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262431AbUCHJjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:39:41 -0500
Subject: Re: Some highmem pages still in use after shrink_all_memory()?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andy Isaacson <adi@hexapodia.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040308063639.GA20793@hexapodia.org>
References: <20040307144921.GA189@elf.ucw.cz>
	 <20040307164052.0c8a212b.akpm@osdl.org>
	 <20040308063639.GA20793@hexapodia.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yYfa1jM95IYhBjvWg8eN"
Organization: Red Hat, Inc.
Message-Id: <1078738772.4678.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 08 Mar 2004 10:39:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yYfa1jM95IYhBjvWg8eN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> Note that there are some applications for which it is a *bug* if an
> mlocked page gets written out to magnetic media.  (gpg, for example.)

mlock() does not guarantee things not hitting magnetic media, just as
mlock() doesn't guarantee that the physical address of a page doesn't
change. mlock guarantees that you won't get hard pagefaults and that you
have guaranteed memory for the task at hand (eg for realtime apps and
oom-critical stuff)

--=-yYfa1jM95IYhBjvWg8eN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBATD9SxULwo51rQBIRAo4hAKCkTGaqJcW5hXGgog4Pqac2Jvx9ZgCgh9Tm
tU+TNBbj3d4x1Z/01jXbSTE=
=FkkM
-----END PGP SIGNATURE-----

--=-yYfa1jM95IYhBjvWg8eN--

