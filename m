Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVIGJjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVIGJjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 05:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVIGJjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 05:39:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23235 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932088AbVIGJjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 05:39:14 -0400
Date: Wed, 7 Sep 2005 02:37:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, haveblue@us.ibm.com
Subject: Re: [PATCH 01/11] memory hotplug prep: kill local_mapnr
Message-Id: <20050907023728.732a5a9f.akpm@osdl.org>
In-Reply-To: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
References: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
>  --- memhotplug/include/asm-x86_64/mmzone.h~C0-kill-local_mapnr	2005-08-18 14:59:43.000000000 -0700
>  +++ memhotplug-dave/include/asm-x86_64/mmzone.h	2005-08-18 14:59:43.000000000 -0700
>  @@ -38,8 +38,6 @@ static inline __attribute__((pure)) int 
>   
>   #ifdef CONFIG_DISCONTIGMEM
>   
>  -#define pfn_to_nid(pfn) phys_to_nid((unsigned long)(pfn) << PAGE_SHIFT)
>  -#define kvaddr_to_nid(kaddr)	phys_to_nid(__pa(kaddr))
>   
>   /* AK: this currently doesn't deal with invalid addresses. We'll see 
>      if the 2.5 kernel doesn't pass them
>  _

What's this bit doing here?   It breaks the x86_64 build all over the place.

I'll drop that chunk and see how we go...
