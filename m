Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVF0A5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVF0A5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 20:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVF0A5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 20:57:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12173 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261691AbVF0A4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 20:56:48 -0400
Date: Sun, 26 Jun 2005 17:56:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm2
Message-Id: <20050626175618.3e0c24cb.akpm@osdl.org>
In-Reply-To: <1119833085l.10734l.0l@werewolf.able.es>
References: <20050626040329.3849cf68.akpm@osdl.org>
	<1119833085l.10734l.0l@werewolf.able.es>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> This is missing. Is it critical ?
> 
>  --- 2.6.12/mm/memory.c	2005-06-17 20:48:29.000000000 +0100
>  +++ linux/mm/memory.c	2005-06-21 20:31:42.000000000 +0100
>  @@ -1051,7 +1051,7 @@ int remap_pfn_range(struct vm_area_struc
>   {
>   	pgd_t *pgd;
>   	unsigned long next;
>  -	unsigned long end = addr + size;
>  +	unsigned long end = addr + PAGE_ALIGN(size);
>   	struct mm_struct *mm = vma->vm_mm;
>   	int err;

That's already in Linus's tree.
