Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUIJPQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUIJPQo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUIJPQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:16:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10159 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267478AbUIJPQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:16:09 -0400
Date: Fri, 10 Sep 2004 17:15:38 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040910151538.GA24434@devserv.devel.redhat.com>
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 10, 2004 at 04:07:21PM +0100, Hugh Dickins wrote:
> On Fri, 10 Sep 2004, Martin J. Bligh wrote:
> > 
> > I agree about killing anything but 4K stacks though - having the single
> > page is very compelling - not only can we allocate it easier, but we can
> > also use cache-hot pages from the hot list.
> 
> I think we all agree that's a promising future, and a good discipline.
> But I'm not the only one to doubt we're there yet.
> 

> Chris's patch seems eminently sensible to me.  Why should having separate
> interrupt stack depend on whether you're configured for 4K or 8K stacks?

because it gives people a reason to do sloppy coding.

> Wasn't Andrea worried, a couple of months back, about nested interrupts
> overflowing the 4K interrupt stack?  

I don't think so; interrupts seem to behave quite ok in this regard.
What we should consider regardless is disable the nesting of irqs for
performance reasons but that's an independent matter


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBQcUZxULwo51rQBIRApKcAKCeYEWHGoAbCcbrWwpfDXHzch/4bACfbn7/
ic8vva+T0hN0C87P+MTbf4M=
=ntVb
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
