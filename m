Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268807AbTBZQhP>; Wed, 26 Feb 2003 11:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268809AbTBZQhP>; Wed, 26 Feb 2003 11:37:15 -0500
Received: from proxy.povodiodry.cz ([62.77.115.11]:18048 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S268807AbTBZQhO>;
	Wed, 26 Feb 2003 11:37:14 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Wed, 26 Feb 2003 17:47:29 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix typo in arch/i386/kernel/mpparse.c in printk
Message-ID: <20030226164729.GA10521@pc11.op.pod.cz>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

  Please apply this obvious fix of printk level (wrong since 2.5.62).

	Regards,
		Vita Samel


--- clean-2.5.63/arch/i386/kernel/mpparse.c.orig	Tue Feb 25 18:04:35 2003
+++ clean-2.5.63/arch/i386/kernel/mpparse.c	Wed Feb 26 17:34:40 2003
@@ -631,7 +631,7 @@
 	else if (acpi_lapic)
 		printk(KERN_INFO "Using ACPI for processor (LAPIC) configuration information\n");
 
-	printk("KERN_INFO Intel MultiProcessor Specification v1.%d\n", mpf->mpf_specification);
+	printk(KERN_INFO "Intel MultiProcessor Specification v1.%d\n", mpf->mpf_specification);
 	if (mpf->mpf_feature2 & (1<<7)) {
 		printk(KERN_INFO "    IMCR and PIC compatibility mode.\n");
 		pic_mode = 1;
