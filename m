Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWBAMvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWBAMvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWBAMvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:51:13 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:58589 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1030367AbWBAMvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:51:12 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [ 02/10] [Suspend2] Module (de)registration.
Date: Wed, 1 Feb 2006 22:47:41 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060201113713.6320.99223.stgit@localhost.localdomain> <84144f020602010437n1d738b94m2d08ddfb21fdb300@mail.gmail.com>
In-Reply-To: <84144f020602010437n1d738b94m2d08ddfb21fdb300@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2319334.TVFmczNtqi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602012247.45286.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2319334.TVFmczNtqi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 01 February 2006 22:37, Pekka Enberg wrote:
> Hi,
>
> On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > +++ b/kernel/power/modules.c
> > @@ -0,0 +1,87 @@
>
> [snip]
>
> > +
> > +struct list_head suspend_filters, suspend_writers, suspend_modules;
> > +struct suspend_module_ops *active_writer =3D NULL;
> > +static int num_filters =3D 0, num_ui =3D 0;
> > +int num_writers =3D 0, num_modules =3D 0;
>
> Unneeded assignments, they're already guaranteed to be zeroed.

Good point. Will fix.

> > +       list_add_tail(&module->module_list, &suspend_modules);
> > +       num_modules++;
>
> No locking, why?

Not needed - the callers are _init routines only.

Regards,

Nigel

>                                  Pekka
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2319334.TVFmczNtqi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4K3xN0y+n1M3mo0RAteZAJ9d/sab2XhClzgvL7Lr7N3q+XnXjgCg2dJP
CUIQX64NXq15ggyMMdAH4cg=
=Z+FP
-----END PGP SIGNATURE-----

--nextPart2319334.TVFmczNtqi--
