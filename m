Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTIJJXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbTIJJXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:23:24 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:17135 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261176AbTIJJXX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:23:23 -0400
Subject: Re: Efficient IPC mechanism on Linux
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: alexander.riesen@synopsys.COM, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <015601c3777c$8c63b2e0$5aaf7450@wssupremo>
References: <00f201c376f8$231d5e00$beae7450@wssupremo>
	 <20030909175821.GL16080@Synopsys.COM>
	 <001d01c37703$8edc10e0$36af7450@wssupremo>
	 <20030910064508.GA25795@Synopsys.COM>
	 <015601c3777c$8c63b2e0$5aaf7450@wssupremo>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-piKTnjf3Fco8CbRH+MsD"
Organization: Red Hat, Inc.
Message-Id: <1063185795.5021.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 10 Sep 2003 11:23:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-piKTnjf3Fco8CbRH+MsD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-09-10 at 11:18, Luca Veraldi wrote:

> The overhead implied by a memcpy() is the same, in the oder of magnitude,
> ***whatever*** kernel version you can develop.


yes a copy of a page is about 3000 to 4000 cycles on an x86 box in the
uncached case. A pagetable operation (like the cpu setting the accessed
or dirty bit) is in that same order I suspect (maybe half this, but not
a lot less). Changing pagetable content is even more because all the
tlb's and internal cpu state will need to be flushed... which is also a
microcode operation for the cpu. And it's deadly in an SMP environment.


--=-piKTnjf3Fco8CbRH+MsD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Xu2DxULwo51rQBIRAihBAJ9bDCKvKT7UD4YhEobUbAzPtiKMxQCeJc3y
VzJH9CbmiDxXBWYavImXX8Y=
=pVNA
-----END PGP SIGNATURE-----

--=-piKTnjf3Fco8CbRH+MsD--
