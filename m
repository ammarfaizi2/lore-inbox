Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264855AbUGCFQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUGCFQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 01:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUGCFQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 01:16:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19343 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264855AbUGCFQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 01:16:06 -0400
Date: Sat, 3 Jul 2004 07:15:34 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Chris Caputo <ccaputo@alt.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
Message-ID: <20040703051534.GA4998@devserv.devel.redhat.com>
References: <20040625121743.GA24896@logos.cnet> <Pine.LNX.4.44.0407021231040.22597-100000@nacho.alt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407021231040.22597-100000@nacho.alt.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 02, 2004 at 01:00:19PM -0700, Chris Caputo wrote:
> On Fri, 25 Jun 2004, Marcelo Tosatti wrote:
> > On Wed, Jun 23, 2004 at 06:50:48PM -0700, Chris Caputo wrote:
> > > Is it safe to assume that the x86 version of atomic_dec_and_lock(), which
> > > iput() uses, is well trusted?  I figure it's got to be, but doesn't hurt
> > > to ask.
> > 
> > Pretty sure it is, used all over. You can try to use non-optimize version 
> > at lib/dec_and_lock.c for a test.
> 
> My current theory is that occasionally when irqbalance changes CPU
> affinities that the resulting set_ioapic_affinity() calls somehow cause
> either inter-CPU locking or cache coherency or ??? to fail.

or.... some spinlock is just incorrect and having the irqbalance irqlayout
unhides that.. irqbalance only balances very very rarely so I doubt it's the
cause of anything...

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA5kD2xULwo51rQBIRAg2GAJ93mfmiiES+pttYGvASVYX2OPemNgCePKR4
lnZYsF+SCkhlxVVQ4a8JQ9I=
=RKvh
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
