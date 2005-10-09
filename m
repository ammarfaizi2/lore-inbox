Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVJIUAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVJIUAh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 16:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVJIUAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 16:00:37 -0400
Received: from h80ad250e.async.vt.edu ([128.173.37.14]:34491 "EHLO
	h80ad250e.async.vt.edu") by vger.kernel.org with ESMTP
	id S932283AbVJIUAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 16:00:36 -0400
Message-Id: <200510092000.j99K0Pl1006387@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 CONFIG_INPUT_KEYBDEV 
In-Reply-To: Your message of "Sun, 09 Oct 2005 11:41:10 BST."
             <200510091141.10987.nick@linicks.net> 
From: Valdis.Kletnieks@vt.edu
References: <200510091141.10987.nick@linicks.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128888023_2746P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Oct 2005 16:00:23 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128888023_2746P
Content-Type: text/plain; charset=us-ascii

On Sun, 09 Oct 2005 11:41:10 BST, Nick Warne said:
> What exactly does CONFIG_INPUT_KEYBDEV do?
> 
> I found that _not_setting it, 2.4.31 still looks for keyboard at boot:
> 
> Oct  9 10:41:49 kernel: keyboard: Timeout - AT keyboard not present?(ed)
> Oct  9 10:41:50 kernel: keyboard: Timeout - AT keyboard not present?(f4)
> 
> and doing a find/grep in the code reveals that CONFIG_INPUT_KEYBDEV doesn't 
> seem to do anything anywhere except def/undef itself:
> 
> 
> [root@linux-2.4.31]# find . -name \*.h -exec grep -iHn "INPUT_KEYBDEV" {} \;

Try grepping through the *Makefiles* for that.  In many cases, a CONFIG_FOO
variable is used to control whether a given .c is compiled into a .o for
inclusion in the kernel.


--==_Exmh_1128888023_2746P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDSXbXcC3lWbTT17ARAgYaAJ4ktEYyeNs02iQVZG5JraVGIgM56QCfWTIB
4cZcwaKsf+BC0ekSYP/7X2g=
=8HRk
-----END PGP SIGNATURE-----

--==_Exmh_1128888023_2746P--
