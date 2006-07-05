Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWGEJXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWGEJXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWGEJXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:23:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21994 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932403AbWGEJXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:23:02 -0400
Date: Wed, 5 Jul 2006 05:22:54 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [CPUFREQ] Fix implicit declarations in ondemand.
Message-ID: <20060705092254.GA30744@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/cpufreq/cpufreq_ondemand.c: In function ‘dbs_check_cpu’:
drivers/cpufreq/cpufreq_ondemand.c:238: error: implicit declaration of function ‘jiffies64_to_cputime64’
drivers/cpufreq/cpufreq_ondemand.c:239: error: implicit declaration of function ‘cputime64_sub’

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/cpufreq/cpufreq_ondemand.c~	2006-07-05 05:19:26.000000000 -0400
+++ linux-2.6/drivers/cpufreq/cpufreq_ondemand.c	2006-07-05 05:20:01.000000000 -0400
@@ -18,6 +18,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel_stat.h>
 #include <linux/mutex.h>
+#include <asm/cputime.h>
 
 /*
  * dbs is used in this file as a shortform for demandbased switching

-- 
http://www.codemonkey.org.uk
