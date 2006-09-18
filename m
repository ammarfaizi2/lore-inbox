Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751702AbWIRR1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbWIRR1s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 13:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWIRR1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 13:27:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43941 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751702AbWIRR1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 13:27:47 -0400
Date: Mon, 18 Sep 2006 13:27:05 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918172705.GN3951@redhat.com>
References: <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu> <1158594491.6069.125.camel@localhost.localdomain> <20060918152230.GA12631@elte.hu> <1158596341.6069.130.camel@localhost.localdomain> <20060918161526.GL3951@redhat.com> <1158598927.6069.141.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tctmm6wHVGT/P6vA"
Content-Disposition: inline
In-Reply-To: <1158598927.6069.141.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tctmm6wHVGT/P6vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi -

alan worte:
> > > [...] So its L1 misses more register reloads and the like. Sounds
> > > more and more like wasted clock cycles for debug. [...]
> >=20
> > But it's not just "for debug"!  It is for system administrators,
> > end-users, developers.
>=20
> It is for debug. System administrators and developers also do debug,
> they may just use different tools.=20

Then you're using the term so broadly as to lose specific meaning.

> The percentage of schedule() calls executed across every Linux box
> on the planet where debug is enabled is so close to nil it's
> noise. [...]

Unless one's worried about planetary-scale energy use, I see no point
in multiplying overheads by "every box on the planet".

> > Indeed, there will be some non-zero execution-time cost.  We must be
> > willing to pay *something* in order to enable this functionality.
>=20
> There is an implementation which requires no penalty is paid. Create a
> new elf section which contains something like [...]

Unfortunately, cases in which this sort of out-of-band markup would be
sufficient are pretty much those exact same cases where it is not
necessary.  Remember, the complex cases occur when the compiler munges
up control flow and data accessability, so debuginfo cannot or does
not correctly place the probes and their data gathering compatriots.

- FChE

--tctmm6wHVGT/P6vA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFDtbpVZbdDOm/ZT0RAghXAJ0aO6mcWuFET6QZdygcD3sSJiupQACdHrbc
5tGzeRJ2qsFXg4QY61IWnCs=
=FI7J
-----END PGP SIGNATURE-----

--tctmm6wHVGT/P6vA--
