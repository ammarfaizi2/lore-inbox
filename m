Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751890AbWCKHYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbWCKHYm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 02:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWCKHYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 02:24:42 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:31417 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751866AbWCKHYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 02:24:41 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Subject: Re: Faster resuming of suspend technology.
Date: Sat, 11 Mar 2006 17:22:01 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
In-Reply-To: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1580997.txDfK7LDTO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603111722.05341.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1580997.txDfK7LDTO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 11 March 2006 03:04, Jun OKAJIMA wrote:
> As you might know, one of the key technology of fast booting is suspendin=
g.
> actually, using suspending does fast booting. And very good point is
> not only can do booting desktop and daemons, but apps at once.
> but one big fault --- it is slow for a while after booted because of HDD
> thrashing. (I mention a term suspend as generic one, not refering only to
> Nigel Cunningham's one)
>
> One of the solution of thrashing issue is like this.
> 1. log disk access pattern after booted.
> 2. analyze the log and find common disk access pattern.
> 2. re-order a suspend image using the pattern.
> 3. read-aheading the image after booted.
>
> so far is okay. this is common technique to reduce disk seek.
>
> The problem of above way is,  "Is there common access pattern?".
> I guess there would be.
> The reason is that even what user does is always different, but what pages
> it needs has common pattern. For example, pages which contain glibc or gtk
> libs are always used. So, reading ahead these pages is meaningful, I
> suppose.
>
> What you think? Your opinion is very welcome.
>
>
>                  --- Okajima, Jun. Tokyo, Japan.
>                      http://www.machboot.com

My version doesn't have this problem by default, because it saves a full im=
age=20
of memory unless the user explicitly sets a (soft) upper limit on the image=
=20
size. The image is stored as contiguously as available storage allows, so=20
rereading it quickly isn't so much of an issue (and far less of an issue th=
an=20
discarding the memory before suspending and faulting it back in from all ov=
er=20
the place afterwards).

That said, work has already been done along the lines that you're describin=
g.=20
You might, for example, look at the OLS papers from last year. There was a=
=20
paper there describing work on almost exactly what you're describing.

Hope that helps.

Nigel

--nextPart1580997.txDfK7LDTO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEEnqdN0y+n1M3mo0RAs6+AJ0Z9MA9Bce2axRiyVe9LZ6s+5vptQCdG5J7
MwBLhfvgWEMzKSYeBdiQBtA=
=+5wA
-----END PGP SIGNATURE-----

--nextPart1580997.txDfK7LDTO--
