Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbTHZVwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 17:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTHZVwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 17:52:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:61857 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262939AbTHZVwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 17:52:22 -0400
Date: Tue, 26 Aug 2003 14:36:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4: blkdev_requests "memory before object was
 overwritten" and oops in __iget
Message-Id: <20030826143635.1c218d06.akpm@osdl.org>
In-Reply-To: <20030826183850.GA4781@linuxhacker.ru>
References: <20030826183850.GA4781@linuxhacker.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@linuxhacker.ru> wrote:
>
>    Found one of my test boxes freezed today (or may be even yesterday).
>    That's what was in logs:
> 
> Aug 25 00:50:37 dwarf kernel: [drm] DMA Cleanup
> Aug 25 21:46:31 dwarf kernel: mtrr: base(0xf8000000) is not aligned on a size(0x180000) boundary
> Aug 25 21:46:31 dwarf kernel: [drm] Using POST v1.2 init.
> Aug 25 21:46:31 dwarf kernel: PCI: Found IRQ 11 for device 0000:00:02.0
> Aug 25 21:46:39 dwarf kernel: slab error in cache_alloc_debugcheck_after(): cache `blkdev_requests': memory before object was overwritten

Setting CONFIG_DEBUG_PAGEALLOC might help us trap this.

