Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264405AbUFXMfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUFXMfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 08:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUFXMfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 08:35:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47773 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264405AbUFXMfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 08:35:40 -0400
Date: Thu, 24 Jun 2004 14:35:16 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: using gcc built-ins for bitops?
Message-ID: <20040624123515.GD21376@devserv.devel.redhat.com>
References: <20040624070936.GB30057@devserv.devel.redhat.com> <20040624020022.0601d4ae.akpm@osdl.org> <20040624113151.GA21376@devserv.devel.redhat.com> <20040624120534.GW21264@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <20040624120534.GW21264@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 24, 2004 at 08:05:34AM -0400, Jakub Jelinek wrote:
> On Thu, Jun 24, 2004 at 01:31:51PM +0200, Arjan van de Ven wrote:
> > On Thu, Jun 24, 2004 at 02:00:22AM -0700, Andrew Morton wrote:
> > > For the implementation it would be nice to have the old-style
> > > implementations in one header and the new-style ones in a separate header. 
> > > That would create a bit of an all-or-nothing situation, but that should be
> > > OK?
> > 
> > In addition I stuck those in asm-generic since they no longer are
> > architecture specific....
> 
> This is not going to work.
> Say on x86_64, __builtin_ctzl (~word) ends up __ctzdi2 (~word) call in GCC
> 3.4.x, which is not defined in the kernel (in 3.5 it will be bsfq).
> On a bunch of arches which don't have an instruction for ffz operation
> it will always result in a library call.

It's actually fine; the architecture first needs to include this file and
there it can use the proper ifdefs; the functions themselves don't matter,
only when they can be used, and the arch still controls that.


--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA2sqDxULwo51rQBIRAmK7AKCDcYI/uBAf6t5nw/0xx3Uj8FLGzgCaA0Kf
Ds/XMGO8dr0exhzoc1SvsCE=
=p1HF
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
