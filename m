Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWF1WKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWF1WKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWF1WKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:10:51 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:399 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751585AbWF1WKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:10:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [Suspend2][ 15/20] [Suspend2] Attempt to freeze processes.
Date: Thu, 29 Jun 2006 08:10:43 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net> <200606280939.02044.nigel@suspend2.net> <Pine.LNX.4.64.0606281943010.24170@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0606281943010.24170@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4175780.brtBgLbhcs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606290810.47025.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4175780.brtBgLbhcs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Hugh.

On Thursday 29 June 2006 04:59, Hugh Dickins wrote:
> On Wed, 28 Jun 2006, Nigel Cunningham wrote:
> > On Tuesday 27 June 2006 23:45, Pavel Machek wrote:
> > > Current code seems to free memory without need to thaw/re-freeze
> > > kernel threads. Have you found bugs in that, or is this unneccessary?
> >
> > Did you read my other email? Try it with a swap file on a journalled
> > filesystem, in a situation where freeing memory will force the swap file
> > to be used.
>
> Hi Nigel,
>
> I may have missed your "other email" in the avalanche ;)

:)

> That particular example sounds dubious to me: it may well have been
> a problem on 2.4, but are you sure that it's still a problem on 2.6?

Yes, I am sure but I'll double check again. What I recall at the moment is =
a=20
deadlock in actually writing the page.

> Andrew very nicely rewrote the swapfile handling, to bmap the whole
> file at swapon time (see setup_swap_extents), and thereafter the only
> difference between using a swapfile and using a disk partition is that
> the swapfile blocks may be fragmented into many extents where the disk
> partition is contiguous.  Much more reliable.
>
> I don't see how your "journalled filesystem" would affect it at all.

Ok. I'll reproduce it and post the trace. Of course it may be that my=20
examination was too superficial and the cause is more subtle.

I'm not sure if I'll have time to do this during this week, but I'll leave=
=20
your message marked Todo so I don't forget.

Thanks for the reply!

Nigel

=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart4175780.brtBgLbhcs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEov5mN0y+n1M3mo0RAlUHAJkBDlfLN4yp/gymi9jykyqFMKs6KgCfbqs3
ezg1b0pY5ZLC6PufqofMuvM=
=STfd
-----END PGP SIGNATURE-----

--nextPart4175780.brtBgLbhcs--
