Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUIISAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUIISAZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUIIR5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:57:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45778 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266595AbUIIRzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:55:03 -0400
Date: Thu, 9 Sep 2004 19:54:41 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs-2.6.9-rc1-mm4.patch
Message-ID: <20040909175441.GA25686@devserv.devel.redhat.com>
References: <20040908125755.GC3106@holomorphy.com> <Pine.LNX.4.53.0409080932050.15087@montezuma.fsmlabs.com> <20040908143143.A32002@infradead.org> <Pine.LNX.4.53.0409080938470.15087@montezuma.fsmlabs.com> <1094652572.2800.14.camel@laptop.fenrus.com> <20040908182509.GA6009@elte.hu> <20040908211415.GA20168@elte.hu> <20040909175748.A12336@infradead.org> <20040909172401.GA28376@elte.hu> <20040909175314.GD3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20040909175314.GD3106@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Thu, Sep 09, 2004 at 10:53:14AM -0700, William Lee Irwin III wrote:
> On Thu, Sep 09, 2004 at 07:24:01PM +0200, Ingo Molnar wrote:
> > you can find a pretty good approximation done by Scott Wood (and Andrey
> > Panin?) in the ppc/ppc64 portion of the VP patches:
> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-S0
> > basically you only have to zap some of the irq-threading changes such as
> > calls to redirect_hardirq(), do a s/generic_// and zap the PIC changes
> > (these are done for redirection too). Scott has tested those changes so
> > kernel/hardirq.c should work pretty well with ppc/ppc64.
> 
> By any chance can the generic code be made not to be reliant on
> irq_desc[] and/or irq_desc[] being an array?

I would say one step at a time.
First extract out the code that most arch's share already
only THEN start working on seeing if the few remaining ones can be moved in,
and if other cleanups are appropriate

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBQJjhxULwo51rQBIRAs2OAKCCbcpjwZhMR0Ji4PxAQluLB4os7wCgqoqV
cvKG274MJEpRKoBzwizNbmY=
=AoDo
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
