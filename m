Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUEQPxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUEQPxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUEQPxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:53:53 -0400
Received: from panda.sul.com.br ([200.219.150.4]:55052 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S261706AbUEQPxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:53:51 -0400
Date: Mon, 17 May 2004 12:51:37 -0300
To: Robert Picco <Robert.Picco@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm3
Message-ID: <20040517155136.GA25157@cathedrallabs.org>
References: <20040516025514.3fe93f0c.akpm@osdl.org> <20040517125705.GA23455@cathedrallabs.org> <40A8D4D9.2020703@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <40A8D4D9.2020703@hp.com>
From: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> >>+hpet-driver.patch
> >>
> >>HPET clock driver (needs work)
> >>   
> >>
> >this doesn't compiles if ACPI isn't present. patch attached.
> >
> > 
> >
> So you have HPET hardware which can be discovered without ACPI?  How is 
nope, I don't have any hw with HPET.
> the HPET detected?  Are you just using the HPET addresses documented for 
> Southbridge?
then this should be done instead:

- --- 2.6-mm-clean/drivers/char/Kconfig   2004-05-17 09:38:03.000000000 -0300
+++ 2.6-mm/drivers/char/Kconfig 2004-05-17 12:52:16.000000000 -0300
@@ -940,6 +940,7 @@ config RAW_DRIVER
 config HPET
        bool "HPET - High Precision Event Timer"
        default n
+       depends on ACPI
        help
          If you say Y here, you will have a device named "/dev/hpet/XX" for
          each timer supported by the HPET.  The timers are


- --
Aristeu

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqN+IRRJOudsVYbMRAgeuAKCCK5zZHhRDoV2ZsdXfhewo7aKKBwCgiO0u
btq6DvF9SkZUpbAD3d9gg14=
=AxUi
-----END PGP SIGNATURE-----
