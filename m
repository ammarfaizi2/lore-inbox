Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbUKUVT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbUKUVT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 16:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbUKUVRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 16:17:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:59554 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261810AbUKUVOx (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 16:14:53 -0500
Date: Sun, 21 Nov 2004 13:14:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Linux-Kernel@vger.kernel.org, AKPM@osdl.org, linux-mm@kvack.org
Subject: Re: [PATCH]: 3/4 mm/rmap.c cleanup
Message-Id: <20041121131437.4c3bcee0.akpm@osdl.org>
In-Reply-To: <16800.47063.386282.752478@gargle.gargle.HOWL>
References: <16800.47063.386282.752478@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <nikita@clusterfs.com> wrote:
>
> mm/rmap.c:page_referenced_one() and mm/rmap.c:try_to_unmap_one() contain
>  identical code that
> 
>   - takes mm->page_table_lock;
> 
>   - drills through page tables;
> 
>   - checks that correct pte is reached.
> 
>  Coalesce this into page_check_address()

Looks sane, but it comes at a bad time.  Please rework and resubmit after
the 4-level pagetable code is merged into Linus's tree, post-2.6.10.
