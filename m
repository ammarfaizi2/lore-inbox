Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbUKQJdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbUKQJdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 04:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbUKQJbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 04:31:09 -0500
Received: from kruuna.helsinki.fi ([128.214.205.14]:64223 "EHLO
	kruuna.Helsinki.FI") by vger.kernel.org with ESMTP id S262248AbUKQJaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 04:30:25 -0500
From: Atro Tossavainen <atossava@cc.helsinki.fi>
Message-Id: <200411170930.iAH9UNMf004077@kruuna.Helsinki.FI>
Subject: 2.4.27 and CCISS related problem
To: linux-kernel@vger.kernel.org
Date: Wed, 17 Nov 2004 11:30:23 +0200 (EET)
Reply-To: Atro.Tossavainen@helsinki.fi
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Got a problem with a HP Proliant DL380 with root on a RAID1 behind a
Smart Array 5i+.  It boots up fine with 2.4.25, but halts every time
with 2.4.27.  The following message should be printed:

	HP CISS Driver (v 2.4.50)
	cciss: Device 0xb178 has been found at bus 1 dev 3 func 0
	      blocks= 71122560 block_size= 512
	      heads= 255, sectors= 32, cylinders= 8716 RAID 1(0+1)
	
	blk: queue c04c6c40, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
	Partition check:
	 cciss/c0d0: p1 p2 < p5 p6 p7 p8 >

But instead, it prints:

	blk: queue c04c6c40, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
	Partition check:
	 cciss/c0d0:

and freezes there, but not so badly that Ctl-Alt-Del wouldn't let me
reboot.  Anybody got any ideas?  The kernels I am using are based on
Linus' from ftp.funet.fi, with i2c, lm_sensors and MOSIX added in.
I can try with a completely vanilla 2.4.27 if necessary.

-- 
Atro Tossavainen (Mr.)               / The Institute of Biotechnology at
Systems Analyst, Techno-Amish &     / the University of Helsinki, Finland,
+358-9-19158939  UNIX Dinosaur     / employs me, but my opinions are my own.
< URL : http : / / www . helsinki . fi / %7E atossava / > NO FILE ATTACHMENTS
