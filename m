Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUBQOxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 09:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbUBQOxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 09:53:49 -0500
Received: from h80ad2630.async.vt.edu ([128.173.38.48]:58031 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266221AbUBQOxs (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 09:53:48 -0500
Message-Id: <200402171453.i1HErdBd014457@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Martin Waitz <tali@admingilde.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH} 2.6 and grsecurity 
In-Reply-To: Your message of "Tue, 17 Feb 2004 15:23:33 +0100."
             <20040217142333.GF27996@admingilde.org> 
From: Valdis.Kletnieks@vt.edu
References: <200402170134.i1H1YIAW016949@turing-police.cc.vt.edu>
            <20040217142333.GF27996@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_532536562P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Feb 2004 09:53:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_532536562P
Content-Type: text/plain; charset=us-ascii

On Tue, 17 Feb 2004 15:23:33 +0100, Martin Waitz said:

> you could #define security_enable_* to 0 when CONFIG_SECURITY_*
> is disabled. thay way you don't need the ugly #ifdef in the .c file

Good point - as I mentioned to another person, I was trying to minimize the
code changes if the feature wasn't selected.

> on the other hand, why do one need a syscall anyway.
> only to justify the existence of some ugly lockdown mode?

For testing and backout - if for some odd reason you discover that it breaks
code, an 'echo 0 >' is a lot less disruptive than a full reboot.

The other reason is for distribution - if you're building a kernel for a bunch
of users, some of who disagree with it, you can ship it as the code is, and
then those who don't like one or two features can 'echo 0 >' onto those sysctls
and then 'echo 0 >' onto the one to force them read-only.  Again, less hassle
than rebuilding a kernel with one CONFIG_SECURITY_WHATEVER turned off (and then
remember to re-rebuild on those machines each time a new kernel gets rolled out
- you can just leave the sysctl's in your /etc/rc.* and be happy).


--==_Exmh_532536562P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAMirycC3lWbTT17ARAvr5AKDH5ibMDbBrifCjIljGjfIaBbmv+ACgyAlV
kb8GZ8PJ2nr4FhPENVsW/6s=
=cwIs
-----END PGP SIGNATURE-----

--==_Exmh_532536562P--
