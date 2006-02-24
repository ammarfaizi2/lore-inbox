Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWBXO0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWBXO0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 09:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWBXO0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 09:26:17 -0500
Received: from mrelay2.soas.ac.uk ([212.219.139.201]:56785 "EHLO
	mrelay2.soas.ac.uk") by vger.kernel.org with ESMTP id S932174AbWBXO0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 09:26:16 -0500
Date: Fri, 24 Feb 2006 14:21:11 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: linux-kernel@vger.kernel.org
Cc: venkatesh.pallipadi@intel.com, jun.nakajima@intel.com,
       alex-kernel@digriz.org.uk, akpm@osdl.org
Subject: [patch 2/2] cpufreq_conservative: align codebase with ondemand for consistancy
Message-ID: <20060224142111.GB32266@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The sensible approach to making conservative less responsive :) As mentioned 
in patch [1/1].

Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="02_cpufreq-samplingrate.diff"

--- linux-2.6.15/drivers/cpufreq/cpufreq_conservative.c	2006-02-24 12:04:35.249778500 +0000
+++ linux-2.6.15/drivers/cpufreq/cpufreq_conservative.c.01	2006-02-09 20:40:04.837038750 +0000
@@ -512,7 +512,7 @@
 			if (latency == 0)
 				latency = 1;
 
-			def_sampling_rate = 10 * latency *
+			def_sampling_rate = latency *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 
 			if (def_sampling_rate < MIN_STAT_SAMPLING_RATE)

--uQr8t48UFsdbeI+V--
