Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751875AbWIRSGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbWIRSGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 14:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWIRSGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 14:06:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25802 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751875AbWIRSGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 14:06:02 -0400
Date: Mon, 18 Sep 2006 14:05:10 -0400
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
Message-ID: <20060918180510.GP3951@redhat.com>
References: <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu> <1158594491.6069.125.camel@localhost.localdomain> <20060918152230.GA12631@elte.hu> <1158596341.6069.130.camel@localhost.localdomain> <20060918161526.GL3951@redhat.com> <1158598927.6069.141.camel@localhost.localdomain> <20060918172705.GN3951@redhat.com> <1158602662.6069.147.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MHXEHrrXKLGx71o"
Content-Disposition: inline
In-Reply-To: <1158602662.6069.147.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MHXEHrrXKLGx71o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi -

alan wrote:

> > Unless one's worried about planetary-scale energy use, I see no point
> > in multiplying overheads by "every box on the planet".
>
> Because we are all paying for your debug stuff we aren't
> using. Systems get slow and sucky by the death of a million cuts not
> by one stupid action.

"slow and sucky" happens one machine at a time.  One doesn't perceive
time that is "lost" by a random machine sitting in a hut somewhere
running a bit slower.


> > Unfortunately, cases in which this sort of out-of-band markup would be
> > sufficient are pretty much those exact same cases where it is not
> > necessary.  Remember, the complex cases occur when the compiler munges
> > up control flow and data accessability, so debuginfo cannot or does
> > not correctly place the probes and their data gathering compatriots.
>=20
> Which if understand you right you'd end up unmunging and reducing
> performance for by reducing the options gcc has to make that critical
> code go fast just so you know what register something is living in.

Something like that, but not as drastic.  The effect of a marker would
be to force the compiler to preserve a statement boundary and or
preserve or recreate the values when the marker is active.  It may
interfere with the otherwise optimized code somewhat, but the amount
depends on the details.  For the most time-critical probes, we could
opt for the least powerful/disruptive markers.

- FChE

--3MHXEHrrXKLGx71o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFDt/WVZbdDOm/ZT0RAsC7AJ9k9fGzz27FyaQgSGlBJFFofxHhlQCggZtA
T1K6LJaC27YwEWdmfnDdYf8=
=6xyF
-----END PGP SIGNATURE-----

--3MHXEHrrXKLGx71o--
