Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756073AbWKRAIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbWKRAIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756083AbWKRAHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:07:15 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:8084 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1756081AbWKRAGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:06:53 -0500
Date: Fri, 17 Nov 2006 17:40:38 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: [PATCH 5/20] x86_64: Fix early printk to use standard ISA mapping
Message-ID: <20061117224038.GF15449@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061117223432.GA15449@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117223432.GA15449@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/early_printk.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -puN arch/x86_64/kernel/early_printk.c~x86_64-fix-early_printk-to-use-the-standard-ISA-mapping arch/x86_64/kernel/early_printk.c
--- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/early_printk.c~x86_64-fix-early_printk-to-use-the-standard-ISA-mapping	2006-11-17 00:06:43.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/early_printk.c	2006-11-17 00:06:43.000000000 -0500
@@ -11,11 +11,10 @@
 
 #ifdef __i386__
 #include <asm/setup.h>
-#define VGABASE		(__ISA_IO_base + 0xb8000)
 #else
 #include <asm/bootsetup.h>
-#define VGABASE		((void __iomem *)0xffffffff800b8000UL)
 #endif
+#define VGABASE		(__ISA_IO_base + 0xb8000)
 
 static int max_ypos = 25, max_xpos = 80;
 static int current_ypos = 25, current_xpos = 0;
_
