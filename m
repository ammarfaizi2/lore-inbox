Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVDGOmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVDGOmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 10:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVDGOmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 10:42:38 -0400
Received: from dea.vocord.ru ([217.67.177.50]:27529 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262472AbVDGOmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 10:42:35 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Ian Campbell <ijc@hellion.org.uk>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050407142349.GA26743@vrfy.org>
References: <1112859412.18360.31.camel@frecb000711.frec.bull.fr>
	 <1112860419.28858.76.camel@uganda> <1112861638.28858.92.camel@uganda>
	 <1112865153.3086.134.camel@icampbell-debian>
	 <1112867556.28858.135.camel@uganda>
	 <1112870517.3279.42.camel@localhost.localdomain>
	 <1112873074.28858.167.camel@uganda>  <20050407142349.GA26743@vrfy.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-arFnMnDbrUwWRFBv0Xnf"
Organization: MIPT
Date: Thu, 07 Apr 2005 18:49:01 +0400
Message-Id: <1112885341.28858.175.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 07 Apr 2005 18:42:10 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-arFnMnDbrUwWRFBv0Xnf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-07 at 16:23 +0200, Kay Sievers wrote:

> Sure, but seems I need to ask again: What is the exact reason not to impl=
ement
> the muticast message multiplexing/subscription part of the connector as a
> generic part of netlink? That would be nice to have and useful for other
> subsystems too as an option to the current broadcast.

I do not understamd, what is netlink multicast and how it differs from
the
existing behaviour?
Netlink message can be delivered only if someone listens for it.

Subscription part of connector is similar to existing group mechanims,
it is moved a bit higher from do_one_broadcast(),
since it is required for proper high-layer protocol and
it's users do not care about netlink groups, but only it's
own ID's, which can be different.

> Thanks,
> Kay
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-arFnMnDbrUwWRFBv0Xnf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVUhdIKTPhE+8wY0RAmX1AJ0SMYEft6KKOY3SheaMUAeTcXS4QwCeMkwR
fOW8US6iGuKXqRetTDEC/WM=
=hLN/
-----END PGP SIGNATURE-----

--=-arFnMnDbrUwWRFBv0Xnf--

