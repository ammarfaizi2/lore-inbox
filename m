Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUEJIcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUEJIcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 04:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUEJIcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 04:32:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60068 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264560AbUEJIcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 04:32:17 -0400
Subject: Re: dentry bloat.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
In-Reply-To: <409F3CEE.8060102@aitel.hist.no>
References: <20040508120148.1be96d66.akpm@osdl.org>
	 <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
	 <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org>
	 <20040508204239.GB6383@in.ibm.com> <20040508135512.15f2bfec.akpm@osdl.org>
	 <20040508211920.GD4007@in.ibm.com> <20040508171027.6e469f70.akpm@osdl.org>
	 <Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org>
	 <20040508201215.24f0d239.davem@redhat.com>
	 <Pine.LNX.4.58.0405082039510.1592@ppc970.osdl.org>
	 <20040509210312.GL5414@waste.org>  <409F3CEE.8060102@aitel.hist.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EICE8mvYpvxjvrIvmjxL"
Organization: Red Hat UK
Message-Id: <1084177928.4925.13.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 10 May 2004 10:32:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EICE8mvYpvxjvrIvmjxL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-05-10 at 10:27, Helge Hafting wrote:
> Matt Mackall wrote:
>=20
> >One also wonders about whether all the RCU stuff is needed on UP. I'm
> >not sure if I grok all the finepoints here, but it looks like the
> >answer is no and that we can make struct_rcu head empty and have
> >call_rcu fall directly through to the callback. This would save
> >something like 16-32 bytes (32/64bit), not to mention a bunch of
> >dinking around with lists and whatnot.
> >
> >So what am I missing?
> > =20
> >
> Preempt can happen anytime, I believe.

ok so for UP-non-preempt we can still get those 16 bytes back from the
dentry....


--=-EICE8mvYpvxjvrIvmjxL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAnz4HxULwo51rQBIRApfeAJ9bpC67F6M+aoS3t/wR28EGFW5n6QCdEoZl
eRXOM2f6YwGhzR9qifRTX4g=
=LEsx
-----END PGP SIGNATURE-----

--=-EICE8mvYpvxjvrIvmjxL--

