Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWIULpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWIULpI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 07:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWIULpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 07:45:07 -0400
Received: from pool-71-254-65-206.ronkva.east.verizon.net ([71.254.65.206]:64198
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751083AbWIULpF (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 07:45:05 -0400
Message-Id: <200609211144.k8LBiGjY018080@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: AUDIT=y build failure on ARM
In-Reply-To: Your message of "Wed, 20 Sep 2006 14:49:08 +0200."
             <20060920124908.GA30389@deprecation.cyrius.com>
From: Valdis.Kletnieks@vt.edu
References: <20060920124908.GA30389@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1158839055_7259P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Sep 2006 07:44:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1158839055_7259P
Content-Type: text/plain; charset=us-ascii

On Wed, 20 Sep 2006 14:49:08 +0200, Martin Michlmayr said:
> I get the build failure below with AUDIT=y on ARM.  The problem is
> that lib/audit.c includes asm-generic/audit_dir_write.h which lists a
> number of syscalls that are not defined on ARM (and some other platforms).

And somebody (I forget who) was complaining that some debugging tool was only available
on the x86/sparc/ppc families of CPUs, and didn't like Alan Cox's suggestion
that they go add it.

Given that missing an entire class of syscall (the *at flavors) on an
architecture isn't a deterrent to inclusion, Alan's response was totally
on-target....

(I'm presuming the usual reason for such missing syscalls is that nobody
has bothered trying to run software that uses a *at call on an ARM, so
nobody's bothered wiring them up and thereby increasing the kernel image
size on a platform where it's likely to be *very* important?)

--==_Exmh_1158839055_7259P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFEnsPcC3lWbTT17ARArClAKCEax8MY4tPCPTjyXbXEpVOcGFTIwCg+hd0
DHa7YOBrc55FVgVPqQUFU7o=
=Mr5X
-----END PGP SIGNATURE-----

--==_Exmh_1158839055_7259P--
