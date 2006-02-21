Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161394AbWBUGVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161394AbWBUGVH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161395AbWBUGVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:21:06 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:61404 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161394AbWBUGVF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:21:05 -0500
Date: Mon, 20 Feb 2006 23:21:03 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
Subject: [-mm PATCHSET 0/11] Sync -mm w/ B19 timekeeping patches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
	The following patch set syncs my current B19 timekeeping work up with 
the patches currently in -mm.

I'm normally a git person, but I finally sat down and started to learn quilt 
for this (I know, its about time. I do like how fast quilt is!), so let me know if I went overboard with the many-tiny-patches thing.

Its fine by me if all of these small changes are folded into their parent
patch, but I'll leave it up to you to decide on that.

I've only sent the patches that were modified or added, but the full changelog can be seen below.

The full quilt patch tarball against 2.6.16-rc4 can be found:
	http://sr71.net/~jstultz/tod/for-mm/

thanks
-john

Key: 
= No changes 
~ Trivial merge
! Modified
+ Added
- Dropped

=time-reduced-ntp-rework-part-1.patch
-time-reduced-ntp-rework-part-1-update.patch
+time-reduced-ntp-rework-part-1-fix-adjtimeadj.patch
   Syncs up the time-reduced-ntp-rework-part1.patch with the 
   adjtime_adjustment() changes.


!time-reduced-ntp-rework-part-2.patch
+time-reduced-ntp-rework-part-2-fix-adjtimeadj.patch
   Syncs up the time-reduced-ntp-rework-part1.patch with the 
   adjtime_adjustment() changes.

=time-clocksource-infrastructure.patch
+time-clocksource-infrastructure-remove-nsect.patch
   Removes nsec_t
   
~time-generic-timekeeping-infrastructure.patch
+time-generic-timekeeping-infrastructure-remove-nsect.patch
   Removes nsec_t
+time-generic-timekeeping-infrastructure-fix-ntp-synced.patch
   Fixes potential bug where hwclock is not synced
+time-generic-timekeeping-infrastructure-set-wall-offset-helper.patch
   Use helper function to cleanup code

~time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
~time-i386-conversion-part-2-rework-tsc-support.patch
=time-i386-conversion-part-2-rework-tsc-support-section-fix.patch

=time-i386-conversion-part-3-enable-generic-timekeeping.patch
+time-i386-conversion-part-3-enable-generic-timekeeping-remove-nsect.patch
   Removes nsec_t
+time-i386-conversion-part-3-enable-generic-timekeeping-backout-pmtmr-changes.patch
   Backs out pmtmr changes that collided with x86-64

=time-i386-conversion-part-4-remove-old-timer_opts-code.patch
+time-i386-conversion-part-4-remove-old-timer_opts-code-del-timer-tsc.patch
   Removes the timer_tsc.c file (somehow this got dropped?)

-time-i386-conversion-part-5-acpi-pm-variable-renaming-and-config-change.patch
-time-i386-conversion-part-5-acpi-pm-variable-renaming-and-config-change-x86_64-fix.patch
  Unnecessary now that pmtmr changes are backed out


=time-i386-clocksource-drivers.patch
+time-i386-clocksource-drivers-backout-pmtmr-changes.patch
   Backs out pmtmr changes that collided with x86-64

=time-fix-cpu-frequency-detection.patch
=time-delay-clocksource-selection-until-later-in-boot.patch
=x86-blacklist-tsc-from-systems-where-it-is-known-to-be-bad.patch
=i386-dont-disable-the-tsc-on-single-node-numaqs.patch
