Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269682AbUHZVZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269682AbUHZVZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269677AbUHZVY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:24:57 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:40603 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S269687AbUHZVR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:17:58 -0400
Date: Thu, 26 Aug 2004 17:16:43 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Oliver Neukum <oliver@neukum.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Pete Zaitcev <zaitcev@redhat.com>, arjanv@redhat.com, alan@redhat.com,
       greg@kroah.com, linux-kernel@vger.kernel.org, riel@redhat.com,
       sct@redhat.com
Subject: Re: PF_MEMALLOC in 2.6
Message-ID: <20040826211642.GA30866@babylon.d2dc.net>
Mail-Followup-To: Oliver Neukum <oliver@neukum.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Hugh Dickins <hugh@veritas.com>, Pete Zaitcev <zaitcev@redhat.com>,
	arjanv@redhat.com, alan@redhat.com, greg@kroah.com,
	linux-kernel@vger.kernel.org, riel@redhat.com, sct@redhat.com
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain> <200408200956.50972.oliver@neukum.org> <4125B111.2040308@yahoo.com.au> <200408201052.51178.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <200408201052.51178.oliver@neukum.org>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 20, 2004 at 10:52:51AM +0200, Oliver Neukum wrote:
> Am Freitag, 20. August 2004 10:06 schrieb Nick Piggin:
> > >>So I'd say try to find a way to only use PF_MEMALLOC on behalf of
> > >>a PF_MEMALLOC thread or use a mempool or something.
> > >=20
> > >=20
> > > Then the SCSI layer should pass down the flag.
> > >=20
> >=20
> > It would be ideal from the memory allocator's point of view to do it
> > on a per-request basis like that.
> >=20
> > When the rubber hits the road, I think it is probably going to be very
> > troublesome to do it right that way. For example, what happens when
> > your usb-thingy-thread blocks on a memory allocation while handling a
> > read request, then the system gets low on memory and someone tries to
> > free some by submitting a write request to the USB device?
>=20
> The write request will have to wait.

> Storage cannot do concurrent IO.

I'm going to jump in here and ask a simple question, what is the
blocking point that stops writes happening concurrent with reads?

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

It was then I realized how dire my medical situation was.  Here I was,
a network admin, unable to leave, and here was someone with a broken
network.  And they didn't ask me to fix it.  They didn't even try to
casually pry a hint out of me.
  -- Ryan Tucker in the SDM.

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBLlM6RFMAi+ZaeAERAhuhAKCRo+qmmGZMpQqZPExNvwzjJkgfZgCfXgE0
lFgsu9fFawgfPU/syod0/tY=
=4LJo
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
