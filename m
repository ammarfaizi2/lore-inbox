Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVCVEhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVCVEhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVCVEe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:34:27 -0500
Received: from dea.vocord.ru ([217.67.177.50]:8150 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262467AbVCVEaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:30:08 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Ram <linuxram@us.ibm.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>
In-Reply-To: <1111438349.5860.27.camel@localhost>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
	 <200503170856.57893.jbarnes@engr.sgi.com>
	 <20050318003857.4600af78@zanzibar.2ka.mipt.ru>
	 <200503171405.55095.jbarnes@engr.sgi.com>
	 <1111409303.8329.16.camel@frecb000711.frec.bull.fr>
	 <1111438349.5860.27.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2s65NPKVri2zXq6/yJ//"
Organization: MIPT
Date: Tue, 22 Mar 2005 07:36:36 +0300
Message-Id: <1111466196.23532.17.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 22 Mar 2005 07:29:32 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2s65NPKVri2zXq6/yJ//
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-03-21 at 12:52 -0800, Ram wrote:
> On Mon, 2005-03-21 at 04:48, Guillaume Thouvenin wrote:
> > ChangeLog:
> >=20
> >   - Remove the global cn_fork_lock and replace it by a per CPU=20
> >     counter.=20
> >   - The processor ID has been added in the data part of the message.
> >     Thus datas sent in a message are: "CPU_ID PARENT_PID CHILD_PID"
> >=20
> >   Those modifications were done to be more scalable because, as
> > mentioned by Jesse Barnes, the global cn_fork_lock won't work well on a
> > large CPU system.
> >=20
> >   This patch applies to 2.6.11-mm4.
> Guillaume,
>=20
>      If a bunch of applications are listening for fork events,=20
>      your patch allows any application to turn off the=20
>      fork event notification?  Is this the right behavior?
>=20
>      Should'nt it turn off the fork-event notification when=20
>      the number of listeners become zero?

There is no number of listeners - netlink sockets provide multicast
dataflow.
[Although one can obtain that number].

As far as I can see, Guillaume's application is main management utility
-=20
it can turn on or off some feature, like "ip" can turn on or off
interfaces=20
without waiting when bounded processes decide to exit.

> RP

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-2s65NPKVri2zXq6/yJ//
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCP6DUIKTPhE+8wY0RAiG3AJ9pCpDJjQcwRrysZrOEDvGxO5T9gACdE1T2
vEWwC8C0GN0bCHWXroLR5sk=
=JMQB
-----END PGP SIGNATURE-----

--=-2s65NPKVri2zXq6/yJ//--

