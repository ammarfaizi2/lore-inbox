Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVCQOt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVCQOt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 09:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVCQOt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 09:49:56 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:9491 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262164AbVCQOtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 09:49:53 -0500
Message-Id: <200503170816.j2H8GOEV004208@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Frank Sorenson <frank@tuxrocks.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] I8K driver facelift 
In-Reply-To: Your message of "Wed, 16 Mar 2005 14:38:50 MST."
             <4238A76A.3040408@tuxrocks.com> 
From: Valdis.Kletnieks@vt.edu
References: <200502240110.16521.dtor_core@ameritech.net> <4233B65A.4030302@tuxrocks.com>
            <4238A76A.3040408@tuxrocks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1111047384_3991P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Mar 2005 03:16:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1111047384_3991P
Content-Type: text/plain; charset=us-ascii

On Wed, 16 Mar 2005 14:38:50 MST, Frank Sorenson said:
> Okay, I replaced the sysfs_ops with ops of my own, and now all the show
> and store functions also accept the name of the attribute as a parameter.
> This lets the functions know what attribute is being accessed, and allows
> us to create attributes that share show and store functions, so things
> don't need to be defined at compile time (I feel slightly evil!).
> 
> This patch puts the correct number of temp sensors and fans into sysfs,
> and only exposes power_status if enabled by the power_status module
> parameter.

Works for me:

[/sys/bus/platform/drivers/i8k/i8k]2 ls -l
total 0
lrwxrwxrwx  1 root root    0 Mar 17 03:02 bus -> ../../../bus/platform
-r--r--r--  1 root root 4096 Mar 17 03:02 cpu_temp
-rw-r--r--  1 root root 4096 Mar 17 03:01 detach_state
lrwxrwxrwx  1 root root    0 Mar 17 03:02 driver -> ../../../bus/platform/drivers/i8k
-r--r--r--  1 root root 4096 Mar 17 03:02 fan1_speed
-rw-r--r--  1 root root 4096 Mar 17 03:02 fan1_state
-r--r--r--  1 root root 4096 Mar 17 03:02 fan2_speed
-rw-r--r--  1 root root 4096 Mar 17 03:02 fan2_state
drwxr-xr-x  2 root root    0 Mar 17 03:02 power
-r--r--r--  1 root root 4096 Mar 17 03:02 power_status
-r--r--r--  1 root root 4096 Mar 17 03:02 temp1
-r--r--r--  1 root root 4096 Mar 17 03:02 temp2

The valyes of the fan* settings, and cpu_temp match what's reported in /proc/i8k.

temp1 is the same as cpu_temp.  temp2 is running about 7C higher and
is still unidentified (though probably the NVidia chip).

I'll give Dmitry's sysfs/array stuff a test tomorrow-ish unless Greg has
comments before then.

--==_Exmh_1111047384_3991P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCOTzYcC3lWbTT17ARAuYCAJ4qDAF2N+Jx7bh8X6fAtKk6XB+k1gCg3hYS
DQNXP8jIQs8rypqoK+kW9qY=
=XleQ
-----END PGP SIGNATURE-----

--==_Exmh_1111047384_3991P--
