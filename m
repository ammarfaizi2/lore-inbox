Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270934AbTGPP5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270935AbTGPP5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:57:12 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:29824 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270934AbTGPP5F (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:57:05 -0400
Message-Id: <200307161611.h6GGBaLf004493@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Georgi Chorbadzhiyski <gf@unixsol.org>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, jsimmons@infradead.org,
       rubini@vision.unipv.it, vandrove@vc.cvut.cz
Subject: sysfs file size wierdness (was Re: 2.6-test1-mm1 success, tiny mouse and framebuffer problems 
In-Reply-To: Your message of "Wed, 16 Jul 2003 17:47:02 +0300."
             <3F156566.4040206@unixsol.org> 
From: Valdis.Kletnieks@vt.edu
References: <3F156566.4040206@unixsol.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1091787264P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Jul 2003 12:11:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1091787264P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <4482.1058371896.1@turing-police.cc.vt.edu>

On Wed, 16 Jul 2003 17:47:02 +0300, Georgi Chorbadzhiyski said:

> P.S. Every file in sysfs is 4096 bytes, is this normal?

Even better:

# ls -l /sys/devices/system/cpu/cpu0/cpufreq
total 0
-r--r--r--    1 root     root         4096 Jul 16 09:59 cpuinfo_max_freq
-r--r--r--    1 root     root         4096 Jul 16 09:59 cpuinfo_min_freq
-r--r--r--    1 root     root         4096 Jul 16 09:59 scaling_available_governors
-r--r--r--    1 root     root         4096 Jul 16 09:59 scaling_driver
-rw-r--r--    1 root     root         4096 Jul 16 09:59 scaling_governor
-rw-r--r--    1 root     root         4096 Jul 16 09:59 scaling_max_freq
-rw-r--r--    1 root     root         4096 Jul 16 09:59 scaling_min_freq
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
performance
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors 
performance powersave
# echo powersave >| /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
# ls -l /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
-rw-r--r--    1 root     root            0 Jul 16 09:59 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

Started off as 4096, writing makes it go to zero. ;)


--==_Exmh_1091787264P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/FXk4cC3lWbTT17ARAnS6AKDJbDfV7idXLs7LbTNalZyCOPIVVQCff2n+
R/8ko91yFzk3Eu2Jpm9cBPk=
=125G
-----END PGP SIGNATURE-----

--==_Exmh_1091787264P--
