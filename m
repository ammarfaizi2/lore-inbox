Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265897AbUFDSNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUFDSNO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265903AbUFDSNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:13:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14821 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265897AbUFDSNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:13:01 -0400
Date: Fri, 4 Jun 2004 20:12:41 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Gerhard Mack <gmack@innerfire.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Andy Lutomirski <luto@myrealbox.com>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
Message-ID: <20040604181241.GB407@devserv.devel.redhat.com>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com> <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org> <20040604154142.GF16897@devserv.devel.redhat.com> <Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org> <20040604155138.GG16897@devserv.devel.redhat.com> <Pine.LNX.4.58.0406041408220.31276@innerfire.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406041408220.31276@innerfire.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 04, 2004 at 02:11:00PM -0400, Gerhard Mack wrote:
> On Fri, 4 Jun 2004, Arjan van de Ven wrote:
> 
> > I know that in a FC1 full install there are less than 5 binaries that don't
> > run with NX. (one uses nested functions in C and passes function pointers to
> > the inner function around which causes gcc to emit a stack trampoline, and
> > gcc then marks the binary as non-NX, the others have asm in them that we
> > didn't fix in time to be properly marked).
> 
> Can you tell if GCC uses trampolines for all use of function pointers or
> just ones that use nested functions ?

just for nested functions

> 
> Also, what is the fastest way to check if GCC is marking non-NX?

readelf -l <binary>

should give output with a STACK line, if that says "RW" then it's NX ok, if
it says "RWX" then it's non-NX


--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAwLuYxULwo51rQBIRAtjCAJ9b6gUbGGpOuvohKJ16lT16A4XfKACdF1VZ
NJZM9qZc0+Ao5eQreM9VbOU=
=fWZT
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
