Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031580AbWK3WdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031580AbWK3WdI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 17:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031585AbWK3WdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 17:33:08 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:65413 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S1031580AbWK3WdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 17:33:07 -0500
Date: Thu, 30 Nov 2006 23:32:59 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.19
Message-ID: <20061130233259.69e0cfb0@laptop.hypervisor.org>
In-Reply-To: <E1GptFQ-0002Yy-00@gondolin.me.apana.org.au>
References: <20061130012600.0dcb1337@laptop.hypervisor.org>
	<E1GptFQ-0002Yy-00@gondolin.me.apana.org.au>
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_kRklf9sOQ.YVObT=ghPrQ=h";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_kRklf9sOQ.YVObT=ghPrQ=h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 01 Dec 2006 08:15:12 +1100 Herbert Xu (HX) wrote:

HX> Udo A. Steinberg <us15@os.inf.tu-dresden.de> wrote:
HX> >=20
HX> > Ok, so 2.6.18 used to get along fine with cryptoloop and 2.6.19 refus=
es to
HX> > cooperate. An strace of "losetup -e aes /dev/loop0 /dev/hda7" without=
 all
HX> > the terminal interaction shows:
HX>=20
HX> Did you enable CONFIG_CRYPTO_CBC?

I didn't and that turned out to be the culprit. With CONFIG_CRYPTO_CBC enab=
led
everything works fine. Thanks, Herbert!

Shouldn't cryptoloop automatically select CONFIG_CRYPTO_CBC if it depends o=
n it?

Cheers,

	- Udo

--Sig_kRklf9sOQ.YVObT=ghPrQ=h
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFb1wenhRzXSM7nSkRAm0UAJ9ZwlbkQhJOusBprLiQlh4hBLhujQCfV8xf
alIoJFQ5fysmGfJf4edavpw=
=LfM8
-----END PGP SIGNATURE-----

--Sig_kRklf9sOQ.YVObT=ghPrQ=h--
