Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWDRWkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWDRWkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWDRWkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:40:10 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:48088 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750776AbWDRWkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:40:08 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 2/3] swsusp i386 mark special saveable/unsaveable pages
Date: Wed, 19 Apr 2006 08:38:19 +1000
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
References: <1144809501.2865.40.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1144809501.2865.40.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1471791.E1dyOlr3Ju";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604190838.29247.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1471791.E1dyOlr3Ju
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 12 April 2006 12:38, Shaohua Li wrote:
> @@ -1400,6 +1401,111 @@ static void set_mca_bus(int x)
>  static void set_mca_bus(int x) { }
>  #endif
>
> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +static void __init mark_nosave_page_range(unsigned long start, unsigned
> long end) +{
> +	struct page *page;
> +	while (start <=3D end) {

Should this be start < end? (End is usually the first byte of the next zone=
=20
IIUC).

> +		page =3D pfn_to_page(start);
> +		SetPageNosave(page);
> +		start++;
> +	}
> +}
> +
> +static void __init e820_nosave_reserved_pages(void)
> +{
> +	int i;

Regards,

Nigel

--nextPart1471791.E1dyOlr3Ju
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBERWplN0y+n1M3mo0RAk+0AKDkLuFfuIrLfOvJzDKPoeLpOyqVuQCcDOVN
2jhTvMNC2hAdZo7c/eUS9Z4=
=GqHJ
-----END PGP SIGNATURE-----

--nextPart1471791.E1dyOlr3Ju--
