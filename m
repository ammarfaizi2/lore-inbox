Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312363AbSCaUNH>; Sun, 31 Mar 2002 15:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312366AbSCaUM5>; Sun, 31 Mar 2002 15:12:57 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:15017 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312363AbSCaUMx>; Sun, 31 Mar 2002 15:12:53 -0500
Date: Sun, 31 Mar 2002 13:12:50 -0700
Message-Id: <200203312012.g2VKCom17088@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: VFS locking changes in 2.5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, Al. I've noticed that you've made changes to the locking rules
for the VFS (for example, the inode lookup() method no longer has the
BKL).

I also note that you've thrown calls to lock_kernel() and
unlock_kernel() into the devfs code. Did you check each place you
added the BKL to devfs that it was needed, or was this just a blind
global operation? At first glance, it appears that many of the places
where the BKL was inserted are not needed.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
