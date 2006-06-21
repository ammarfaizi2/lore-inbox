Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWFUFbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWFUFbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 01:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWFUFbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 01:31:38 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:59345 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751096AbWFUFbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 01:31:37 -0400
Message-ID: <4498DA08.1010309@oracle.com>
Date: Tue, 20 Jun 2006 22:32:56 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: davej@codemonkey.org.uk, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: [Ubuntu PATCH] cpufreq: fix powernow-k8 load bug
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix powernow-k8 doesn't load bug.
Reference: https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/35145

http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=dce0ca36f2ae348f005735e9acd400d2c0954421



---
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-pv.orig/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
+++ linux-2617-pv/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
@@ -1008,7 +1008,7 @@ static int __cpuinit powernowk8_cpu_init
 		 * an UP version, and is deprecated by AMD.
 		 */
 
-		if ((num_online_cpus() != 1) || (num_possible_cpus() != 1)) {
+		if ((num_online_cpus() != 1)) {
 			printk(KERN_ERR PFX "MP systems not supported by PSB BIOS structure\n");
 			kfree(data);
 			return -ENODEV;



