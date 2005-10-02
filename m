Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbVJBDH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbVJBDH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 23:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbVJBDH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 23:07:27 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:62646 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750933AbVJBDH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 23:07:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Marc Perkel <marc@perkel.com>
Subject: Re: Making nice niser for system hogging programs
Date: Sun, 2 Oct 2005 13:07:08 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <433F4563.5060700@perkel.com>
In-Reply-To: <433F4563.5060700@perkel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart25094377.7i1kB4xIiX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510021307.10372.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart25094377.7i1kB4xIiX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, 2 Oct 2005 12:26, Marc Perkel wrote:
> Just a thought -----
>
> Programs like cp -a /bigdir /backup and rsync usually bring the server
> to a crawl no matter how much "nice" you put on them. Is there any way
> to make "nice" smarter in that it limits io as well as processor usage?
> If cp and rsyne ran a little slower IO wise then everything else could
> run too.

The latest cfq io scheduler supports io nice levels. By default it links th=
e=20
io nice levels to the cpu nice levels so if you use cfq and set your file=20
commands nice 19 they will use as little io priority as possible. Note this=
=20
only works on the read side but that makes a dramatic difference already.

Cheers
Con

--nextPart25094377.7i1kB4xIiX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDP07eZUg7+tp6mRURAgdGAJ0SwQN5IB455xJdxYWxUMHg6hFwDACffjik
3GOtvgKboxLVyaR8Y81OaqU=
=XsNw
-----END PGP SIGNATURE-----

--nextPart25094377.7i1kB4xIiX--
