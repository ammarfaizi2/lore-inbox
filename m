Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWCVJ4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWCVJ4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWCVJ4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:56:22 -0500
Received: from mrelay2.soas.ac.uk ([212.219.139.201]:61849 "EHLO
	mrelay2.soas.ac.uk") by vger.kernel.org with ESMTP id S1751175AbWCVJ4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:56:21 -0500
Date: Wed, 22 Mar 2006 09:56:23 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
Cc: venkatesh.pallipadi@intel.com, linux@dominikbrodowski.de, akpm@osdl.org
Subject: [patch 2/4 MKII] cpufreq_conservative: alter default responsiveness
Message-ID: <20060322095623.GB3378@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The sensible approach to making conservative less responsive than ondemand :) 
As mentioned in patch [1/4].  We do not want conservative to shoot through 
all the frequencies, its point (by default) is to slowly move through them.

By default its ten times less responsive.

Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>





--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="02_cpufreq-samplingrate.diff"

--- linux-2.6.16/drivers/cpufreq/cpufreq_conservative.c.orig	2006-03-21 21:26:18.631603500 +0000
+++ linux-2.6.16/drivers/cpufreq/cpufreq_conservative.c	2006-03-21 21:27:58.333834500 +0000
@@ -509,7 +509,7 @@
 			if (latency == 0)
 				latency = 1;
 
-			def_sampling_rate = latency *
+			def_sampling_rate = 10 * latency *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 
 			if (def_sampling_rate < MIN_STAT_SAMPLING_RATE)

--rJwd6BRFiFCcLxzm--
