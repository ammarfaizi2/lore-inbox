Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVDGJtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVDGJtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 05:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVDGJt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 05:49:26 -0400
Received: from dea.vocord.ru ([217.67.177.50]:52453 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262409AbVDGJrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 05:47:23 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Ian Campbell <ijc@hellion.org.uk>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112865153.3086.134.camel@icampbell-debian>
References: <1112859412.18360.31.camel@frecb000711.frec.bull.fr>
	 <1112860419.28858.76.camel@uganda>  <1112861638.28858.92.camel@uganda>
	 <1112865153.3086.134.camel@icampbell-debian>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aY2EqkPKc51MxcAAJTQO"
Organization: MIPT
Date: Thu, 07 Apr 2005 13:52:36 +0400
Message-Id: <1112867556.28858.135.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 07 Apr 2005 13:46:10 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aY2EqkPKc51MxcAAJTQO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-07 at 10:12 +0100, Ian Campbell wrote:
> On Thu, 2005-04-07 at 12:13 +0400, Evgeniy Polyakov wrote:
> > The main idea was to simplify userspace control and notification
> > system - so people did not waste it's time learning how skb's are
> > allocated
> > and processed, how socket layer is designed and what all those
> > netlink_* and NLMSG* mean if they do not need it.
>=20
> Isn't connector built on top of netlink? If so, is there any reason for
> it to be a new subsystem rather than an extension the the netlink API?

Connector is not netlink API extension in any way.
It uses netlink as transport layer, one can change
cn_netlink_send()/cn_input()=20
into something like bidirectional ioctl and use it.

Only one cn_netlink_send() function can be "described" as API
extension,=20
although even it is not entirely true.

Better design explanation can be found in lkml/netdev archives.

> Ian.
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-aY2EqkPKc51MxcAAJTQO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVQLkIKTPhE+8wY0RAhQTAJ9FMt8fevUG+vRvAcSdt2dbtUeCJQCcC908
3P7KCeYrNbElKFV24mV1IpI=
=3QdB
-----END PGP SIGNATURE-----

--=-aY2EqkPKc51MxcAAJTQO--

