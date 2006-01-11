Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbWAKXoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbWAKXoV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWAKXoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:44:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1938 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932637AbWAKXoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:44:20 -0500
Date: Wed, 11 Jan 2006 15:43:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
Message-Id: <20060111154358.24bad66a.akpm@osdl.org>
In-Reply-To: <05b3d1af27ebbbe6e436.1137019195@eng-12.pathscale.com>
References: <patchbomb.1137019194@eng-12.pathscale.com>
	<05b3d1af27ebbbe6e436.1137019195@eng-12.pathscale.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> wrote:
>
>   lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
>   	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
>   	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
>  -	 sha1.o
>  +	 sha1.o raw_memcpy_io.o

You'll find that if nothing in vmlinux references __raw_memcpy_toio32 then
this file won't be included in vmlinux and __raw_memcpy_toio32 won't be
available to modules.

I'll move this to obj-y, which does the right thing.
