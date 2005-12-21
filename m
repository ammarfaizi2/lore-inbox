Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVLUVzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVLUVzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVLUVzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:55:20 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:21716 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S932209AbVLUVzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:55:18 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/8] mutex subsystem, add atomic_cmpxchg() to all arches
Date: Wed, 21 Dec 2005 22:55:02 +0100
User-Agent: KMail/1.7.2
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
References: <20051221155435.GC7243@elte.hu>
In-Reply-To: <20051221155435.GC7243@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2303642.qh6Zft2y75";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512212255.11286.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2303642.qh6Zft2y75
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 21 December 2005 16:54, Ingo Molnar wrote:
> add atomic_cmpxchg() to all the architectures. Needed by the new mutex co=
de.
=20
You add atomic_xchg(), since the above exists already.

Please fixup your patch description!

> Index: linux/include/asm-alpha/atomic.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/include/asm-alpha/atomic.h
> +++ linux/include/asm-alpha/atomic.h
> @@ -176,6 +176,7 @@ static __inline__ long atomic64_sub_retu
>  }
> =20
>  #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
> +#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
^^^^^^^^^^^^^^^^^^^^^^ see?


Regards

Ingo Oeser


--nextPart2303642.qh6Zft2y75
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDqc8/U56oYWuOrkARAjuJAJ47T5IRgKV2c3PK3W5Mh8A7sN0adgCgwsk8
8734OxhF1bG/99ogXZu+UPM=
=+sLi
-----END PGP SIGNATURE-----

--nextPart2303642.qh6Zft2y75--
