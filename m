Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWDQWsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWDQWsz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWDQWsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:48:55 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:50315
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751369AbWDQWsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:48:54 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Greg KH <gregkh@suse.de>
Subject: Re: Linux 2.6.16.6
Date: Tue, 18 Apr 2006 00:52:18 +0200
User-Agent: KMail/1.9.1
References: <20060417211128.GA6861@kroah.com> <20060417211206.GB6861@kroah.com>
In-Reply-To: <20060417211206.GB6861@kroah.com>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2219740.DIDpbvZE2Y";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604180052.19361.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2219740.DIDpbvZE2Y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 17 April 2006 23:12, you wrote:
> @@ -352,6 +353,10 @@ static char *make_block_name(struct gend
>  		return NULL;
>  	strcpy(name, block_str);
>  	strcat(name, disk->disk_name);
> +	/* ewww... some of these buggers have / in name... */
> +	s =3D strchr(name, '/');
> +	if (s)
> +		*s =3D '!';
>  	return name;
>  }

Is only one / possible, or better something like this?

	/* ewww... some of these buggers have / in name... */
	s =3D name;
	while ((s =3D strchr(s, '/')) !=3D NULL)
		*s =3D '!';

=2D-=20
Greetings Michael.

--nextPart2219740.DIDpbvZE2Y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBERBwjlb09HEdWDKgRAgfLAJ9eBXsS0ODMa9nw8j0k/Pn3f7bOzwCfQDTV
NuR4fdcrHBtnmpaLOZWRaRo=
=u5Pi
-----END PGP SIGNATURE-----

--nextPart2219740.DIDpbvZE2Y--
