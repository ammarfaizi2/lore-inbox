Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbVLBJGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVLBJGG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 04:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbVLBJGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 04:06:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25246 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750933AbVLBJGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 04:06:04 -0500
Date: Fri, 2 Dec 2005 01:05:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       shai@scalex86.org
Subject: Re: [patch 3/3] x86_64: Node local PDA -- allocate node local
 memory for pda
Message-Id: <20051202010548.4da3d1bb.akpm@osdl.org>
In-Reply-To: <20051202082309.GC5312@localhost.localdomain>
References: <20051202081028.GA5312@localhost.localdomain>
	<20051202082309.GC5312@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> --- linux-2.6.15-rc3.orig/arch/x86_64/kernel/head64.c	2005-11-30 17:01:18.000000000 -0800
>  +++ linux-2.6.15-rc3/arch/x86_64/kernel/head64.c	2005-11-30 17:07:14.000000000 -0800
>  @@ -80,6 +80,7 @@
>   {
>   	char *s;
>   	int i;
>  +	extern struct x8664_pda boot_cpu_pda[];

And what happens if someone later changes the type of boot_cpu_pda?
