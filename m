Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVCJP3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVCJP3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 10:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVCJP3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 10:29:11 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:50651 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261705AbVCJP3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 10:29:04 -0500
Subject: Re: [patch 1/1] /proc/$$/ipaddr and per-task networking bits
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1110464782.6291.95.camel@laptopd505.fenrus.org>
References: <1110464202.9190.7.camel@localhost.localdomain>
	 <1110464782.6291.95.camel@laptopd505.fenrus.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YRsCkO5XgsFS2JFt6t9z"
Date: Thu, 10 Mar 2005 16:28:37 +0100
Message-Id: <1110468517.9190.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.6 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YRsCkO5XgsFS2JFt6t9z
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El jue, 10-03-2005 a las 15:26 +0100, Arjan van de Ven escribi=F3:
> a few questions
> 1) Why is this a config option; if it's useful it should just be always
> on really

Just to be removed if it applies for mainline.

> 2) Can you explain briefly what this is useful for?

For keeping track on the "originating ip address of the
task/process" (the ipv4 address of the user that started the
task/process).
It adds an ipaddr entry if available for each /proc/<pid> entry, among
the API changes.

Example:
root@dg:/usr/src# cat /proc/5907/ipaddr
192.128.102.93

> 3) How does this work for existing stuff if, say, your dhcp lease
> changes and your machine no longer owns a certain IP, what will happen
> to the tasks?
> 4) if a machine has multiple IPs.. which one is chosen ?

The patch has nothing to do with this, as it's objective is different.
See http://lkml.org/lkml/2005/3/10/108 and=20
http://pearls.tuxedo-es.org/patches/selinux-avc_audit-log-curr_ip.patch
if you want useful and real examples on how it works and helps.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-YRsCkO5XgsFS2JFt6t9z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCMGelDcEopW8rLewRAhCTAJ0dHNt2h1yWQxHkAzVLrbZ6paTmGwCeP4fT
d9+NKwLeA7vXU2Amd8U5h0k=
=l5qx
-----END PGP SIGNATURE-----

--=-YRsCkO5XgsFS2JFt6t9z--

