Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVDAHrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVDAHrd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 02:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVDAHrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 02:47:33 -0500
Received: from dea.vocord.ru ([217.67.177.50]:56987 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262657AbVDAHqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 02:46:55 -0500
Subject: Re: [patch 2.6.12-rc1-mm4] fork_connector: add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Jay Lan <jlan@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, aquynh@gmail.com,
       dean-list-linux-kernel@arctic.org, pj@sgi.com
In-Reply-To: <424C9177.1070404@engr.sgi.com>
References: <1112277542.20919.215.camel@frecb000711.frec.bull.fr>
	 <20050331144428.7bbb4b32.akpm@osdl.org>  <424C9177.1070404@engr.sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5C1nzTtiRuYFuQRwPeHq"
Organization: MIPT
Date: Fri, 01 Apr 2005 11:52:48 +0400
Message-Id: <1112341968.9334.109.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 11:46:14 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5C1nzTtiRuYFuQRwPeHq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-31 at 16:10 -0800, Jay Lan wrote:
> Andrew Morton wrote:
>=20
> >Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> > =20
> >
> >>  This patch adds a fork connector in the do_fork() routine.
> >>...
> >>
> >>  The fork connector is used by the Enhanced Linux System Accounting
> >>project http://elsa.sourceforge.net
> >>   =20
> >>
> >
> >Does it also meet all the in-kernel requirements for other accounting
> >projects?
> >
> >If not, what else do those other projects need?
> > =20
> >
> Hi Andrew,
>=20
> As the discussion in this thread of the past few days showed, this
> patch intends to take care of process grouping, but not the
> accounting data collection. Besides my concern of possibility of
> data loss, this patch also provides CSA information to handle process
> grouping as it intends to do. I plan to run some testing to see percentag=
e
> of data loss when system is under stress test, but improvement at
> CBUS as Evgeniy indicated should help!
>=20
> Please be advised that i still need an do_exit handling to save accountin=
g
> data. But, it is a separate issue.

My five copecks [or two cents]:=20
fork connector with CBUS [with theirs upto 2.5 % degradation
with huge disk writes per fork] are still much faster than any existing
accounting models.

But it is purely accounting project author to think about=20
accounting design though...

> Thanks,
>  - jay
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-5C1nzTtiRuYFuQRwPeHq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTP3QIKTPhE+8wY0RAuazAJ9qP4flXC9w87sbFeWH7PUss9TlpwCgjL2T
Vudk/NFE4yVgl5UwKndrnIU=
=CprN
-----END PGP SIGNATURE-----

--=-5C1nzTtiRuYFuQRwPeHq--

