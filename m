Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbUBDTlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 14:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUBDTlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 14:41:07 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54914 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263803AbUBDTlC (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 14:41:02 -0500
Message-Id: <200402041940.i14JewOC009826@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Randazzo, Michael" <RANDAZZO@ddc-web.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.x POSIX Compliance/Conformance... 
In-Reply-To: Your message of "Wed, 04 Feb 2004 14:30:39 EST."
             <89760D3F308BD41183B000508BAFAC4104B16F32@DDCNYNTD> 
From: Valdis.Kletnieks@vt.edu
References: <89760D3F308BD41183B000508BAFAC4104B16F32@DDCNYNTD>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151022558P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Feb 2004 14:40:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151022558P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <9818.1075923657.1@turing-police.cc.vt.edu>

On Wed, 04 Feb 2004 14:30:39 EST, "Randazzo, Michael" <RANDAZZO@ddc-web.com>  said:

> I have made attempts to use (Posix semaphores) in my LKM, but find 
> no POSIX support in /lib/modules/<uname -r>/build/include/unistd.h

Attempting to use syscalls intended for userspace while inside the kernel
is generally regarded as Bad Juju.

'man semctl' says:

     Under  Linux,  the  function semctl is not a system call, but is imple-
       mented via the system call ipc(2).

#define __NR_ipc                117

is what you weren't finding in unistd.h

--==_Exmh_1151022558P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAIUrKcC3lWbTT17ARAhYmAJ9MZSRJi9rs6GawBlTi0TrwaESO3gCgwtSm
RoiSGUV/OEyLxjyijdr/SFk=
=D5JH
-----END PGP SIGNATURE-----

--==_Exmh_1151022558P--
