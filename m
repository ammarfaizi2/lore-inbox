Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268944AbUIMUHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268944AbUIMUHz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268929AbUIMUHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:07:54 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:28366 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268922AbUIMUFr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:05:47 -0400
Date: Mon, 13 Sep 2004 22:03:59 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Hugh Dickins <hugh@veritas.com>, Alex Zarochentsev <zam@namesys.com>,
       Paul Jackson <pj@sgi.com>, William Lee Irwin III <wli@holomorphy.com>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined atomic_sub_and_test
Message-ID: <20040913200359.GE19399@thundrix.ch>
References: <Pine.LNX.4.44.0409131545100.17907-100000@localhost.localdomain> <Pine.LNX.4.61.0409131731400.877@scrub.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0409131731400.877@scrub.home>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Mon, Sep 13, 2004 at 06:03:28PM +0200, Roman Zippel wrote:
> +#define atomic_add_and_test(i,v) (atomic_add_return((i), (v)) == 0)
> +#define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)

This is no longer atomic, is it? I mean, there's no guarantee that the
atomic_add_return   and   the    comparison   are   executed   without
interruption, is there?

I wonder whether it's supposed to be..

>  #define atomic_sub(i, v) atomic_sub_return(i, v)

Maybe for some compilers we should cast away the result?

			Tonnerre

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBRf0u/4bL7ovhw40RAvfoAJ9dswbPoh8MTbXP2U8UMCVTlEsLuACgrawg
PfbYDe0Uu3+bkhdMj1MvErg=
=pomp
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--
