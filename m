Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbUKKLIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbUKKLIr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUKKLIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:08:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:12173 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262204AbUKKLIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:08:45 -0500
Date: Thu, 11 Nov 2004 03:08:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5
Message-Id: <20041111030837.12a2090b.akpm@osdl.org>
In-Reply-To: <20041111012333.1b529478.akpm@osdl.org>
References: <20041111012333.1b529478.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/

Needs a fixup for CONFIG_HIGHMEM

--- linux-bix/include/asm/highmem.h~a	2004-11-11 03:07:37.105728944 -0800
+++ linux-bix-akpm/include/asm/highmem.h	2004-11-11 03:07:49.511842928 -0800
@@ -62,7 +62,7 @@ void kunmap(struct page *page);
 char *kmap_atomic(struct page *page, enum km_type type);
 void kunmap_atomic(char *kvaddr, enum km_type type);
 char *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
-struct page *kmap_atomic_to_page(void *ptr);
+struct page *kmap_atomic_to_page(char *ptr);
 
 #define flush_cache_kmaps()	do { } while (0)
 
_

