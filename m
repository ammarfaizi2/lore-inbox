Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVEPV6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVEPV6r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVEPVye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:54:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:16572 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261908AbVEPVxi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:53:38 -0400
Subject: Re: [RFC][PATCH (7/7)] new timeofday i386 vsyscall proof of
	concept (v A5)
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
In-Reply-To: <1116030428.26990.1.camel@cog.beaverton.ibm.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
	 <1116029872.26454.4.camel@cog.beaverton.ibm.com>
	 <1116029971.26454.7.camel@cog.beaverton.ibm.com>
	 <1116030058.26454.10.camel@cog.beaverton.ibm.com>
	 <1116030139.26454.13.camel@cog.beaverton.ibm.com>
	 <1116030222.26454.16.camel@cog.beaverton.ibm.com>
	 <1116030428.26990.1.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 16 May 2005 14:53:32 -0700
Message-Id: <1116280412.13867.33.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
        Yikes, here is another small fix a last minute function name
change caused, this time in the vsyscall-i386 patch.  This small fix
applies on top of my timeofday-vsyscall-i386_A5 patch to resolve the
issue.

Also it was noted that the vsyscall-i386 patch puts the vsyscall config
option in a bad place. I'll fix that in my next release.

Sorry about that.

thanks
-john

arch/i386/kernel/vsyscall-gtod.c: needs update
Index: arch/i386/kernel/vsyscall-gtod.c
===================================================================
--- 9d016193cc103e4ba0026e943774ef0f774bf72f/arch/i386/kernel/vsyscall-gtod.c  (mode:100644)
+++ uncommitted/arch/i386/kernel/vsyscall-gtod.c  (mode:100644)
@@ -113,7 +113,7 @@
 	}
 
 	/* save off wall time as timeval */
-	vsyscall_gtod_data.wall_time_tv = ns2timeval(wall_time);
+	vsyscall_gtod_data.wall_time_tv = ns_to_timeval(wall_time);
 
 	/* save offset_base */
 	vsyscall_gtod_data.offset_base = offset_base;



