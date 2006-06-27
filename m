Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWF0Ges@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWF0Ges (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWF0Ges
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:34:48 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:41391 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932170AbWF0Ger (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:34:47 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Suspend2][ 07/13] [Suspend2] Page_alloc paranoia.
Date: Tue, 27 Jun 2006 16:34:39 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net> <20060627044248.15066.52507.stgit@nigel.suspend2.net> <44A0CC28.5030508@yahoo.com.au>
In-Reply-To: <44A0CC28.5030508@yahoo.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2404754.SRI9aqRPzh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606271634.43662.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2404754.SRI9aqRPzh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 16:11, Nick Piggin wrote:
> Nigel Cunningham wrote:
> > Add paranoia to the page_alloc code to ensure we don't start page recla=
im
> > during suspending.
>
> Nack. Set PF_MEMALLOC if you must.

That would work for the thread doing the suspending. What about other kerne=
l=20
threads that might run and allocate memory during the cycle because of=20
$RANDOM_EVENT? We don't want them triggering memory freeing either.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2404754.SRI9aqRPzh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoNGDN0y+n1M3mo0RAhLDAKD0Dpc0PdjQMcYH0slrS00wu+zlQgCg0PtB
4E3DLGlKbB0+mzpsfWrdfjw=
=owx5
-----END PGP SIGNATURE-----

--nextPart2404754.SRI9aqRPzh--
