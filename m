Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbTEKUgL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 16:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbTEKUgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 16:36:11 -0400
Received: from h80ad26f9.async.vt.edu ([128.173.38.249]:52904 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261199AbTEKUgK (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 16:36:10 -0400
Message-Id: <200305112048.h4BKmdkc006140@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: Tuncer M zayamut Ayaz <tuncer.ayaz@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100 
In-Reply-To: Your message of "Sun, 11 May 2003 23:28:25 +1200."
             <3191078.1052695705@[192.168.1.249]> 
From: Valdis.Kletnieks@vt.edu
References: <1405.1052575075@www9.gmx.net>
            <3191078.1052695705@[192.168.1.249]>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1146959508P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 11 May 2003 16:48:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1146959508P
Content-Type: text/plain; charset=us-ascii

On Sun, 11 May 2003 23:28:25 +1200, Andrew McGregor <andrew@indranet.co.nz>  said:

> cpufreq and speedstep don't work on Dell P3 laptops anyway, and the 
> *internal power supplies* of the i8x00 series make wierd noises when APM 
> tries to idle the CPU.  The board will do this anyway, without making 
> noise, so linux need not.

Dell Latitude C840 (1.6G Pentium4 Mobile) has the "power supplies buzz at 1Khz
on APM idle" symptom too. I haven't checked the ACPI side of the fence yet, nor
have I gotten brave enough to try the cpufreq and speedstep stuff.

Even *more* bizarre, there's "something odd" done by the seti@home client
(which usually causes 100% CPU use and thus silence) several minutes into a
workunit that causes  the noise to change frequencies - it will start down
around 500hz, sweep up to 1Khz (taking about 2 seconds to do so), and repeat
(so the buzzing is exhibiting a sawtooth wave).  I'm not seeing any paging
or swapping or I/O, so I'm wondering if it's some code walking through a large
array with strides 1/2/4/8/16 (like an FFT) causing different cache hit ratios,
and thus different power consumption patterns while it's stuck on a L1/L2
cache miss.....


--==_Exmh_-1146959508P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+vrcmcC3lWbTT17ARAgoIAJwNdcFE/aSwwaQBjyh6fTv2hfqXNwCfbFuO
Oj+cBtdyDw1vAOkGawDLYp0=
=0UeR
-----END PGP SIGNATURE-----

--==_Exmh_-1146959508P--
