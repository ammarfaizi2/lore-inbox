Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWDBX4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWDBX4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 19:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWDBX4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 19:56:16 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:21171 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751025AbWDBX4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 19:56:16 -0400
Date: Mon, 3 Apr 2006 08:53:25 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu, linux-kernel@vger.kernel.org
Subject: Re: include/asm-arm/memory.h changes break zaurus sl-5500 boot
Message-Id: <20060403085325.dd7c90f6.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060402222314.GC12166@elf.ucw.cz>
References: <20060402210003.GA11979@elf.ucw.cz>
	<20060402220807.GD13901@flint.arm.linux.org.uk>
	<20060402222314.GC12166@elf.ucw.cz>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2006 00:23:14 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> On Ne 02-04-06 23:08:07, Russell King wrote:
> > On Sun, Apr 02, 2006 at 11:00:03PM +0200, Pavel Machek wrote:
> > > This reverts this (and one more) patch, and fixes boot on
> > > collie. Without this patch, I get some fairly strange warnings about
> > > shift bigger than page size in pfn_to_page().
> > 
> > Not surprising given this gem:
> > 
> > > -#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR((pfn) << PAGE_OFFSET))
> > 
> > PAGE_OFFSET being 3GB - that's one hell of a shift value!
> 
stupid...PAGE_OFFSET is offset.. not shift.

LOCAL_MAP_NR((pfn) << PAGE_SHIFT)  ?? what does file include this ?
I'll look into.

- Kame

