Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUG0J0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUG0J0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 05:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUG0J0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 05:26:21 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:61946 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261232AbUG0J0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 05:26:07 -0400
Date: Tue, 27 Jul 2004 05:29:34 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] Recommend 'noapic' when timer via IOAPIC fails
Message-ID: <Pine.LNX.4.58.0407270427500.23985@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We might as well recommend the user boot with the noapic kernel parameter
instead of filling poor Ingo's mailbox.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.8-rc2/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.6.8-rc2/arch/i386/kernel/io_apic.c	20 Jul 2004 18:14:54 -0000	1.1.1.1
+++ linux-2.6.8-rc2/arch/i386/kernel/io_apic.c	27 Jul 2004 07:23:38 -0000
@@ -2212,7 +2212,7 @@ static inline void check_timer(void)
 		return;
 	}
 	printk(" failed :(.\n");
-	panic("IO-APIC + timer doesn't work! pester mingo@redhat.com");
+	panic("IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter\n");
 }

 /*
Index: linux-2.6.8-rc2/arch/x86_64/kernel/io_apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2/arch/x86_64/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.6.8-rc2/arch/x86_64/kernel/io_apic.c	20 Jul 2004 18:15:04 -0000	1.1.1.1
+++ linux-2.6.8-rc2/arch/x86_64/kernel/io_apic.c	27 Jul 2004 07:23:55 -0000
@@ -1747,7 +1747,7 @@ static inline void check_timer(void)
 		return;
 	}
 	printk(" failed :(.\n");
-	panic("IO-APIC + timer doesn't work! pester mingo@redhat.com");
+	panic("IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter\n");
 }

 /*
