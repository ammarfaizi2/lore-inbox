Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265020AbUE1XXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265020AbUE1XXf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 19:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265095AbUE1XXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 19:23:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:46016 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265020AbUE1XXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 19:23:30 -0400
Date: Fri, 28 May 2004 16:25:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, dcn@sgi.com
Subject: Re: [RFC, PATCH] set SLAB_HWCACHE_ALIGN for kmalloc caches
Message-Id: <20040528162545.13fa2be8.akpm@osdl.org>
In-Reply-To: <40B7A562.8040104@colorfullife.com>
References: <40B7A562.8040104@colorfullife.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> I think the kmalloc caches should remain cache line aligned

I'm not so sure.  size-64 is used a lot for out-of-line dentry names.
Taking these up to 128 bytes or even more will consume considerable
memory in some situations.
