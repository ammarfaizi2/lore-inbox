Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVKREYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVKREYE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 23:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVKREYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 23:24:04 -0500
Received: from h80ad2505.async.vt.edu ([128.173.37.5]:54210 "EHLO
	h80ad2505.async.vt.edu") by vger.kernel.org with ESMTP
	id S932448AbVKREYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 23:24:02 -0500
Message-Id: <200511180423.jAI4NiT5003598@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: 2.6.15-rc1-mm1  - immediate system reset at boot
In-Reply-To: Your message of "Thu, 17 Nov 2005 17:23:30 EST."
             <200511172223.jAHMNUEt014746@turing-police.cc.vt.edu> 
From: Valdis.Kletnieks@vt.edu
References: <200511172130.jAHLUCP0010033@turing-police.cc.vt.edu> <20051117111807.6d4b0535.akpm@osdl.org> <8752.1132265686@warthog.cambridge.redhat.com>
            <200511172223.jAHMNUEt014746@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1132287823_2682P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Nov 2005 23:23:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1132287823_2682P
Content-Type: text/plain; charset=us-ascii

On Thu, 17 Nov 2005 17:23:30 EST, Valdis.Kletnieks@vt.edu said:

> Am chasing another issue - once I got past that, it wouldn't boot at all.
> Grub would act like it was loading, then 2 seconds or so later, grub would
> start up again.  My first guess was CONFIG_DEBUG_RODATA=y, but I ruled that
> out.  More detail once I've done some more binary searching and ruled out
> self-inflicted idiocy....

Rebuilt from a completely new and clean tree, 2.6.14-mm1 is fine, 2.6.15-rc1
will start booting OK, -rc1-mm1 chokes up almost instantly.  It doesn't live
long enough for either/both earlyprintk=vga or initcall_debug to output
anything - grub says "loading", clears the screen, and 2 seconds later the
laptop gives the 'ka-chunk' noise it does on a system reset, and I'm looking at
the BIOS splash screen.

Any obvious places to look, or time to play bisection on the 600 patches
in -mm?

--==_Exmh_1132287823_2682P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDfVdPcC3lWbTT17ARAvbpAJ9ud1ges1tUJCBOijYjTQ5LT4GccACg1Lok
PFXft5hy92C00LItyY3U1Mo=
=hGL3
-----END PGP SIGNATURE-----

--==_Exmh_1132287823_2682P--
