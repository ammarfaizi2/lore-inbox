Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWGYE3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWGYE3T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 00:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWGYE3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 00:29:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932434AbWGYE3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 00:29:19 -0400
Date: Mon, 24 Jul 2006 21:29:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: torvalds@osdl.org, ebiederm@xmission.com, hpa@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add efi e820 memory mapping on x86 [try #1]
Message-Id: <20060724212911.32dd3bc0.akpm@osdl.org>
In-Reply-To: <44B9FF02.3020600@ed-soft.at>
References: <44A04F5F.8030405@ed-soft.at>
	<Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
	<44A0CCEA.7030309@ed-soft.at>
	<Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
	<44A304C1.2050304@zytor.com>
	<m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
	<44A8058D.3030905@zytor.com>
	<m11wt3983j.fsf@ebiederm.dsl.xmission.com>
	<44AB8878.7010203@ed-soft.at>
	<m1lkr83v73.fsf@ebiederm.dsl.xmission.com>
	<44B6BF2F.6030401@ed-soft.at>
	<Pine.LNX.4.64.0607131507220.5623@g5.osdl.org>
	<44B73791.9080601@ed-soft.at>
	<Pine.LNX.4.64.0607140901200.5623@g5.osdl.org>
	<44B9FF02.3020600@ed-soft.at>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul 2006 10:55:30 +0200
Edgar Hucek <hostmaster@ed-soft.at> wrote:

> This Patch add an efi e820 memory mapping.
> 

Why?

>  /*
> + * Make a e820 memory map
> + */
> +void __init efi_init_e820_map(void)
> +{
> +    efi_memory_desc_t *md;
> +    unsigned long long start = 0;
> +    unsigned long long end = 0;
> +    unsigned long long size = 0;

I guess these should have type resource_size_t, given that they ultimately
get remembered via request_resource().  But that has a good chance of
breaking something, so let's leave it alone.

> +            add_memory_region(md->phys_addr, md->num_pages <<
> EFI_PAGE_SHIFT, E820_ACPI);

The patch is wordwrapped and will not apply.
