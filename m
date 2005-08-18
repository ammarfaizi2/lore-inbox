Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVHRNDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVHRNDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 09:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVHRNDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 09:03:14 -0400
Received: from sipsolutions.net ([66.160.135.76]:1796 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932217AbVHRNDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 09:03:14 -0400
Subject: Re: pmac_nvram problems
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1124341212.8848.78.camel@gaston>
References: <1124277416.6336.11.camel@localhost>
	 <1124341212.8848.78.camel@gaston>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-O5pnXjaiU5/Tf0sA5j04"
Date: Thu, 18 Aug 2005 15:03:04 +0200
Message-Id: <1124370184.30888.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-O5pnXjaiU5/Tf0sA5j04
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-18 at 15:00 +1000, Benjamin Herrenschmidt wrote:

> There used to be cases where we used the nvram stuff before kmalloc()
> was available. I'll check if this is still the case.

Ah, ok. Makes sense. In that case I suppose it must be #ifdef'ed for the
module case.
=20
> Well... the driver doesn't expect you to boot a different OS while
> suspended to disk :)

Yeah :) It'd be nice though since except for that I haven't found any
other adverse effects.

> Regarding caching the data in memory, this is done becaues nvram is
> actually a flash on recent machines, and you really want to limit the
> number of write cycles to it.

Ok, makes sense. When I get some time I'll look into converting and
implementing reloading for that case, but now that I compile as a module
and unload it, it hardly is a priority.

Thanks for your answers,
johannes

--=-O5pnXjaiU5/Tf0sA5j04
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQwSHBqVg1VMiehFYAQIJlRAAvXNOowskrtBuc5TGK8USAnKRST3UxGPv
Zg+rQKApO59qyBBkWDNglzbfI8vx06HOBhH67teRERbTfLKS2hml00/x4d9V40yh
GeIRnQ5PfMsaNfi4KICkuD9mhD4MKZcBNwRXci9zfRthDHR2y8vJK3K/YOhdqUpa
8ou3Qb+ATFM9Hg+x0ymyg93o2+44bVC17kMqEiiaqSVXE8HHY71hGA5B/jyXJNM8
BeYzksKnX02zt1wZktFXyON+x+f6JCxqu/IHtRh7MTWcdeVhYVzz647ZOQKx926M
uhg0xmVlOSF/XZW26M8IW+m3AeUcmLEQ7YGriLPKIkmcBKWF/hMBtYgUiylTJTdj
yossVX9/EEt8Ee8Kn+3109jYFrUP1zkpFwU95QdQS0zWtnM0hacDY7KqQ5amQYd/
RBYu0IczAWFJeb1g7lD8rPIxm2nLt2FkYeYI1lBpRg4MEByDNIMb6xwzkTL4bhbn
hkkiQxv0zFL88fhKZ5at7MOZi8qvcuRvNFD8LjvzII8g6IMJwBY+SPMExkjB6dM1
vqYEnoCLintrLWwXXoL0sVf5bzzx7accpBHAvnC1svDdUN7zyQlXeYGgGVtw/0WL
V8Uod23krsr/Xb+AANgBa77K+MmXiw1EdjfmfTGQGuMMsT+ACXw5MrbqD5vCC+/Q
RpxVy3uNNnA=
=Xm5z
-----END PGP SIGNATURE-----

--=-O5pnXjaiU5/Tf0sA5j04--

