Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275212AbTHAMZN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 08:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275214AbTHAMZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 08:25:13 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:32696
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S275212AbTHAMZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 08:25:02 -0400
Subject: Re: [SHED][IO-SHED] Are we missing the big picture?
From: Ian Kumlien <pomac@vapor.com>
To: "Ihar \"Philips\" Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F2A2C14.9030801@softhome.net>
References: <fw7N.3DP.11@gated-at.bofh.it>  <3F2A2C14.9030801@softhome.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sbLX3u4ISeQe1k90Zllb"
Message-Id: <1059740622.30747.67.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 01 Aug 2003 14:23:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sbLX3u4ISeQe1k90Zllb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-08-01 at 11:00, Ihar "Philips" Filipau wrote:
>    Am I right - judging from your posting - that we finally reached=20
> moment than Linux will have network-like queueing disciplines for disks=20
> and CPUs?

CPU's? well, we do have a nice sheduler but i wouldn't say network-like
queuing.

>    In any way, CPU/disk throughput just another types of limited resource=
.
>    It would be nice to be able to manage it - who gets more, who gets=20
> less. CPU/disk schedulers by manageability are far behind network.
>    IMHO must have for servers.

Yes, but, thats not what I'm saying.

CFQ as it apparently was called, builds a queue list when the disk is
under load. So you get really fast data access if there is no load, and
a common queue when there is load. The common queue is the bad thing
about CFQ, imagine putting AS there instead... This would mean fast data
access on unloaded systems, better throughput on loaded systems and
prioritization features could hook right in since AS would only be used
during load. IE, you can add all kinds of patches that only matters
during heavy load.

(note: load is only diskload)

> Ian Kumlien wrote:
> > Hi all,
> >=20
> > I have been following the sheduler and interactivity discussions closel=
y
> > but via the marc.theaimsgroup.com archive, So i might be behind etc...
> > =3DP
> >=20
> > [Note: sorry if i sound like mr.know-it-all etc, just trying to get a
> > point across]
> >=20
> > Anyways, i think that the AS discussions that i have seen has missed
> > some points. Getting the processes priority in AS is one thing, but fis=
t
> > of all i think there should be a stand off layer. Let me explain:
> >=20
> > I liked Jens Axobe's 'CBQ' alike implementation (based on the idea of
> > Andrea A. (afair i have the names right) since it does the most
> > important thing... which is *nothing* when there is no load (ie, pass
> > trough).
> >=20
> > AS might be/is the best damn io sheduler for loaded machines but when
> > there is no load, it's overhead. So in my opinion there should be
> > something that first warrants the usage of AS before it's actually
> > engaged.
> >=20
> > And, if it's only engaged during high load, additions like basing the
> > requests priority on the process/tasks priority would make total sense,
> > adding the 'wakeup on wait' or what it was would also make total
> > sense... But how many of your machines uses the disk 100% of the time?
> > (in the real world... )
> >=20
> > I don't know how 'CBQ' was implemented but any 'we are under load now'
> > trigger would do it for me.
> >=20
> > Please see to it that my CC is included in any discussions =3D)
> >=20
> > PS. Or was it a version of SFQ? in that case s/CBQ/SFQ/g
> > DS.
> >=20
--=20
Ian Kumlien <pomac@vapor.com>

--=-sbLX3u4ISeQe1k90Zllb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/KlvO7F3Euyc51N8RAhzcAJ9iPjGvqFsOw0xVfzmaBPfRiWfbiQCfWH4e
3WCtEW06x2DW2uRQTud+2Xk=
=4tTx
-----END PGP SIGNATURE-----

--=-sbLX3u4ISeQe1k90Zllb--

