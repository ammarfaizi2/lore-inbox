Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbUIJGwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUIJGwo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUIJGwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:52:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20395 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266539AbUIJGwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:52:23 -0400
Date: Fri, 10 Sep 2004 08:52:13 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040910065213.GA11140@devserv.devel.redhat.com>
References: <20040909232532.GA13572@taniwha.stupidest.org> <1094798428.2800.3.camel@laptop.fenrus.com> <20040910064519.GA4232@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20040910064519.GA4232@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 09, 2004 at 11:45:19PM -0700, Chris Wedgwood wrote:
> 
> > 4k+irqstacks and 8k basically have near comparable stack space, with
> > this patch you create an option that has more but that is/should be
> > deprecated.
> 
> maybe, but *who* says this is depricated?

I just did ;)

the roadmap was

8K stacks  ->  dual 4k/8k option -> 4k stacks

this roadmap comes down to basically keeping the available stack space equal
over time (because yes if you see overflows with 4k you WILL see them with
8k too just it takes some fun firewall rules and a network interrupt at just
the right time). 

Your proposal adds a temporary "bulb" that suddenly "allows" code to bloat
into it...


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBQU8cxULwo51rQBIRAiyIAJ9xzowK2rjX2oNhtaTX67VqphRyVwCeM/fp
Twbd5HtQho9cB0WlqEO661w=
=KWcc
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
