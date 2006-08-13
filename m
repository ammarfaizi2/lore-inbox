Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWHMVAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWHMVAL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWHMVAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:00:10 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1038 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751439AbWHMVAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:00:09 -0400
Date: Sun, 13 Aug 2006 23:00:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
       davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: [-mm patch] make drivers/cpufreq/cpufreq_ondemand.c:powersave_bias_target() static
Message-ID: <20060813210007.GJ3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc3-mm2:
>...
>  git-cpufreq.patch
>...
>  git trees
>...

This patch makes the needlessly global powersave_bias_target() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm1/drivers/cpufreq/cpufreq_ondemand.c.old	2006-08-13 17:40:48.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/cpufreq/cpufreq_ondemand.c	2006-08-13 17:40:59.000000000 +0200
@@ -105,8 +105,9 @@
  * Returns the freq_hi to be used right now and will set freq_hi_jiffies,
  * freq_lo, and freq_lo_jiffies in percpu area for averaging freqs.
  */
-unsigned int powersave_bias_target(struct cpufreq_policy *policy,
-		unsigned int freq_next, unsigned int relation)
+static unsigned int powersave_bias_target(struct cpufreq_policy *policy,
+					  unsigned int freq_next,
+					  unsigned int relation)
 {
 	unsigned int freq_req, freq_reduc, freq_avg;
 	unsigned int freq_hi, freq_lo;

