Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264513AbUFEG7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbUFEG7l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 02:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUFEG7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 02:59:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18126 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264513AbUFEG7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 02:59:39 -0400
Date: Sat, 5 Jun 2004 08:59:27 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: mlock as non-root: use rlimits
Message-ID: <20040605065926.GB10001@devserv.devel.redhat.com>
References: <20040604112845.GA28413@devserv.devel.redhat.com> <20040604151251.GD16897@devserv.devel.redhat.com> <20040604111804.T22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <20040604111804.T22989@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 04, 2004 at 11:18:04AM -0700, Chris Wright wrote:
> The hugetlbfs and SHM_LOCK bits don't work well with rlimits.  For
> example, it's trivial to corrupt the locked_vm count with a SHM_LOCK
> segment.  I like this, but I think it only works with mlock().  Did I
> miss something?

Hmm I really wanted this rlimit to move to the struct user, but afaik that
work hasn't been merged yet. Once that is done it's easy to fix the SHM
stuff, just keep track of the struct user to which it's accounted. But you
are right, the count can go bonkers if another process unlocks is than that
locked it.

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAwW9OxULwo51rQBIRAgodAJ9T2cAdAOLsNMkWVluqnq2inn88xQCfXD2Z
ht5Ti/fBhF2m4cjo3SnHMyE=
=Bjpd
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
