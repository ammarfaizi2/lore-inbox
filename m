Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbUBPNAU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUBPNAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:00:20 -0500
Received: from mail005.syd.optusnet.com.au ([211.29.132.54]:15068 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265258AbUBPNAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:00:12 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.6.3-rc2 v 2.6.3-rc3-mm1 kernbench
Date: Mon, 16 Feb 2004 23:59:42 +1100
User-Agent: KMail/1.6
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Cliff White <cliffw@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402170000.00524.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here's some nice evidence of the sched domains' patch value:
kernbench 0.20 running on an X440 8x1.5Ghz P4HT (2 node)

Time is in seconds. Lower is better (fixed font table)

Summary:
Kernel:		2.6.3-rc2	2.6.3-rc3-mm1
Half(-j8)	120.8		113.0
Optimal(-j64)	81.6		79.3
Max(-j)		82.9		80.3


shorter summary:
2.6.3-rc3-mm1 kicks butt


long winded summary (look at the massive context switch differences):

results.2.6.3-rc2

Average Half Load Run:
Elapsed Time 120.808
User Time 802.428
System Time 92.072
Percent CPU 740
Context Switches 10613.6
Sleeps 26667

Average Optimum Load Run:
Elapsed Time 81.59
User Time 1007.89
System Time 112.36
Percent CPU 1372.6
Context Switches 63006.2
Sleeps 40406

Average Maximum Load Run:
Elapsed Time 82.944
User Time 1012.33
System Time 122.424
Percent CPU 1367.6
Context Switches 44822.2
Sleeps 22161


results.2.6.3-rc3-mm1:

Average Half Load Run:
Elapsed Time 113.008
User Time 742.786
System Time 90.65
Percent CPU 738
Context Switches 28062.6
Sleeps 24571.8

Average Optimum Load Run:
Elapsed Time 79.278
User Time 1007.69
System Time 107.388
Percent CPU 1407
Context Switches 33355
Sleeps 32720

Average Maximum Load Run:
Elapsed Time 80.33
User Time 1009.89
System Time 121.518
Percent CPU 1408.4
Context Switches 31802.4
Sleeps 22905


Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAML6+ZUg7+tp6mRURAiH3AJ0bNPTLxNncxVoT1LivWhe4sXrAyQCeJzXw
6IsBVGzd4yJpR9eW3gZYBPM=
=tDlR
-----END PGP SIGNATURE-----
