Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265628AbUFDQiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbUFDQiY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265848AbUFDQiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:38:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6832 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265628AbUFDQiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:38:22 -0400
Date: Fri, 4 Jun 2004 18:37:54 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, luto@myrealbox.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, akpm@osdl.org, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040604163753.GN16897@devserv.devel.redhat.com>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com> <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org> <20040604154142.GF16897@devserv.devel.redhat.com> <Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org> <20040604155138.GG16897@devserv.devel.redhat.com> <Pine.LNX.4.58.0406040856100.7010@ppc970.osdl.org> <20040604181304.325000cb.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RXc6EO4W1yUvSQ0X"
Content-Disposition: inline
In-Reply-To: <20040604181304.325000cb.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RXc6EO4W1yUvSQ0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 04, 2004 at 06:13:04PM +0200, Andi Kleen wrote:
> > So instead of having complex things to try to turn NX on for suid, we 
> > should aim to turn ot on as widely as possible, _even_if_ that means that 
> > people who upgrade hardware might have to do some trivial MIS stuff.
> 
> That is what is currently done on x86-64 in the major distributions
> (SUSE,Red Hat) at least.

yep.

> Of course that is only for the stack. Making the heap non executable
> is another can of worms. I don't know if Fedora does that
> too, SUSE and mainline x86-64 doesn't.

Fedora makes the heap non executable too; it only broke X which has it's own
shared library loader (which btw had all the right mprotects in place, just
ifdef'd for freebsd, ia64 and a few other architectures that default to
non-executable heap, so we just added x86(-64) to that)

Greetings,
    Arjan van de Ven

--RXc6EO4W1yUvSQ0X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAwKVhxULwo51rQBIRAt+vAJwIvs+LDaMe4+cMm4mdjwWm/0VNGwCgp/sF
Znz8rMbJPGB3hmpvOpczZuI=
=3Lc5
-----END PGP SIGNATURE-----

--RXc6EO4W1yUvSQ0X--
