Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUGICKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUGICKR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 22:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUGICKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 22:10:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:26025 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263024AbUGICJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 22:09:19 -0400
Date: Thu, 8 Jul 2004 19:08:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Shai Fultheim" <shai@scalex86.org>
Cc: linux-kernel@vger.kernel.org, mort@wildopensource.com,
       jes@wildopensource.com
Subject: Re: [PATCH] PER_CPU [3/4] - PER_CPU-init_tss
Message-Id: <20040708190810.7940ee97.akpm@osdl.org>
In-Reply-To: <200407090154.i691s3ws017104@fire-2.osdl.org>
References: <200407090154.i691s3ws017104@fire-2.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shai Fultheim" <shai@scalex86.org> wrote:
>
>  #define INIT_TSS  {							\
>   	.esp0		= sizeof(init_stack) + (long)&init_stack,	\
>   	.ss0		= __KERNEL_DS,					\
>  -	.esp1		= sizeof(init_tss[0]) + (long)&init_tss[0],	\
>   	.ss1		= __KERNEL_CS,					\
>   	.ldt		= GDT_ENTRY_LDT,				\
>   	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,			\

Why this change?  Is it safe?
