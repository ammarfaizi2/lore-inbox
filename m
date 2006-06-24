Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932736AbWFXAWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbWFXAWA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWFXAWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:22:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:8848 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932736AbWFXAV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:21:57 -0400
Date: Sat, 24 Jun 2006 02:21:56 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jbeulich@novell.com
Subject: [PATCH] [69/82] i386/x86-64: adjust /proc/interrupts column 
 headings
Message-ID: <449C85A4.mailDS211MACW@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Jan Beulich" <jbeulich@novell.com>

With (significantly) more than 10 CPUs online, the column headings
drifted off the positions of the column contents with growing CPU
numbers.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/irq.c   |    2 +-
 arch/x86_64/kernel/irq.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/i386/kernel/irq.c
===================================================================
--- linux.orig/arch/i386/kernel/irq.c
+++ linux/arch/i386/kernel/irq.c
@@ -219,7 +219,7 @@ int show_interrupts(struct seq_file *p, 
 	if (i == 0) {
 		seq_printf(p, "           ");
 		for_each_online_cpu(j)
-			seq_printf(p, "CPU%d       ",j);
+			seq_printf(p, "CPU%-8d",j);
 		seq_putc(p, '\n');
 	}
 
Index: linux/arch/x86_64/kernel/irq.c
===================================================================
--- linux.orig/arch/x86_64/kernel/irq.c
+++ linux/arch/x86_64/kernel/irq.c
@@ -39,7 +39,7 @@ int show_interrupts(struct seq_file *p, 
 	if (i == 0) {
 		seq_printf(p, "           ");
 		for_each_online_cpu(j)
-			seq_printf(p, "CPU%d       ",j);
+			seq_printf(p, "CPU%-8d",j);
 		seq_putc(p, '\n');
 	}
 
