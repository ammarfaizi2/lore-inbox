Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268144AbUJMBQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268144AbUJMBQs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 21:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268166AbUJMBQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 21:16:48 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43659 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268144AbUJMBQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 21:16:45 -0400
Message-Id: <200410130116.i9D1Gjsa010663@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1-VP-T7 - horrid death in vortex_init at boot 
In-Reply-To: Your message of "Tue, 12 Oct 2004 14:27:10 EDT."
             <200410121827.i9CIRAc6014366@turing-police.cc.vt.edu> 
From: Valdis.Kletnieks@vt.edu
References: <200410121827.i9CIRAc6014366@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1750339543P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Oct 2004 21:16:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1750339543P
Content-Type: text/plain; charset=us-ascii

On Tue, 12 Oct 2004 14:27:10 EDT, Valdis.Kletnieks@vt.edu said:

> 2.6.9-rc4-mm1-VP-T7 plus Ingo's patch to profile.c and 3c59x.c to use
> raw_rwlock_t and raw_spinlock_t rather than the non-raw variant.  It croaked
> when it found the onboard ethernet controller on a Dell Latitude C840 laptop:
> 
> lspci says it's a:
> 02:00.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)

> kernel BUG at net/core/net-sysfs.c:384

Ignore this, self-inflicted idiocy - Ingo pointed out that a local tweak
I wrote was fixing a symptom of a problem rather than the cause.  Backing
out said self-inflicted error made it more-or-less happy, and
2.6.9-rc4-mm1-VP-T7 is working on my laptop now....

--==_Exmh_-1750339543P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBbIH9cC3lWbTT17ARAm52AJoCztEl1iIP2r63BkinLt43kJCFPwCfbjKm
TIOmK6b300Umm/TSTaYbeOE=
=yWv1
-----END PGP SIGNATURE-----

--==_Exmh_-1750339543P--
