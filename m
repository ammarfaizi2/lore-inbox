Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVDNGqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVDNGqi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 02:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVDNGqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 02:46:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59347 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261292AbVDNGqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 02:46:35 -0400
Subject: Re: SLEEP_ON_BKLCHECK
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: tsuchiya yoshihiro <yt@labs.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <425DBC76.60804@labs.fujitsu.com>
References: <425DBC76.60804@labs.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rIT90CNVkA7WDtiOJycy"
Organization: Red Hat, Inc.
Date: Thu, 14 Apr 2005 08:46:30 +0200
Message-Id: <1113461190.6293.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rIT90CNVkA7WDtiOJycy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-14 at 09:42 +0900, tsuchiya yoshihiro wrote:
> Hi,
> In Fedora Core3, interruptible_sleep_on() checks if the system is
> lock_kernel()'ed
> by SLEEP_ON_BKLCHECK. Same thing is done in RedHatEL4.
> Also I found a patch including SLEEP_ON_BKLCHECK was posted before,
> but is not included in 2.6.11.
> Why SLEEP_ON_BKLCHECK checks lock_kernel ?

Because you really need to hold the BKL when you call sleep_on() family
of APIs, otherwise you have a very big race.

Also note that you in your code really should not call any of the
sleep_on() family of functions at all! It is a very very deprecated and
defective API!!!!

Can you give the URL to the code where you use this in?
(it is GPL code, right?)

Greetings,
    Arjan van de Ven

--=-rIT90CNVkA7WDtiOJycy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCXhHGpv2rCoFn+CIRAiEqAJ0Ytc1GdjVgPnr/y89UO/Y758+0OACgjOTn
/w6lkWTHJDpR5KdA/A2IG8Y=
=F01x
-----END PGP SIGNATURE-----

--=-rIT90CNVkA7WDtiOJycy--

