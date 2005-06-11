Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVFKAtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVFKAtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 20:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVFKAtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 20:49:35 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:53736 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261506AbVFKAtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 20:49:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc6-mm1
Date: Sat, 11 Jun 2005 10:48:47 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
References: <20050607170853.3f81007a.akpm@osdl.org> <200506110959.53614.kernel@kolivas.org> <1118449942l.11603l.0l@werewolf.able.es>
In-Reply-To: <1118449942l.11603l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5742160.Q1DOL5fPGP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506111048.50169.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5742160.Q1DOL5fPGP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, 11 Jun 2005 10:32, J.A. Magallon wrote:
> On 06.11, Con Kolivas wrote:
> > Here is what the patch _should_ have been. (*same warnings with this
> > patch about math demonstration and untested as should have been posted
> > with the earlier one*)
> >
> > +	if (idle =3D=3D NOT_IDLE || rq->nr_running > 1) {
> > +		unsigned long prio_bias =3D 1;
> > +		if (rq->nr_running)
> > +			prio_bias =3D rq->prio_bias / rq->nr_running;
> > +		source_load *=3D prio_bias;
> > +	}
>
> Again... sorry, I don't try to be picky, just want to know if its worth or
> not...
>
> Would not be better something like:
>
> 	if (idle =3D=3D NOT_IDLE || rq->nr_running > 1) {
> 		if (rq->nr_running)
> 			source_load =3D (source_load*rq->prio_bias) / rq->nr_running;
> 	}

I understand your concern, but by definition rq->nr_running will always be =
a=20
factor of rq->prio_bias so integer math should be fine. Either will do.

Cheers,
Con

--nextPart5742160.Q1DOL5fPGP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCqjTyZUg7+tp6mRURAkHhAJ9/WZObt0WMq7qQ8vCflj4OV6OeNACfYMQf
vLAtNayuy8pYJumZOuWiR9Q=
=HPfd
-----END PGP SIGNATURE-----

--nextPart5742160.Q1DOL5fPGP--
