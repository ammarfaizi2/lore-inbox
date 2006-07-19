Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWGSUla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWGSUla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 16:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWGSUla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 16:41:30 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50852 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030305AbWGSUl3 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 16:41:29 -0400
Message-Id: <200607192041.k6JKfK6u005519@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Fwd: Using select in boolean dependents of a tristate symbol
In-Reply-To: Your message of "Wed, 19 Jul 2006 16:17:38 EDT."
             <d120d5000607191317k2e773af3ta5034a37db5ad97d@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <d120d5000607131232i74dfdb9t1a132dfc5dd32bc4@mail.gmail.com> <d120d5000607131235r5cc9b558xfd04a1f3118d8124@mail.gmail.com> <Pine.LNX.4.64.0607140033030.12900@scrub.home> <200607132231.46776.dtor@insightbb.com> <Pine.LNX.4.64.0607141115010.12900@scrub.home>
            <d120d5000607191317k2e773af3ta5034a37db5ad97d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153341680_2943P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Jul 2006 16:41:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153341680_2943P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Jul 2006 16:17:38 EDT, Dmitry Torokhov said:

> Another question for you  - what is the best way to describe
> dependancy of a sub-option on a subsystem so you won't end up with the
> subsystem as a module and user built in. Something like
> 
> config IBM_ASM
>         tristate "Device driver for IBM RSA service processor"
>         depends on X86 && PCI && EXPERIMENTAL
> ...
> config IBM_ASM_INPUT
>         bool "Support for remote keyboard/mouse"
>         depends on IBM_ASM && (INPUT=y || INPUT=IMB_ASM)
> 
> But the above feels yucky. Could we have something like:
> 
>          depends on matching(INPUT, IBM_ASM)

What feels yucky is the dependency of a 'bool' on a tristate.  Does the
ASM_INPUT get used in places where the source file can only be a builtin,
not a module?

--==_Exmh_1153341680_2943P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEvpjwcC3lWbTT17ARAhZ5AJ470B6oMYzXc4G0tieWPt1CckLtNgCfTGss
spyPR9i4gmDlVuFwoY7l7fw=
=xhCw
-----END PGP SIGNATURE-----

--==_Exmh_1153341680_2943P--
