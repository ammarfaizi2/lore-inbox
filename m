Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265844AbUFDPyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbUFDPyc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265856AbUFDPyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:54:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30354 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265844AbUFDPv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:51:59 -0400
Date: Fri, 4 Jun 2004 17:51:39 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
Message-ID: <20040604155138.GG16897@devserv.devel.redhat.com>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com> <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org> <20040604154142.GF16897@devserv.devel.redhat.com> <Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f61P+fpdnY2FZS1u"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 04, 2004 at 08:47:11AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 4 Jun 2004, Arjan van de Ven wrote:
> > 
> > the prelink rpm on Fedora has such a tool already fwiw.
> > (it's part of prelink because the elf manipulations needed are quite similar
> > to the ones prelink does so infrastructure is shared)
> 
> Just for fun, can somebody that has the required hardware just test old 
> apps with NX turned on? 

well anyone with an amd64 qualifies.. old apps work for me.

(fwiw FC1 and FC2 already run without the stack being executable if you use
the default distro kernel even on "traditional" x86 cpus, via the segment limit hack)

> In fact, it would be interesting to just hear somebody running an older
> distribution with a new CPU and a new kernel, and see just how many
> programs need to be marked non-NX in "normal running".

I know that in a FC1 full install there are less than 5 binaries that don't
run with NX. (one uses nested functions in C and passes function pointers to
the inner function around which causes gcc to emit a stack trampoline, and
gcc then marks the binary as non-NX, the others have asm in them that we
didn't fix in time to be properly marked).

--f61P+fpdnY2FZS1u
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAwJqJxULwo51rQBIRAp5cAJ90ZDUsY+2c2yUN7K2CvDZNwS6HbACdEpt0
I6cPu4i7GXg3Ec3ygA6uXjc=
=v3l/
-----END PGP SIGNATURE-----

--f61P+fpdnY2FZS1u--
