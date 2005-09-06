Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVIFU7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVIFU7K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVIFU7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:59:10 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50573 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750935AbVIFU7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:59:09 -0400
Message-Id: <200509062059.j86Kx17K022141@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: Patch for link detection for R8169 
In-Reply-To: Your message of "Tue, 06 Sep 2005 22:42:21 +0200."
             <20050906204221.GB20862@electric-eye.fr.zoreil.com> 
From: Valdis.Kletnieks@vt.edu
References: <431DA887.2010008@zabrze.zigzag.pl> <20050906194602.GA20862@electric-eye.fr.zoreil.com> <200509062002.j86K28R8019604@turing-police.cc.vt.edu>
            <20050906204221.GB20862@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126040340_2971P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Sep 2005 16:59:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126040340_2971P
Content-Type: text/plain; charset=us-ascii

On Tue, 06 Sep 2005 22:42:21 +0200, Francois Romieu said:

> Currently one can do 'ifconfig ethX up', check the link status, then try
> to DHCP or whatever. Apparently a few drivers do not support tne detection
> of link as presented above. So is it anything like a vendor requirement/a
> standard (or should it be the new right way (TM)) or does the userspace
> needs fixing wrt its expectation ?

The "ifconfig up then check link status" method is probably usable for the
vast majority of cases.  Are there any driver/card combos that *can't* be fixed
to support that?  (A somewhat hidden side effect is that if you're doing this,
the driver also needs to be able to support additional ifconfig calls later
to set encapsulation, address/netmask, and the like.  I've run across dain-bramaged
older hardware/software (not Linux-based) that would require an 'ifconfig down'
followed by 'ifconfig foo <value> bar <value> up' to change stuff....

--==_Exmh_1126040340_2971P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDHgMUcC3lWbTT17ARAg3GAJ9/nwvvG3I4EuFMTDYkuM7ryUm9SACgg2+J
/ckUQee8Z6dwCqYbLbpLhvA=
=5fEW
-----END PGP SIGNATURE-----

--==_Exmh_1126040340_2971P--
