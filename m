Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131562AbQL2VPp>; Fri, 29 Dec 2000 16:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131886AbQL2VPf>; Fri, 29 Dec 2000 16:15:35 -0500
Received: from [63.109.193.245] ([63.109.193.245]:38128 "EHLO
	ninigret.metatel.office") by vger.kernel.org with ESMTP
	id <S131562AbQL2VPX>; Fri, 29 Dec 2000 16:15:23 -0500
Message-Id: <200012292045.PAA17190@ninigret.metatel.office>
From: Rafal Boni <rafal.boni@eDial.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: 2.2.19pre3 and poor reponse to RT-scheduled processes?
X-Mailer: NMH 1.0 / EXMH 2.1.1
Date: Fri, 29 Dec 2000 15:45:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

[...Please CC me on any replies, as I'm not on the list(s)...]

Folks:
	I was experiencing problems with 2.2.16 where the box would go out
	to lunch for a few seconds flushing buffer or paging at inopportune
	times (is there ever an opportune time for the box to become non-
	reponsive for 5 seconds? 8-).

	2.2.19pre3 makes the behaviour much better, but I still see ~ 2sec
	pauses at times.  I'm sending this to the MM list as well, since I
	believe the poor behaviour in 2.2.16 was an MM issue... I don't 
	know where the slowdowns are happening this time around.

	The box in question is running the linux-ha.org heartbeat package,
	which is a RT-scheduled, mlock()'ed process, and as such should
	get as good service as the box is able to mange.  Often, under
	high disk (and/or MM) loads, the box becomes unreponsive for a
	period of time from ~ 1 sec to a high of ~ 2.8sec.

	The test is simply running a 'dd if=/dev/zero of=/u1/big-empty-file
	bs=1k count=512000 && date'.  Generally, the box will sieze up around
	the same time as the the 'dd' finishes (maybe trying to exec date?).

	I'd appreciate any hints at how to reduce the non-reponsiveness 
	window down as much as possible.  I haven't yet looked to see if
	there is a version of the low-latency patches for 2.2.18 or 19pre,
	but I'd appreciate other ideas on tracking this down as well.

Thanks!
- --rafal

- ----
Rafal Boni                                               rafal.boni@eDial.com
 PGP key C7D3024C, print EA49 160D F5E4 C46A 9E91  524E 11E0 7133 C7D3 024C
    Need to get a hold of me?  http://800.eDial.com/rafal.boni@eDial.com

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.0 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE6TPfjEeBxM8fTAkwRAiPaAKDSp1udFSypqq838fwAjQnlFW0m2wCgtycm
xF7xuBroSl3YXCTqUXGDAy0=
=JHLL
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
