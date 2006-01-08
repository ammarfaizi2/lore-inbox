Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbWAHAhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWAHAhU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 19:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbWAHAhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 19:37:20 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:26373 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161098AbWAHAhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 19:37:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ddEKOIs74A+G0k9pCnh7qWIhCNSS/5Og43Tzu08WuLXU+IzJPX4ZHslkolc3XIy2TJFzvsv8zs7TeJNVTY+Jm73/cIMEEUa7j1emLj4COfTo43nG7vDAj9vbadplX5L65uG3r8gpt82YjYgF7XU3G981m91W3O4TZo6zxU9zCLA=
Date: Sun, 8 Jan 2006 03:54:13 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] Fixup arch/alpha/mm/init.c compilation
Message-ID: <20060108005413.GB21553@mipter.zuzino.mipt.ru>
References: <20060107052221.61d0b600.akpm@osdl.org> <20060107210646.GA26124@mipter.zuzino.mipt.ru> <20060107154842.5832af75.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107154842.5832af75.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      arch/alpha/mm/init.o
In file included from include/asm/tlb.h:10,
                 from arch/alpha/mm/init.c:32:
include/asm-generic/tlb.h: In function `tlb_flush_mmu':
include/asm-generic/tlb.h:77: warning: implicit declaration of function `release_pages'
include/asm-generic/tlb.h: In function `tlb_remove_page':
include/asm-generic/tlb.h:106: warning: implicit declaration of function `page_cache_release'

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/alpha/mm/init.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -7,6 +7,7 @@
 /* 2.3.x zone allocator, 1999 Andrea Arcangeli <andrea@suse.de> */
 
 #include <linux/config.h>
+#include <linux/pagemap.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>

