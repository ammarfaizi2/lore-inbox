Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWBBVbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWBBVbI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWBBVbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:31:07 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:37034 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932267AbWBBVbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:31:06 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Fri, 3 Feb 2006 07:27:35 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022144.40238.nigel@suspend2.net> <Pine.LNX.4.58.0602021446370.13469@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0602021446370.13469@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5943677.6loXn1jsJx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602030727.40172.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5943677.6loXn1jsJx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 22:48, Pekka J Enberg wrote:
> On Wednesday 01 February 2006 23:01, Pekka Enberg wrote:
> > > > +
> > > > +static inline void suspend_initialise_module_lists(void) {
> > > > +       INIT_LIST_HEAD(&suspend_filters);
> > > > +       INIT_LIST_HEAD(&suspend_writers);
> > > > +       INIT_LIST_HEAD(&suspend_modules);
> > > > +}
> > >
> > > I couldn't find a user for this. I would imagine there's only one,
> > > though, and this should be inlined there?
>
> On Thu, 2 Feb 2006, Nigel Cunningham wrote:
> > I forgot to mention re this - yes, there's just one caller, in another
> > set of patches I'll send later (this was just the first set!). Having t=
he
> > function to be inlined in this .h so that it's with other module specif=
ic
> > code, and then used in the caller once it has been #included, isn't that
> > the right way to do things?
>
> Sorry, I can't parse the above :-). My point was that this is
> probably called in a .c file so move the function in that file and
> introduce it whenever you introduce the caller.

I understand that. However if I do it, I separate the routine from the code=
 it=20
logically belongs with. On the other hand, I do no harm by leaving it in th=
e=20
header. We don't end up with multiple copies of the routine.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart5943677.6loXn1jsJx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4nlMN0y+n1M3mo0RAjjQAJ9xp2dKQY1LfiwPUXKPKHudOJcCvgCfSw5x
mrcSfx3nR0VpwuCcVxkePIA=
=eBaa
-----END PGP SIGNATURE-----

--nextPart5943677.6loXn1jsJx--
