Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264516AbTDPQom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTDPQol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:44:41 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:20096 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264512AbTDPQog (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:44:36 -0400
Message-Id: <200304161656.h3GGuQSt004394@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/02/2003 with nmh-1.0.4+dev
To: Antonio Vargas <wind@cocodriloo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RedHat 9 and 2.5.x support 
In-Reply-To: Your message of "Wed, 16 Apr 2003 18:54:08 +0200."
             <20030416165408.GD30098@wind.cocodriloo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030416165408.GD30098@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1559688370P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Apr 2003 12:56:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1559688370P
Content-Type: text/plain; charset=us-ascii

On Wed, 16 Apr 2003 18:54:08 +0200, Antonio Vargas <wind@cocodriloo.com>  said:
> 
> I've just installed RedHat 9 on my desktop machine and I'd like
> if it will support running under 2.5.65+ instead of his usual
> 2.4.19+.

I'm running 2.5.67 on an otherwise mostly-RH9, and it works fine modulo the
usual issues with bleeding-edge kernels.  I've only hit two issues that are
at all redhat specific:

1) Get Rusty's module tools (but you knew that).  If you install them
right, they'll DTRT if you boot a 2.4 kernel too (keep the RH kernel
around just in case. ;)

2) You'll need this work-around for modules, probably:

*** etc/rc.d/rc.sysinit.orig    2003-04-16 12:52:22.780531536 -0400
--- etc/rc.d/rc.sysinit 2003-04-09 21:40:36.000000000 -0400
***************
*** 360,365 ****
--- 360,366 ----
  if ! LC_ALL=C grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/ksyms ]; then
      USEMODULES=y
  fi
+ USEMODULES=y
  
  # Our modutils don't support it anymore, so we might as well remove
  # the preferred link.

(or some other similar work-around for /proc/ksyms not being in 2.5 kernels)

--==_Exmh_-1559688370P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+nYs6cC3lWbTT17ARAn3CAJ9T0scn4Jh/8sRmolf3XCJSknmWvwCeLkZG
U5JtNpbGH+ZjONBfTqdp4c4=
=ry0g
-----END PGP SIGNATURE-----

--==_Exmh_-1559688370P--
