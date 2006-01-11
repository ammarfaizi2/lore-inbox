Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWAKQk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWAKQk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 11:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWAKQkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 11:40:55 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:5024 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751576AbWAKQkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 11:40:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=lFvyo99VJChPR7wDwASTWYd236Xq7i37hIWe0CR0cSMZaPFvtlYVtkL9T8Ox69Ky5F+NR4FrIStKMRMB12jnug6PInSaw3T4XuZ/LseRA5bLW8wwOdj7xscbQWnpAK2a6uN0/NMYBO0vnFulyb+5bJkvuPSiqaqMK5R5XMuwGpU=
Date: Wed, 11 Jan 2006 19:57:58 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Subject: [PATCH -mm] mm/rmap.c: don't forget to include module.h
Message-ID: <20060111165758.GH8686@mipter.zuzino.mipt.ru>
References: <20060111042135.24faf878.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111042135.24faf878.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      mm/rmap.o
mm/rmap.c:235: warning: type defaults to `int' in declaration of `EXPORT_SYMBOL'
mm/rmap.c:235: warning: parameter names (without types) in function declaration
mm/rmap.c:235: warning: data definition has no type or storage class

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 mm/rmap.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.15-mm3/mm/rmap.c	2006-01-11 19:42:39.000000000 +0300
+++ linux-2.6.15-mm3-rmap/mm/rmap.c	2006-01-11 19:48:12.000000000 +0300
@@ -52,6 +52,9 @@
 #include <linux/init.h>
 #include <linux/rmap.h>
 #include <linux/rcupdate.h>
+#ifdef CONFIG_MIGRATION
+#include <linux/module.h>
+#endif
 
 #include <asm/tlbflush.h>
 

