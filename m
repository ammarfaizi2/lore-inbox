Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266302AbUGKLAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266302AbUGKLAY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 07:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266562AbUGKLAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 07:00:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56033 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266302AbUGKLAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 07:00:13 -0400
Date: Sun, 11 Jul 2004 12:59:37 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       linux-audio-dev@music.columbia.edu
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040711105936.GA13956@devserv.devel.redhat.com>
References: <20040709182638.GA11310@elte.hu> <20040710222510.0593f4a4.akpm@osdl.org> <20040711093209.GA17095@elte.hu> <20040711024518.7fd508e0.akpm@osdl.org> <20040711095039.GA22391@elte.hu> <20040711025855.08afbca1.akpm@osdl.org> <20040711103020.GA24797@elte.hu> <20040711034258.796f8c6a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20040711034258.796f8c6a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 11, 2004 at 03:42:58AM -0700, Andrew Morton wrote:
> > We do not want to enable preempt for Fedora yet because it
> > breaks just too much stuff
> 
> What stuff?

just look over all the "fix preempt" stuff that got added to the kernel in
the last 6 months. Sometimes subtle sometimes less so. From a distribution
POV I don't want a potential slew of basically impossible to reproduce
problems, especially this young in 2.6, there are plenty of other problems
already (and before you ask "which", just look at how many bugs got fixed in
the last X weeks for any value of X, and look at say acpi issues). 
Yes I understand this puts you into a bit of a bad position, several distros
not enabling preempt means that it gets less testing than it should.
However.. there's only so much issues distros can take and with 2.6 still
quite fresh...

 
> > (Long-term i'd like to see preempt be used unconditionally - at which
> > point the 10-line CONFIG_VOLUNTARY_PREEMPT Kconfig and kernel.h change
> > could go away.)
> 
> And "stuff" is already broken on SMP, yes?

That's the classic preempt "myth"; it's true if you ignore per cpu stuff and
some other subtle issues ;) And even then, yes a lot of our drivers are not
quite SMP safe. Take ISDN or any of the other declared SMP-broken drivers.
Not to speak of the ones that aren't declared as such yet still are.
Regardless of Hyperthreading, smp is still quite rare while crappy
hardware/drivers are not.

Do the BROKEN_ON_SMP tests get triggered in Kconfig for PREEMPT ? It probably
should. 

Greetings,
    Arjan van de Ven
--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA8R2YxULwo51rQBIRAiQoAJ43FGXkgGf99Noeb2YXrUMMy/Y58gCfUlZ1
MD+Qdc1jzYMIYJrhVvhvOeU=
=wsnI
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
