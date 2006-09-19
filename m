Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWISRC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWISRC6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWISRC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:02:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28582 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030309AbWISRC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:02:57 -0400
Date: Tue, 19 Sep 2006 13:02:17 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Martin Bligh <mbligh@google.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060919170217.GA18646@redhat.com>
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <y0m8xkfer8v.fsf@ton.toronto.redhat.com> <45102067.20601@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <45102067.20601@google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi -

On Tue, Sep 19, 2006 at 09:52:55AM -0700, Martin Bligh wrote:

> >[...]  (How many distributions keep around compilable source
> >trees?)
>
> ???? Boggle. Any distro that cannot find the source code for it's kernel
> deserves a swift kick to the head, plus a red hot poker somewhere else.

My question is more whether they package up such a buildable
configured patched source tree (/usr/src/redhat/BUILD/* in RH-speak),
or just some extract like the .c/.h files.

> >>[...] It seems like all we'd need to do is "list all references to
> >>function, freeze kernel, update all references, continue", [...]
> >
> >One additional problem are external references made *by* the function.
> >Those too would all have to be relocated to the live data.
>=20
> Not sure what you mean ... could you give a quick example?

Think about stuff that any function does.  It calls other functions,
and manipulates global data, which all show up as external references
in the object code.  All those references would have to be patched to
refer to the live running copy of the original compilation unit.


- FChE

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFECKZVZbdDOm/ZT0RArhFAJ9xm0/pw2YJgAPMOq+RutrK50imKACeOXzf
Dvnxfeixfz/jTcPYblrvJjo=
=HeVC
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
