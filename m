Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264170AbUE1WX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbUE1WX7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbUE1WQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:16:36 -0400
Received: from zeus.kernel.org ([204.152.189.113]:16305 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264058AbUE1WPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:15:38 -0400
Date: Fri, 28 May 2004 18:15:20 -0400
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: Re: [Prism54-devel] Re: [PATCH 5/14 linux-2.6.7-rc1] prism54: new prism54 kernel compatibility
Message-ID: <20040528221520.GF3330@ruslug.rutgers.edu>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	"Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	prism54-devel@prism54.org
References: <20040524083220.GF3330@ruslug.rutgers.edu> <1085388830.2780.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p5RmKVcV08d4tiXP"
Content-Disposition: inline
In-Reply-To: <1085388830.2780.9.camel@laptop.fenrus.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p5RmKVcV08d4tiXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 24, 2004 at 10:53:50AM +0200, Arjan van de Ven wrote:
> On Mon, 2004-05-24 at 10:32, Luis R. Rodriguez wrote:
> > 2004-03-20      Margit Schubert-While <margitsw@t-online.de>
> >=20
> > * isl_38xx.[ch], isl_ioctl.c, islpci_dev.[ch], islpci_eth.c
> >   islpci_hotplug.c, islpci_mgt.[ch], oid_mgt.c: Adopt new
> >   prism54 kernel compatibility.
> >=20
> > * prismcompat.h, prismcompat24.h: New compatibility work
>=20
>=20
> ewwww this makes the driver quite a bit less readable!
>=20
> for example
>=20
> -#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0)
> -       /* This is 2.6 specific, nicer, shorter, but not in 2.4 yet */
> -       DEFINE_WAIT(wait);
> -       prepare_to_wait(&priv->reset_done, &wait, TASK_UNINTERRUPTIBLE);
> -#else
> -       DECLARE_WAITQUEUE(wait, current);
> -       set_current_state(TASK_UNINTERRUPTIBLE);
> -       add_wait_queue(&priv->reset_done, &wait);
> -#endif
> +       PRISM_DEFWAITQ(priv->reset_done, wait)
>=20
> why not just make a DEFINE_WAIT() and prepare_to_wait() macro for 2.4
> instead ?? so that you can just have the 2.6 version in the code and do
> 2.4 compat in a clean header, as opposed to fouling up the entire driver
> with it.

Thanks for the comment Arjan. This will be fixed.

	Luis

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--p5RmKVcV08d4tiXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAt7n4at1JN+IKUl4RAoGcAJ47A9DbjPkHr6HR5mMMdWQSc/c5rACfecmL
s3R3MYt2YjatTpMO0ohz6qE=
=vb5B
-----END PGP SIGNATURE-----

--p5RmKVcV08d4tiXP--
