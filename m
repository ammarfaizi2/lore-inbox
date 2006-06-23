Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932993AbWFWKM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932993AbWFWKM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbWFWKM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:12:27 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:29456 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932993AbWFWKM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:12:26 -0400
Date: Fri, 23 Jun 2006 12:12:30 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix cpufreq_{conservative,ondemand} compilation
Message-Id: <20060623121230.63e1237a.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix cpufreq_conservative and cpufreq_ondemand, which were using
{lock,unlock}_cpu_hotplug without including linux/cpu.h which defines
them.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/cpufreq/cpufreq_conservative.c |    1 +
 drivers/cpufreq/cpufreq_ondemand.c     |    1 +
 2 files changed, 2 insertions(+)

--- linux-2.6.17-git.orig/drivers/cpufreq/cpufreq_conservative.c	2006-06-23 10:24:17.000000000 +0200
+++ linux-2.6.17-git/drivers/cpufreq/cpufreq_conservative.c	2006-06-23 12:07:42.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ctype.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/sysctl.h>
 #include <linux/types.h>
--- linux-2.6.17-git.orig/drivers/cpufreq/cpufreq_ondemand.c	2006-06-23 10:24:17.000000000 +0200
+++ linux-2.6.17-git/drivers/cpufreq/cpufreq_ondemand.c	2006-06-23 12:07:34.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ctype.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/sysctl.h>
 #include <linux/types.h>


-- 
Jean Delvare
