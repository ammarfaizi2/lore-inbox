Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVEPSwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVEPSwk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVEPSwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 14:52:40 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:41395 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261809AbVEPSwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 14:52:30 -0400
Subject: Re: [RFC][PATCH (3/7)] new timeofday x86-64 specific changes (v A5)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <1116029971.26454.7.camel@cog.beaverton.ibm.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
	 <1116029872.26454.4.camel@cog.beaverton.ibm.com>
	 <1116029971.26454.7.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 16 May 2005 11:52:23 -0700
Message-Id: <1116269543.26990.71.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	I just realized a last minute function name change didn't get updated
on the x86-64 patch.  This small fix applies on top of my timeofday-
arch-x86-64_A5 patch to resolve the issue.

thanks
-john

arch/x86_64/kernel/vsyscall.c: needs update
Index: arch/x86_64/kernel/vsyscall.c
===================================================================
--- 59012af04a74f0dbf82461c74469537b90e1c8ed/arch/x86_64/kernel/vsyscall.c  (mode:100644)
+++ uncommitted/arch/x86_64/kernel/vsyscall.c  (mode:100644)
@@ -194,7 +194,7 @@
 	}
 
 	/* save off wall time as timeval */
-	vsyscall_gtod_data.wall_time_tv = ns2timeval(wall_time);
+	vsyscall_gtod_data.wall_time_tv = ns_to_timeval(wall_time);
 
 	/* save offset_base */
 	vsyscall_gtod_data.offset_base = offset_base;


