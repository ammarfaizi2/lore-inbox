Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTILJLI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 05:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTILJLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 05:11:08 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:11247 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261299AbTILJLF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 05:11:05 -0400
Subject: Re: [patch] Make slab allocator work with SLAB_MUST_HWCACHE_ALIGN
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       dipankar@in.ibm.com
In-Reply-To: <20030912085921.GB1128@llm08.in.ibm.com>
References: <20030910081654.GA1129@llm08.in.ibm.com>
	 <1063208464.700.35.camel@localhost>
	 <20030911055428.GA1140@llm08.in.ibm.com>
	 <20030911110853.GB3700@llm08.in.ibm.com>
	 <3F60A08A.7040504@colorfullife.com>
	 <20030912085921.GB1128@llm08.in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YiUMQHEfEJxEpFFYacZh"
Organization: Red Hat, Inc.
Message-Id: <1063357837.5021.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Fri, 12 Sep 2003 11:10:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YiUMQHEfEJxEpFFYacZh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-09-12 at 10:59, Ravikiran G Thirumalai wrote:

> > I have two concerns:
> > - what about users that compile a kernel for a pIII and then run it on =
a=20
> > p4? L1_CACHE_BYTES is 32 bytes, but the real cache line size is 128 byt=
es.
>=20
> If the target cpu is chosen properly during compile time, L1_CACHE_BYTES
> is set accordingly (CONFIG_X86_L1_CACHE_SHIFT on x86) so this should
> not be an issue right?

In my opinion there is no excuse to make such an assumption at compile
time if its basically free to do it at runtime instead...
for structure padding, using the config setting is obviously the only
way to go; but for kmalloc you can use the runtime, actual, cacheline
size/

--=-YiUMQHEfEJxEpFFYacZh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/YY2NxULwo51rQBIRAmOXAJ0QG+225cXpVlGHDcToMELP2bGoZgCgmdzo
UOroNNP+S13CyQt4GYL4LD4=
=Uxst
-----END PGP SIGNATURE-----

--=-YiUMQHEfEJxEpFFYacZh--
