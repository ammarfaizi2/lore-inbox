Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265815AbUE1F5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265815AbUE1F5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 01:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUE1F5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 01:57:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46303 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265815AbUE1F5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 01:57:32 -0400
Subject: Re: CONFIG_IRQBALANCE for AMD64?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1085697411.29406.386.camel@forum-beta.geizhals.at>
References: <1085629714.6583.12.camel@hostmaster.org>
	 <40B578F1.3090704@pobox.com> <1085675774.6583.23.camel@hostmaster.org>
	 <20040527170334.GE23262@krispykreme>
	 <1085697411.29406.386.camel@forum-beta.geizhals.at>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dtb8OWO5092fXV3W8G1H"
Organization: Red Hat UK
Message-Id: <1085723846.2782.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 28 May 2004 07:57:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dtb8OWO5092fXV3W8G1H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-05-28 at 00:36, Thomas Zehetbauer wrote:
> Unfortunately I couldn't find much info on the topic, could you please
> provide some more information? Why is there a kirqd at all?

For people with old distributions that didn't include irqbalanced yet ;)

>=20
> What are the differences/advantages/disadvantages between the kirqd and
> the user space implementation?

the userspace implementation implements a more sophisticated algorithm
for balancing irq's (well to be fair, since its in userspace it's easier
to do this so it's not kirqd's failt that it doesn't have that).=20
While I didn't test kirqd to compare, we did see quite a difference
(order of percents) in a specweb load between a naive algorithm in
kirqbalanced and the current algorithm. Otoh few real life workloads get
as many interrupts as specweb ;)

--=-dtb8OWO5092fXV3W8G1H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAttTGxULwo51rQBIRAicmAKCVEfL2iD4b4MznfBEjGzqdXlBvLQCfXy33
PrRRz88fXO1JOBMvggnQm/g=
=Hrk6
-----END PGP SIGNATURE-----

--=-dtb8OWO5092fXV3W8G1H--

