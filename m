Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263883AbUDVIw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbUDVIw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 04:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbUDVIw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 04:52:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64960 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263883AbUDVIwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 04:52:51 -0400
Date: Thu, 22 Apr 2004 10:52:18 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040422085217.GA30328@devserv.devel.redhat.com>
References: <OF83E740E9.CE27150D-ONC1256E7E.002EED0D-C1256E7E.00305B60@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <OF83E740E9.CE27150D-ONC1256E7E.002EED0D-C1256E7E.00305B60@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 22, 2004 at 10:48:11AM +0200, Martin Schwidefsky wrote:
> 
> 
> 
> 
> > is this generally useful, eg can all architectures use the
> > infrastructure you propose ? I seriously hope so; s390 isn't the only
> > one who would benefit, I'd love to see a generic thing for this.
> 
> It is. All you have to do is to rework the timer functions for the
> architecture you want to support. This can be quite complicated
> though. There are some subtle races if you want to switch of the
> 100 HZ timer for a cpu. We had some problem with cpus that didn't
> want to wake up anymore ...


well my worry is the API; should it be "turn the timer off" or should it be
"the next tick is THIS many from now". The later allows one to use the hw in
one-shot mode (PC's can do this) where the scheduler timeslice expiry ends
up being a timer as well.


--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAh4fBxULwo51rQBIRAvEIAKCbmWvdpmXxySkV+aSlbdyKt5MrqQCeI7aP
6IYgNuyX7PWkZcr7tiXRIIY=
=6fvf
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
