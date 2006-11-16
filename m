Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162260AbWKPCrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162260AbWKPCrN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162253AbWKPCrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:47:12 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:23952 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162243AbWKPCq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:46:58 -0500
Message-Id: <20061116024809.629931000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:54 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: [patch 22/30] CPUFREQ: Make acpi-cpufreq unsticky again.
Content-Disposition: inline; filename=cpufreq-make-acpi-cpufreq-unsticky-again.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Dave Jones <davej@redhat.com>

This caused suspend/resume regressions.

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.18.2.orig/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ linux-2.6.18.2/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -560,7 +560,6 @@ static struct cpufreq_driver acpi_cpufre
 	.name	= "acpi-cpufreq",
 	.owner	= THIS_MODULE,
 	.attr	= acpi_cpufreq_attr,
-	.flags	= CPUFREQ_STICKY,
 };
 
 
@@ -571,7 +570,7 @@ acpi_cpufreq_init (void)
 
 	acpi_cpufreq_early_init_acpi();
 
- 	return cpufreq_register_driver(&acpi_cpufreq_driver);
+	return cpufreq_register_driver(&acpi_cpufreq_driver);
 }
 
 

--
