Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVCAPTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVCAPTW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVCAPTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:19:22 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:48646 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261920AbVCAPTQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:19:16 -0500
Message-Id: <200503011518.j21FIuQl004840@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1 
In-Reply-To: Your message of "Tue, 01 Mar 2005 13:55:29 GMT."
             <20050301135529.A1940@flint.arm.linux.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20050301012741.1d791cd2.akpm@osdl.org> <200503011336.j21DaaqC008164@turing-police.cc.vt.edu>
            <20050301135529.A1940@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109690335_4708P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Mar 2005 10:18:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109690335_4708P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Mar 2005 13:55:29 GMT, Russell King said:
> On Tue, Mar 01, 2005 at 08:36:36AM -0500, Valdis.Kletnieks@vt.edu wrote:
> > This is still showing the same 'cs: unable to map card memory!' issue on my
> > Dell laptop.  Backing out bk-pci.patch makes it work again.
> > 
> > For what it's worth, the hotplug system wasn't able to initialize the wireless
> > card (TrueMobile 1150) at boot - still needed cardmgr to get it started up.
> > But that might just me being an idiot...
> 
> It's probably a clash between the PCI updates and the PCMCIA updates.
> 
> The PCI updates change the prototype of a helper function for 
> pci_bus_alloc_resource(), but don't touch the actual helper function
> in PCMCIA.

That explains the warning messages that gcc was tossing, which I suspected was
involved...

> This means that the PCI update is actually broken - if it's merged as
> is into Linus' tree, PCMCIA will break there as well.

Is the patch made to PCI actually incorrect, or is the proper way to do this
to propagate the changes into the relevant PCMCIA code?


--==_Exmh_1109690335_4708P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCJIffcC3lWbTT17ARApTMAKCxGxu1qlYvqe1iPgsU8QD+MqESqgCg1nLI
6K/4ZqgxxaOWV5uV9esSg34=
=WRqa
-----END PGP SIGNATURE-----

--==_Exmh_1109690335_4708P--
