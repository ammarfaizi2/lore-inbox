Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267783AbUIXD7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267783AbUIXD7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUIXD4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:56:08 -0400
Received: from fujitsu2.fujitsu.com ([192.240.0.2]:14522 "EHLO
	fujitsu2.fujitsu.com") by vger.kernel.org with ESMTP
	id S267796AbUIXDwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 23:52:23 -0400
Date: Thu, 23 Sep 2004 20:51:58 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [Patch/RFC]Removing zone and node ID from page->flags[0/3]
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
In-Reply-To: <20040923232713.GJ9106@holomorphy.com>
References: <20040923135108.D8CC.YGOTO@us.fujitsu.com> <20040923232713.GJ9106@holomorphy.com>
Message-Id: <20040923203516.0207.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.11.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for comment.

> Looks relatively innocuous. I wonder if cosmetically we may want
> s/struct zone_tbl/struct zone_table/

Do you mean "struct zone_table" is better as its name?
If so, I'll change it.

> I like the path compression in the 2-level radix tree.

Hmmmm.....
Current radix tree code uses slab allocator.
But, zone_table must be initialized before free_all_bootmem()
and kmem_cache_alloc().
So, if I use it for zone_table, I think I have to change radix tree
code to use bootmem or have to write other original code.
I'm not sure it is better way....

Bye.

-- 
Yasunori Goto <ygoto at us.fujitsu.com>


