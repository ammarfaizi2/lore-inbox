Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263995AbUFXJRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUFXJRj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 05:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUFXJRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 05:17:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4782 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263995AbUFXJRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 05:17:37 -0400
Date: Thu, 24 Jun 2004 11:17:12 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: using gcc built-ins for bitops?
Message-ID: <20040624091712.GB11805@devserv.devel.redhat.com>
References: <20040624070936.GB30057@devserv.devel.redhat.com> <20040624020022.0601d4ae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20040624020022.0601d4ae.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 24, 2004 at 02:00:22AM -0700, Andrew Morton wrote:
> Arjan van de Ven <arjanv@redhat.com> wrote:
> >
> > gcc 3.4 gained support for several typical bitops as builtin directives.
> >  Using these over inline asm has a few advantages:
> >  * gcc can optimize constants into these better
> >  * gcc can reorder and schedule the code better
> >  * gcc can allocate registers etc better for the code
> > 
> >  The question is if we consider it desirable to go down this road or not. In
> >  order to help that discussion I've attached a patch below that switches the
> >  i386 ffz() function to the gcc builtin version, conditional on gcc having
> >  support for this. Before I go down the road of converting more functions
> >  and/or architectures.... is this worth doing?
> 
> I guess it depends on the resulting code size and quality.  Some extra
> conversions would be needed for that.

for ffz() the exact same assembly instructions are generated in the cases I looked at
(kernel/signal.c); eg no extra code at all.



--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA2pwXxULwo51rQBIRAitxAKCn/GLQUoPbrj9e5MdigvZ0TdCDAQCgo6Dd
2yJNWZ+jgkeJHQt4mHHQMpk=
=wk2u
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
