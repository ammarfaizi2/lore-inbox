Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265359AbUEZIce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUEZIce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 04:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUEZIce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 04:32:34 -0400
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:42002 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S265359AbUEZIcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 04:32:32 -0400
From: John Steele Scott <toojays@toojays.net>
To: linux-kernel@vger.kernel.org
Subject: help with 7447A dynamic frequency scaling support
Date: Wed, 26 May 2004 17:55:09 +0930
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405261755.17764.toojays@toojays.net>
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

I have been trying to add cpufreq support to the ppc 7447A chip for my iBook
G4. This entails flipping the DFS bit in HID1 to enable/disable dynamic
frequency scaling (which divides the CPU clock speed by 2).

When I first tried this, it looked like it worked to some extent, but then the
system would lock-up under load soon after switching frequency. One thing I
noticed was that it appears that when the system boots, the DFS bit is set,
i.e. the CPU is only running at half-speed on boot.

So I started again from a fresh set of sources, and this time tried to just
clear the DFS bit so that the system would boot with the CPU at full speed.
However, now the system locks up when it gets to "INIT: version 2.84
booting".

Can anyone suggest why this might occur? I have looked at other cpu-specific
areas of the ppc code, but nothing seems relevant to my situation. I am new
to kernel hacking, but maybe someone with experience has seen this kind of
thing before.

cheers,

John
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Messages with missing or bad signatures may have been forged or modified in transit!

iD8DBQFAtFRr0BW7kPcXjRURAmG8AJwMmJ1/pL7dDLr/ZH+SWi4imd02+ACeNj/I
ZC76rlRIpFdiOl2jaSxG6kg=
=/IeW
-----END PGP SIGNATURE-----
