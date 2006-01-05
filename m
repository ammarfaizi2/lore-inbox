Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWAEAO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWAEAO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWAEAO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:14:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53210 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750822AbWAEAO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:14:58 -0500
Date: Wed, 4 Jan 2006 16:16:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: mm/rmap.c negative page map count BUG.
Message-Id: <20060104161640.08a53c3f.akpm@osdl.org>
In-Reply-To: <20060104235631.GB29634@redhat.com>
References: <20060103082609.GB11738@redhat.com>
	<43BA630F.1020805@yahoo.com.au>
	<20060103135312.GB18060@redhat.com>
	<20060104155326.351a9c01.akpm@osdl.org>
	<20060104235631.GB29634@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> +			printk (KERN_EMERG "Eeek! page_mapcount(page) went negative! (%d)\n", page->_mapcount);

page_mapcount(page);

> +			printk (KERN_EMERG "  page->flags = %x\n", page->flags);

%lx

> +			printk (KERN_EMERG "  page->count = %x\n", page->_count);

page_count(page);


