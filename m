Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267476AbTBKLJ2>; Tue, 11 Feb 2003 06:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267622AbTBKLJZ>; Tue, 11 Feb 2003 06:09:25 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4868 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267476AbTBKKvI>;
	Tue, 11 Feb 2003 05:51:08 -0500
Date: Mon, 10 Feb 2003 17:38:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: nmi_int.c: do not use __u8 when there's no need
Message-ID: <20030210163835.GA1124@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Those "__"'s have no right to live, please apply,
								Pavel

--- clean/arch/i386/oprofile/nmi_int.c	2003-01-05 22:58:19.000000000 +0100
+++ linux-swsusp/arch/i386/oprofile/nmi_int.c	2003-02-10 17:09:55.000000000 +0100
@@ -217,9 +248,9 @@
  
 int __init nmi_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
 {
-	__u8 vendor = current_cpu_data.x86_vendor;
-	__u8 family = current_cpu_data.x86;
-	__u8 cpu_model = current_cpu_data.x86_model;
+	u8 vendor = current_cpu_data.x86_vendor;
+	u8 family = current_cpu_data.x86;
+	u8 cpu_model = current_cpu_data.x86_model;
  
 	if (!cpu_has_apic)
 		return 0;

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
