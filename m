Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265772AbUFDMhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUFDMhH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 08:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265769AbUFDMhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 08:37:06 -0400
Received: from bart.ott.istop.com ([66.11.172.99]:62592 "EHLO jukie.net")
	by vger.kernel.org with ESMTP id S265776AbUFDMgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 08:36:54 -0400
Date: Fri, 4 Jun 2004 08:36:52 -0400
From: Bart Trojanowski <bart@jukie.net>
To: Sushant Sharma <sushant@cs.unm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modifying struct sk_buff
Message-ID: <20040604123652.GI29389@jukie.net>
References: <40BFCA4C.2000904@cs.unm.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
Content-Disposition: inline
In-Reply-To: <40BFCA4C.2000904@cs.unm.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Sushant Sharma <sushant@cs.unm.edu> [040603 20:24]:
> Hi
> I want to add a new member (say uint32_t) in the
> struct sk_buff{...}
> in the file include/linux/skbuff.h.
<snip>
> Do I need to allocate memory for this member
> (  ie add sizeof(_new-member_) to *size* while doing kmalloc()  )

Hi Sushant,

I think you are confusing the allocation of 'data' with the allocation
of 'skb'.

If you add the uint32_t to struct sk_buff you don't have to modify
alloc_skb.  The skbuff_head_cache is informed what size the sk_buff
structure is in skb_init().

-Bart

--=20
				WebSig: http://www.jukie.net/~bart/sig/

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAwGzk/zRZ1SKJaI8RAg34AJ9THCKgDjSfruZKcsQnP0khNex2jwCg5bjz
9cX2xwrE+sTDkBNymzwPryU=
=8L0R
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--
