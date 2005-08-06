Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263457AbVHFTnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbVHFTnU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 15:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbVHFTnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 15:43:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5004 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263457AbVHFTnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 15:43:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 voyager: Add machine_shutdown
References: <1123197649.5026.81.camel@mulgrave>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 06 Aug 2005 13:42:45 -0600
In-Reply-To: <1123197649.5026.81.camel@mulgrave> (James Bottomley's message
 of "Thu, 04 Aug 2005 18:20:49 -0500")
Message-ID: <m1u0i2yhqi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is one more bit of breakage my x86 sub-architecture
confusion caused.

Add machine_shutdown to voyager so it will compile with CONFIG_KEXEC.
---

 arch/i386/mach-voyager/voyager_basic.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

9c3d47fbd4a3c909f98de100e05f53301833128e
diff --git a/arch/i386/mach-voyager/voyager_basic.c b/arch/i386/mach-voyager/voyager_basic.c
--- a/arch/i386/mach-voyager/voyager_basic.c
+++ b/arch/i386/mach-voyager/voyager_basic.c
@@ -252,6 +252,12 @@ kb_wait(void)
 }
 
 void
+machine_shutdown(void)
+{
+	/* Architecture specific shutdown needed before a kexec */
+}
+
+void
 machine_restart(char *cmd)
 {
 	printk("Voyager Warm Restart\n");
