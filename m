Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423082AbWBBKge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423082AbWBBKge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423448AbWBBKge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:36:34 -0500
Received: from 60-240-149-171.tpgi.com.au ([60.240.149.171]:50341 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1423082AbWBBKgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:36:33 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 02/10] [Suspend2] Module (de)registration.
Date: Thu, 2 Feb 2006 20:33:03 +1000
User-Agent: KMail/1.9.1
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602012247.45286.nigel@suspend2.net> <20060202095407.GA1981@elf.ucw.cz>
In-Reply-To: <20060202095407.GA1981@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13569877.TKLemIVAAU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602022033.08267.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13569877.TKLemIVAAU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 19:54, Pavel Machek wrote:
> On St 01-02-06 22:47:41, Nigel Cunningham wrote:
> > Hi.
> >
> > On Wednesday 01 February 2006 22:37, Pekka Enberg wrote:
> > > Hi,
> > >
> > > On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > > > +++ b/kernel/power/modules.c
> > > > @@ -0,0 +1,87 @@
> > >
> > > [snip]
> > >
> > > > +
> > > > +struct list_head suspend_filters, suspend_writers, suspend_modules;
> > > > +struct suspend_module_ops *active_writer =3D NULL;
> > > > +static int num_filters =3D 0, num_ui =3D 0;
> > > > +int num_writers =3D 0, num_modules =3D 0;
> > >
> > > Unneeded assignments, they're already guaranteed to be zeroed.
> >
> > Good point. Will fix.
> >
> > > > +       list_add_tail(&module->module_list, &suspend_modules);
> > > > +       num_modules++;
> > >
> > > No locking, why?
> >
> > Not needed - the callers are _init routines only.
>
> And insmod?

Not right now. As I said in the intro, I want to have building as modules=20
being an option again, but right now it's partially removed because of the=
=20
symbol exporting issue.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart13569877.TKLemIVAAU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4d/kN0y+n1M3mo0RAkHOAKCW9xCEKRWySwI1jEAGDPAyh9VQZQCeOE6Q
ROa+MaOWly237F8pQ/e5nAY=
=PfBG
-----END PGP SIGNATURE-----

--nextPart13569877.TKLemIVAAU--
