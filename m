Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUIQBFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUIQBFi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 21:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266351AbUIQBFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 21:05:37 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:24799 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266308AbUIQBEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 21:04:54 -0400
Message-ID: <414A382E.3020906@kolivas.org>
Date: Fri, 17 Sep 2004 11:04:46 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: 2.6.8.1-ck8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are patches designed to improve system responsiveness with 
specific emphasis on the desktop, but configurable to any workload.

http://ck.kolivas.org/patches/2.6/2.6.8.1/2.6.8.1-ck8/patch-2.6.8.1-ck8.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches and a server specific patch available.


Changes since 2.6.8.1-ck7
Due to time constraints, stability etc I am sticking to just performance 
patches and bugfixes from this release on. It is getting too hard to 
maintain the other patches and the bug reports that go with them and 
still develop my own patches. There seem to be _many_ people maintaining 
trees based on mine and I prefer they maintain the extra features. There 
seem to be many people maintaining trees based on mine and I prefer they 
maintain the extra features.


Added:
+cfq2 bugfixes
Numerous little additions from Jens Axboe to his CFQ I/O scheduler
+cbq-fixes.diff
Two memory leaks that caused instability in mainline with QoS enabled


Updated:
~from_2.6.8.1_to_staircase8.3
The staircase cpu scheduler has been updated to the latest code. The 
main change is much better cpu accounting separtely from jiffies for 
running tasks to improve fairness. This improves some hardware emulation 
(wine, zsnes, mame etc), some games, some audio software and some 
overall fairness issues.


Rolled up - these patches are rolled up versions of all the inbetween 
patches used in 2.6.8.1-ck7:
+1g_lowmem1_i386.diff
+akpm-latency-fix1.patch
+cdaudio_leakfix.patch
+cfq2-17092004.patch


Removed:
-cool-spinlocks-i386.diff
This has gone into mainline in a newer form so there is no point 
maintaining the older one.

-supermount-ng205.diff
I'm still maintaining this separately and it can be found in the split 
patches if you still wish to use it.

-fbsplash-0.9-r5-2.6.8-rc3.patch
Feature removed

-make-tree_lock-an-rwlock.patch
-invalidate_inodes-speedup.patch
Patches that were added for reiser4 merging

-2.6.8.1-mm2-reiser4.diff
-change_reiser4_config.diff
Feature removed

-vesafb-tng-0.9-rc4-r2-2.6.8.1.patch
-vesafb_change_config.diff
Feature removed. These were causing problems with swsusp.


Full patchlist:
from_2.6.8.1_to_staircase8.3
schedrange.diff
schedbatch2.4.diff
schediso2.6.diff
sched-adjust-p4gain
mapped_watermark4.diff
defaultcfq.diff
1g_lowmem1_i386.diff
akpm-latency-fix1.patch
9000-SuSE-117-writeback-lat.patch
cddvd-cmdfilter-drop.patch
cdaudio_leakfix.patch
ioport-latency-fix-2.6.8.1.patch
write-barriers.patch
cfq2-17092004.patch
cbq-fixes.diff
version-2.6.8.1-ck8.diff


Cheers,
Con
