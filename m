Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUB0HO4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 02:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUB0HO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 02:14:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59365 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261728AbUB0HOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 02:14:49 -0500
Date: Fri, 27 Feb 2004 08:14:45 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Mark Gross <mgross@linux.co.intel.com>
Cc: Tim Bird <tim.bird@am.sony.com>, root@chaos.analogic.com,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why no interrupt priorities?
Message-ID: <20040227071445.GA5695@devserv.devel.redhat.com>
References: <403E4363.2070908@am.sony.com> <403E5EF7.7080309@am.sony.com> <1077831001.4443.9.camel@laptop.fenrus.com> <200402261421.34885.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <200402261421.34885.mgross@linux.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 26, 2004 at 02:21:34PM -0800, Mark Gross wrote:
> > hardware IRQ priorities are useless for the linux model. In linux, the
> > hardirq runs *very* briefly and then lets the softirq context do the
> > longer taking work. hardware irq priorities then don't matter really
> > because the hardirq's are hardly ever interrupted really, and when they
> > are they cause a performance *loss* due to cache trashing. The latency
> > added by waiting briefly is going to be really really short for any sane
> > hardware.
> 
> Keep in mind the context is Linux running on non-sane hardware, sloooow CPUs, 

50Mhz is already really really fast in this context.

> latency sensitive small io buffers etc. Losing system wide throughput to have 
> the hardware codec not be starved is a happy trade off to make.

The point I tried to make was that it would INCREASE latency. Unless you
have misdesigned device drivers, which is something that is fixable :)

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAPu5kxULwo51rQBIRAueRAJ9/9fVkGjp3/kov2GDeJpWoMhkkwQCeMSvh
4YEN64kc5xUfFmcyOJhQwLY=
=qaEk
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
