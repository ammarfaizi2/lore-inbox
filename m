Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318288AbSHKLXb>; Sun, 11 Aug 2002 07:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318289AbSHKLXb>; Sun, 11 Aug 2002 07:23:31 -0400
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:64419 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S318288AbSHKLXa>; Sun, 11 Aug 2002 07:23:30 -0400
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [patch 11/21] disable interrupts while holding pagemap_lru_lock
To: linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Sun, 11 Aug 2002 07:26:52 -0400
References: <3D5614A6.22F832F1@zip.com.au>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20020811112653.33A787A3C@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> This optimisation is not needed on uniprocessor, but the patch disables
> IRQs while holding pagemap_lru_lock anyway, so it becomes an irq-safe
> spinlock, and pages can be moved from the LRU in interrupt context.

It does cleanup slablru in UP.  It simplifies the patch getting rid of the 
#ifdef when adding page(s) to the slab caches.  It also cleans up the code 
used when we want to remove a slab from a cache.

Thanks
Ed Tomlinson

