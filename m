Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262945AbTDBFGm>; Wed, 2 Apr 2003 00:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262947AbTDBFGm>; Wed, 2 Apr 2003 00:06:42 -0500
Received: from 210-86-35-88.dialup.xtra.co.nz ([210.86.35.88]:260 "EHLO
	riven.neverborn.ORG") by vger.kernel.org with ESMTP
	id <S262945AbTDBFGk>; Wed, 2 Apr 2003 00:06:40 -0500
Date: Wed, 2 Apr 2003 17:17:55 +1200
From: "leon j. breedt" <ljb@neverborn.org>
To: linux-kernel@vger.kernel.org
Subject: ASUS P4PE spurious hdparm -tT results...UPDATE
Message-ID: <20030402051755.GA3281@riven.neverborn.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i'm still getting the same weird negative test
results for the WDC WD800JB-00CRA1 drive on 2.4.21-pre6:

/dev/hda:
 Timing buffer-cache reads:   -3008 MB in  0.00 seconds =  -inf kB/sec
 Timing buffered disk reads:  -1504 MB in  0.00 seconds =  -inf kB/sec
Hmm.. suspicious results: probably not enough free memory for a proper test.

however...i noticed that when i booted up with kernel 2.4.20-xfs_pre6 
(the Gentoo 1.4rc3 LiveCD kernel), i didn't get strange test results.

the difference between the two seemed to be that the 2.4.20-xfs_pre6 kernel
initialized the drive in mdma2 mode, and didn't support udma5 for the
IDE layer in that version of the kernel. so maybe this is a bug that's
crept in since 2.4.21 and better ICH4 support days?

the IDE layer in that version of the kernel is based on a version from
www.linuxdiskcert.org, i'm not sure how different that is from the
version Alan & c have been working on.

any ideas what may cause this, for just the WDC drive and not the IBM?
both are on the same channel..

thanks,
leon.
