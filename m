Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270655AbTHJUsV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270667AbTHJUsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:48:21 -0400
Received: from kknd.mweb.co.za ([196.2.45.79]:26336 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id S270655AbTHJUsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:48:19 -0400
Date: Sun, 10 Aug 2003 22:48:53 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test3 responsible for atomic blast!
Message-Id: <20030810224853.4a291e6e.bonganilinux@mweb.co.za>
In-Reply-To: <1060547281.6445.13.camel@localhost.localdomain>
References: <1060547281.6445.13.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="l?=.vn9Q?CU_r._s"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--l?=.vn9Q?CU_r._s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Aug 2003 14:28:01 -0600
Bob Gill <gillb4@telusplanet.net> wrote:

> The really good news is 2.6.0-test3 is *much* more efficient at
> delivering error messages than earlier versions!  
> The following is from /var/log/messages:

8<

> unknown_bootoption+0x0/0xfa
> Aug 10 14:07:38 localhost kernel:
> Aug 10 14:07:38 localhost kernel: bad: scheduling while atomic!
> Aug 10 14:07:38 localhost kernel: Call Trace:
> Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
> Aug 10 14:07:38 localhost kernel:  [<c011d729>] schedule+0x6e4/0x6e9
> Aug 10 14:07:38 localhost kernel:  [<c0107269>] default_idle+0x0/0x2c
> Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
> Aug 10 14:07:38 localhost kernel:  [<c0107269>] default_idle+0x0/0x2c
> Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
> Aug 10 14:07:38 localhost kernel:  [<c0107308>] cpu_idle+0x38/0x3a
> Aug 10 14:07:38 localhost kernel:  [<c039672a>] start_kernel+0x1bd/0x215
> Aug 10 14:07:38 localhost kernel:  [<c039643f>]
> unknown_bootoption+0x0/0xfa
> 
> ... the bad: scheduling while atomic!  keeps blasting away at my screen
> until I shutdown.  I *do* shutdown right away before the system decides
> to really hang (and take out my root partition on next startup like it
> has done when I get these atomic crashes).  Long before any real testing
> begins, nasty bugs like this have to go!
> 
> 
> -- 
> Bob Gill <gillb4@telusplanet.net>

The system wont really hang (and take out you root partition) disable CONFIG_DEBUG_SPINLOCK_SLEEP (kernel hacking -> Sleep-inside-spinlock checking) on you .config if you want them to go away. 

--l?=.vn9Q?CU_r._s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Nq+/+pvEqv8+FEMRAkBNAJ4gFdYBzJxp7eNddfVoQquRnl6jegCfZVcU
RFGDiTvJ3vbRkxFhENEAvMw=
=Zc2t
-----END PGP SIGNATURE-----

--l?=.vn9Q?CU_r._s--
