Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbULEVcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbULEVcG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 16:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbULEVcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 16:32:05 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:15764 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261405AbULEVbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 16:31:08 -0500
Message-ID: <41B37E06.3030702@colorfullife.com>
Date: Sun, 05 Dec 2004 22:30:46 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mundt <paul.mundt@nokia.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCH_SLAB_MINALIGN for 2.6.10-rc3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

>--- orig/include/asm-sh64/uaccess.h
>+++ mod/include/asm-sh64/uaccess.h
>@@ -313,6 +313,12 @@
>    sh64 at the moment). */
> #define ARCH_KMALLOC_MINALIGN 8
> 
>+/*
>+ * We want 8-byte alignment for the slab caches as well, otherwise we have
>+ * the same BYTES_PER_WORD (sizeof(void *)) min align in kmem_cache_create().
>+ */
>+#define ARCH_SLAB_MINALIGN 8
>+
>  
>
Could you make that dependant on !CONFIG_DEBUG_SLAB? Setting align to a 
non-zero value disables some debug code.

The rest is fine with me.

--
    Manfred
