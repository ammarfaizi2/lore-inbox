Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755225AbWKMQ5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbWKMQ5g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755213AbWKMQyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:54:13 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:47080 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755211AbWKMQyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:54:04 -0500
Date: Mon, 13 Nov 2006 11:33:05 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com
Subject: [RFC] [PATCH 5/16] x86_64: Fix earlyprintk to use standard ISA mapping
Message-ID: <20061113163305.GF17429@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113162135.GA17429@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/early_printk.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -puN arch/x86_64/kernel/early_printk.c~x86_64-fix-early_printk-to-use-the-standard-ISA-mapping arch/x86_64/kernel/early_printk.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/early_printk.c~x86_64-fix-early_printk-to-use-the-standard-ISA-mapping	2006-11-09 22:57:41.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/early_printk.c	2006-11-09 22:57:41.000000000 -0500
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
