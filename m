Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVCRIml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVCRIml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 03:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVCRIml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 03:42:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:5771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261494AbVCRImj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 03:42:39 -0500
Date: Fri, 18 Mar 2005 00:42:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yichen Xie <yxie@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Potential DOS in load_elf_library?
Message-Id: <20050318004224.2f32fb24.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.60.0503180008140.25717@localhost.localdomain>
References: <Pine.LNX.4.60.0503180008140.25717@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yichen Xie <yxie@cs.stanford.edu> wrote:
>
> Hi guys, I was looking at the load_elf_library function (fs/binfmt_elf.c) 
>  in 2.6.10, and noticed the following:
> 
>   	elf_phdata = (struct elf_phdr *) kmalloc(j, GFP_KERNEL);
>   	...
>   	while (elf_phdata->p_type != PT_LOAD) elf_phdata++;
>   	...
>   	kfree(elf_phdata);
> 
>  Could this be problematic since the pointer being freed might be different 
>  from that returned from kmalloc?

Current kernels seem to be OK.
