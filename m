Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265907AbSKDGxO>; Mon, 4 Nov 2002 01:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265908AbSKDGxN>; Mon, 4 Nov 2002 01:53:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10208 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265907AbSKDGxN>;
	Mon, 4 Nov 2002 01:53:13 -0500
Date: Sun, 03 Nov 2002 22:49:30 -0800 (PST)
Message-Id: <20021103.224930.126609155.davem@redhat.com>
To: adam@yggdrasil.com
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Patch: linux-2.5.45/drivers/base/bus.c - new field to
 consolidate memory allocation in many drivers
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021103144022.A8273@adam.yggdrasil.com>
References: <20021103144022.A8273@adam.yggdrasil.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Sun, 3 Nov 2002 14:40:22 -0800
   
   	Dave M.: I am cc'ing this to because you asked for a
   bus-independent API for allocating DMA consistent memory when I
   discusssed consolidating some other driver DMA mapping operations
   about six months ago.

I don't know how much I like the DMA memory being allocated
transparently based upon some structure initialization values.

I'd rather the DMA alloc/free be explicit in the drivers.

Otherwise, the ->ops->alloc_consistent et al. abstraction
looks ok.
