Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264375AbUFXMVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbUFXMVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 08:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUFXMVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 08:21:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9366 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264375AbUFXMVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 08:21:44 -0400
Date: Thu, 24 Jun 2004 14:21:18 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: using gcc built-ins for bitops?
Message-ID: <20040624122118.GB21376@devserv.devel.redhat.com>
References: <20040624070936.GB30057@devserv.devel.redhat.com> <20040624115146.GA7513@iram.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20040624115146.GA7513@iram.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 24, 2004 at 01:51:46PM +0200, Gabriel Paubert wrote:
> > --- linux-2.6.7/include/linux/compiler-gcc3.h~	2004-06-24 09:26:04.123455290 +0200
> > +++ linux-2.6.7/include/linux/compiler-gcc3.h	2004-06-24 09:26:04.123455290 +0200
> > @@ -19,6 +19,11 @@
> >  # define __attribute_used__	__attribute__((__unused__))
> >  #endif
> >  
> > +#if __GNUC_MINOR__ >= 4
> 
> Please do no test only on minor. People have been arguing
> whether the next major release of GCC should be called 3.5
> or 4.0 since tree-ssa has been merged.

this header is only uses for the gcc major == 3. The header for ==4 and
later has the define unconditional, and the file for major ==2 doesn't have
it at all.


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA2sc9xULwo51rQBIRAkpfAJ4/R6iZ3MEJ32IkEG8Y0XU35834wACfb3Za
UeSfWI6pYqbCCLFIhHgUOHI=
=ZPAs
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
