Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVHMJ4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVHMJ4s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 05:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVHMJ4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 05:56:48 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:50879 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751322AbVHMJ4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 05:56:47 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference  between /dev/kmem and /dev/mem)
Date: Sat, 13 Aug 2005 11:56:23 +0200
User-Agent: KMail/1.7.2
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       hugh@veritas.com
References: <1123796188.17269.127.camel@localhost.localdomain.suse.lists.linux.kernel> <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org.suse.lists.linux.kernel> <p73br432izq.fsf@verdi.suse.de>
In-Reply-To: <p73br432izq.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3108866.xRFNcAgFZ3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508131156.28553.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3108866.xRFNcAgFZ3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Andi,

On Friday 12 August 2005 18:54, Andi Kleen wrote:
> Acessing vmalloc in /dev/mem would be pretty awkward. Yes it doesn't
> also work in mmap of /dev/kmem, but at least in read/write.
> There are quite a lot of scripts that use it for kernel debugging
> like dumping variables. And for that you really want to access modules
> and vmalloc. And it's much easier to parse than /proc/kcore

Perfect! So it should be under CONFIG_DEBUG_KERNEL and default to off.

So you can still debug and we raise the bar higher for rootkits,=20
if they are the only other user.

Too simple?


Regards

Ingo Oeser


--nextPart3108866.xRFNcAgFZ3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC/cPMU56oYWuOrkARAsgoAKDKDOG4wvpAtUgkIrOW79xLXWYNhwCggU0C
vq78hI7yCIv4Wmg0eF5b8y4=
=K3Eo
-----END PGP SIGNATURE-----

--nextPart3108866.xRFNcAgFZ3--
