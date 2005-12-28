Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVL1OAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVL1OAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 09:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVL1OAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 09:00:36 -0500
Received: from imf25aec.mail.bellsouth.net ([205.152.59.73]:12263 "EHLO
	imf25aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S964821AbVL1OAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 09:00:36 -0500
Date: Wed, 28 Dec 2005 08:00:21 -0600
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: DervishD <lkml@dervishd.net>
Cc: mailinglists@unix-scripts.com, linux-kernel@vger.kernel.org
Subject: Re: Memory, where's it going?
Message-Id: <20051228080021.44263f03.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <20051228095512.GA25654@DervishD>
References: <dotjb6$j8$1@sea.gmane.org>
	<20051228085328.GA25380@DervishD>
	<026801c60b8d$ef128360$6501a8c0@ndciwkst01>
	<20051228095512.GA25654@DervishD>
X-Mailer: Sylpheed version 2.2.0beta2 (GTK+ 2.6.10; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__28_Dec_2005_08_00_21_-0600_+x=zCJDkf3RlVki3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__28_Dec_2005_08_00_21_-0600_+x=zCJDkf3RlVki3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Uttered DervishD <lkml@dervishd.net>, spake thus:

> > I understand the concept and why things are cached, i've just never
> > seen it cache this much before..
> Swap memory is not used just when the machine has no free memory.
> Although this is a rough explanation and doesn't describe exactly the
> swap mechanism, some apps will remain into swap space even if there's
> plenty of free RAM available, as long as they are not used.=20

Yes.  Let me amplify that..

It is not apps that are being evicted from main memory, only some
of their pages.  The kernel will do "anticipatory swapping", moving
pages that have not be used for some time out to the paging store, to
make room just in case it might be needed for a burst of activity in
the future.  This is a very neat feature.

As you pointed out, do not get excited about having no free memory:
the kernel is just doing its job especially well.

However, DO get excited if swap space gets short or you see frequent
page-in activity.

Cheers

--Signature=_Wed__28_Dec_2005_08_00_21_-0600_+x=zCJDkf3RlVki3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDspp5/0ydqkQDlQERApNhAKCw0jKVnIbVnbetaXoJFGxT7gdPaACfcka2
odJ+TYFYPoFKWCJAxPUPN6Q=
=e50e
-----END PGP SIGNATURE-----

--Signature=_Wed__28_Dec_2005_08_00_21_-0600_+x=zCJDkf3RlVki3--
