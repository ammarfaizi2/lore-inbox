Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUG2MV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUG2MV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 08:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUG2MV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 08:21:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49641 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264479AbUG2MVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 08:21:54 -0400
Date: Thu, 29 Jul 2004 14:21:09 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Chris Caputo <ccaputo@alt.net>, linux-kernel@vger.kernel.org
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
Message-ID: <20040729122107.GA1024@devserv.devel.redhat.com>
References: <20040729002535.GA5145@logos.cnet> <Pine.LNX.4.44.0407282325460.30510-100000@nacho.alt.net> <20040729075429.GA15700@devserv.devel.redhat.com> <20040729105755.GA6897@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20040729105755.GA6897@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 29, 2004 at 07:57:55AM -0300, Marcelo Tosatti wrote:
> On Thu, Jul 29, 2004 at 09:54:29AM +0200, Arjan van de Ven wrote:
> > On Wed, Jul 28, 2004 at 11:27:41PM -0700, Chris Caputo wrote:
> > > On Wed, 28 Jul 2004, Marcelo Tosatti wrote:
> > > > Changing the affinity writes new values to the IOAPIC registers, I can't see
> > > > how that could interfere with the atomicity of a spinlock operation. I dont
> > > > understand why you think irqbalance could affect anything.
> > > 
> > > Because when I stop running irqbalance the crashes no longer happen.
> > 
> > what is the irq distribution when you do that?
> > Can you run irqbalance for a bit to make sure there's a static distribution
> > of irq's and then disable it and see if it survives ?
> 
> Chris, Yes I'm also running irqbalance. 
> 
> Arjan, what is an easy way for me to make irqbalance change the affinity
> as crazy on the SMP 8way box, just for a test?

there is a sleep(10 seconds) in the code, if you change that to something
really short and then cause irq burst rates on different devices...



--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBCOuzxULwo51rQBIRAuzHAJwKHgNOnH7/k+KxmGUYzyGgy/8ImACgmS3V
/3VfAUkW7G+z6DaW9A9ui60=
=2a6J
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
