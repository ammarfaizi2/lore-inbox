Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWF0HBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWF0HBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWF0HBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:01:15 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:56756 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751062AbWF0HBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:01:14 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Paul Jackson <pj@sgi.com>
Subject: Re: [Suspend2][ 07/13] [Suspend2] Page_alloc paranoia.
Date: Tue, 27 Jun 2006 17:01:06 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net> <20060627044248.15066.52507.stgit@nigel.suspend2.net> <20060626233353.052ae23c.pj@sgi.com>
In-Reply-To: <20060626233353.052ae23c.pj@sgi.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4696431.FHI4yS2Osu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606271701.11008.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4696431.FHI4yS2Osu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 16:33, Paul Jackson wrote:
> Nigel wrote:
> -	do {
> -		if (cpuset_zone_allowed(*z, gfp_mask|__GFP_HARDWALL))
> -			wakeup_kswapd(*z, order);
> -	} while (*(++z));
> +	if (likely(!test_freezer_state(FREEZER_ON))) {
> +		do {
> +			if (cpuset_zone_allowed(*z, gfp_mask|__GFP_HARDWALL))
> +				wakeup_kswapd(*z, order);
> +		} while (*(++z));
> +	}
>
>
> The cpuset_zone_allowed() check above was removed recently, thanks to
> a Chris Wright patch.  So the above patch won't apply to Linus's or
> Andrew's current tree.

This is for 2.6.17. I'm just about to update my git tree. Sorry - forever=20
playing catchup :)

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart4696431.FHI4yS2Osu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoNe2N0y+n1M3mo0RAndrAJ4rpmlcRQ/3Xm4d2oV6gJ6Vmq7n6gCffsn3
tcucRL6J+8nyehbebPSzqGQ=
=vJQh
-----END PGP SIGNATURE-----

--nextPart4696431.FHI4yS2Osu--
