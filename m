Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbVITWVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbVITWVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbVITWVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:21:47 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:39647 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932441AbVITWVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:21:46 -0400
Message-Id: <200509202221.j8KMLhcr032238@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hot-patching 
In-Reply-To: Your message of "Tue, 20 Sep 2005 18:07:17 EDT."
             <43308815.1000200@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <43308815.1000200@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127254903_3303P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Sep 2005 18:21:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127254903_3303P
Content-Type: text/plain; charset=us-ascii

On Tue, 20 Sep 2005 18:07:17 EDT, John Richard Moser said:

> These bugfixes don't typically change the exported binary interface of
> the existing functions being corrected, and so it would be feasible to
> halt all processors and execute an atomic codepath to switch the symbols
> in the running kernel to point to the replacement functions from the old
> ones.  If big functions are split up into smaller ones, as long as the
> interface is the same for all existing functions, it shouldn't matter as
> well.

I believe telco switch software has been doing patch-on-the-fly for quite
a long time.  It's a royal pain in the butt, especially if you have any
dynamic 'struct foo_ops' lurking.

And you can't just plop the code in either - let's say the fix includes "add
a state bit to the 'struct foo_ctl' to track XYZ".  Now you need to think about
the fact that there's likely kmalloc'ed struct foo_ctl's already out there
that don't know about this bit.  Hilarity ensues....

--==_Exmh_1127254903_3303P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDMIt3cC3lWbTT17ARAvFxAJwNL6fuA2ggJ3Vu32OenuuFPZ8uXACePbTx
r40h7nidG2qTbtvOfXJyvEs=
=nEQB
-----END PGP SIGNATURE-----

--==_Exmh_1127254903_3303P--
