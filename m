Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267476AbUIJPev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267476AbUIJPev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUIJPev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:34:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10174 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267476AbUIJPes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:34:48 -0400
Date: Fri, 10 Sep 2004 17:34:21 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040910153421.GD24434@devserv.devel.redhat.com>
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <20040910152852.GC15643@x30.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Fri, Sep 10, 2004 at 05:28:52PM +0200, Andrea Arcangeli wrote:
> On Fri, Sep 10, 2004 at 05:15:38PM +0200, Arjan van de Ven wrote:
> > because it gives people a reason to do sloppy coding.
> 
> it's not about bad drivers, it's about the number of nested interrupts
> not being limited by software right now.
> 
> > What we should consider regardless is disable the nesting of irqs for
> > performance reasons but that's an independent matter
> 
> disabling nesting completely sounds a bit too aggressive, but limiting
> the nesting is probably a good idea.

disabling is actually not a bad idea; hard irq handlers run for a very short
time, but when they nest you effectively have like a semi context switch in
the middle of the work so performance suffers...


--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBQcl8xULwo51rQBIRAtUEAJ93Opmn3LhXb169OVO1vQjTnp8S+QCgoQ9D
vVeJKUxXLSaUXYADyNCX1GI=
=BXIc
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
