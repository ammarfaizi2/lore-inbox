Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbVJESb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbVJESb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 14:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbVJESb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 14:31:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18924 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030308AbVJESb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 14:31:57 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
Subject: [PATCH] i386 apic: Fix  mispelling of APIC
References: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61L.0510041628160.10696@blysk.ds.pg.gda.pl>
	<m1psql707i.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61L.0510041811590.10696@blysk.ds.pg.gda.pl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 05 Oct 2005 12:30:20 -0600
In-Reply-To: <Pine.LNX.4.61L.0510041811590.10696@blysk.ds.pg.gda.pl> (Maciej
 W. Rozycki's message of "Tue, 4 Oct 2005 18:16:36 +0100 (BST)")
Message-ID: <m1ek6z7r5v.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" <macro@linux-mips.org> writes:


>> So what should the capitalization be? "APIC disabled\n" ?
>
>  Obviously.  Thanks for your tidy-up!

Welcome.

Looking a little deeper I just copied the mispelling from x86_64.
Here is the incremental patch that fixes the i386 version.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 arch/i386/kernel/apic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

7edc564590555e94268fb73ddf97431b4b9df945
diff --git a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c
+++ b/arch/i386/kernel/apic.c
@@ -1265,7 +1265,7 @@ fastcall void smp_error_interrupt(struct
 int __init APIC_init(void)
 {
 	if (enable_local_apic < 0) {
-		printk(KERN_INFO "Apic disabled\n");
+		printk(KERN_INFO "APIC disabled\n");
 		return -1;
 	}
 	

