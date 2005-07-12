Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVGLMnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVGLMnO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVGLMk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:40:59 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:24256 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261175AbVGLMk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:40:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Date: Tue, 12 Jul 2005 22:39:00 +1000
User-Agent: KMail/1.8.1
Cc: Vojtech Pavlik <vojtech@suse.cz>, George Anzinger <george@mvista.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org, torvalds@osdl.org,
       christoph@lameter.org
References: <200506231828.j5NISlCe020350@hera.kernel.org> <42D310ED.2000407@mvista.com> <20050712121008.GA7804@ucw.cz>
In-Reply-To: <20050712121008.GA7804@ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1318028.KjK24rTyLV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507122239.03559.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1318028.KjK24rTyLV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 12 Jul 2005 22:10, Vojtech Pavlik wrote:
> The PIT crystal runs at 14.3181818 MHz (CGA dotclock, found on ISA, ...)
> and is divided by 12 to get PIT tick rate
>
> 	14.3181818 MHz / 12 =3D 1193182 Hz
>
> The reality is that the crystal is usually off by 50-100 ppm from the
> standard value, depending on temperature.
>
>     HZ   ticks/jiffie  1 second      error (ppm)
> ---------------------------------------------------
>    100      11932      1.000015238      15.2
>    200       5966      1.000015238      15.2
>    250       4773      1.000057143      57.1
>    300       3977      0.999931429     -68.6
>    333       3583      0.999964114     -35.9
>    500       2386      0.999847619    -152.4
>   1000       1193      0.999847619    -152.4
>
> Some HZ values indeed fit the tick frequency better than others, up to
> 333 the error is lost in the physical error of the crystal, for 500 and
> 1000, it definitely is larger, and thus noticeable.
>
> Some (less round and nice) values of HZ would fit even better:
>
>     HZ   ticks/jiffie  1 second      error (ppm)
> ---------------------------------------------------
>     82      14551      1.000000152       0.2


Most interesting... Would 838 Hz be a much better choice than 1000 then?=20
(apart from the ugliness).

Cheers,
COn

--nextPart1318028.KjK24rTyLV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC07nnZUg7+tp6mRURAldYAJ4g6Av2YKAJFUUwRz3YIIAIYcdlBQCcC5WX
gK/c+dQKRbK2ldfnJrnYigI=
=tSrw
-----END PGP SIGNATURE-----

--nextPart1318028.KjK24rTyLV--
