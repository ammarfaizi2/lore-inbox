Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbVJYFN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbVJYFN7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 01:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbVJYFN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 01:13:59 -0400
Received: from h80ad2595.async.vt.edu ([128.173.37.149]:43462 "EHLO
	h80ad2595.async.vt.edu") by vger.kernel.org with ESMTP
	id S1751455AbVJYFN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 01:13:58 -0400
Message-Id: <200510250513.j9P5DjGv004612@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: intel-agp and yenta-socket issues (was Re: 2.6.14-rc5-mm1 
In-Reply-To: Your message of "Mon, 24 Oct 2005 01:48:38 PDT."
             <20051024014838.0dd491bb.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20051024014838.0dd491bb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1130217224_2661P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Oct 2005 01:13:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1130217224_2661P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <4593.1130217215.1@turing-police.cc.vt.edu>

On Mon, 24 Oct 2005 01:48:38 PDT, Andrew Morton said:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/

> +agp-updates-owner-field-of-struct-pci_driver.patch

intel-agp would hang during modprobe until I backed this one out.

Am still seeing a hang trying to modprobe yenta-socket during early boot.  I'm
not seeing any obvious candidates to back out here - the -rc4-mm1 version is
identical, and -rc4-mm1 boots OK for me.

I wasn't seeing any output from alt-sysrq-T, but it occurs to me that maybe
the console level wasn't set nicely yet - this is happening pretty early in
rc.sysinit.

Is there an undocumented requirement for a newer modprobe?  I'm currently
using the Fedora -devel tree's version:

# modprobe -V
module-init-tools version 3.2-pre7


--==_Exmh_1130217224_2661P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQFDXb8IcC3lWbTT17ARAhe6AJiKuvQRvEiFgldUkNzbPIw1+h6jAJ9FIHXC
631KjhByu07hI9B+kWoI3Q==
=u10a
-----END PGP SIGNATURE-----

--==_Exmh_1130217224_2661P--
