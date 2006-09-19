Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWISU2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWISU2H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWISU2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:28:07 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:22518 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751114AbWISU2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:28:04 -0400
Date: Tue, 19 Sep 2006 16:28:02 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Tom Zanussi <zanussi@us.ibm.com>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap@sources.redhat.com, ltt-dev@shafik.org
Subject: Re: [PATCH] Linux Kernel Markers 0.2 for Linux 2.6.17
Message-ID: <20060919202802.GB552@Krystal>
References: <20060919183447.GA16095@Krystal> <y0m4pv3ek49.fsf@ton.toronto.redhat.com> <20060919193623.GA9459@Krystal> <20060919194515.GB18646@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_Krystal-9150-1158697682-0001-2"
Content-Disposition: inline
In-Reply-To: <20060919194515.GB18646@redhat.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:19:19 up 27 days, 17:28,  6 users,  load average: 0.55, 0.40, 0.37
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-9150-1158697682-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Frank Ch. Eigler (fche@redhat.com) wrote:
> Hi -
>=20
> On Tue, Sep 19, 2006 at 03:36:24PM -0400, Mathieu Desnoyers wrote:
> > [...]
> > > If you don't allow yourself to presume on-the-fly function
> > > recompilation, then these markers would need to be made run-time
> > > rather than compile-time configurable.  That is, not like this:
> > > [...]
>=20
> > By making them run-time configurable, I don't see any whay not to bloat=
 the
> > kernel. How can be embed calls to printk+function+kprobe+djprobe without
> > having some kind of performance impact ?
>=20
> In order to have what we appear to need, we cannot avoid having some
> impact.  (Even NOPs have impact.)
>=20

I am all for giving this decision to the end-user or the distribution which=
 will
configure the kernel. There is no "perfect" or "for all" solution that I am
aware of.

* Users debugging servers will more likely want the kprobe or jprobe option.
* Users interested in high performance tracing will want fprobe and/or jpro=
be.
* Users interested in embedded systems will want to avoid tools outside the
  kernel that rely on module loading : their kernel often not even support
  modules. -> fprobe

> Suppose that mbligh's clever but speculative idea has some nasty flaw,
> once someone tried to reduce it to code.  Do you see that markers
> along the lines you've posted would be unsatisfactory?  With that in
> mind, is there point adding such markers now?
>=20

M. Bligh's idea is an interesting use of fprobes through modules that could=
 make
dynamic tracing more effective for accessing local variables. It does not
change anything to the various needs of the above-mentioned class of users,
except that it may make life of high performance and server users easier. W=
ith
or without his idea, the goal of this marker mechanism is to meet all those
user's different needs.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
=2Egpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-9150-1158697682-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFEFLSPyWo/juummgRAjSWAJ0SRMVFnjSG2pwnx0JXC54OTC3OMgCgpFoT
xXm3Gli0Fh5f5Vb1OOB9ILs=
=IsJ6
-----END PGP SIGNATURE-----

--=_Krystal-9150-1158697682-0001-2--
