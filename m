Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264160AbUFFVUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264160AbUFFVUv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 17:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbUFFVUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 17:20:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:60391 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264160AbUFFVUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 17:20:50 -0400
Date: Sun, 6 Jun 2004 14:20:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (urgent) ppc32: Fix CPUs with soft loaded TLB
In-Reply-To: <1086556255.1859.14.camel@gaston>
Message-ID: <Pine.LNX.4.58.0406061418450.1730@ppc970.osdl.org>
References: <1086556255.1859.14.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jun 2004, Benjamin Herrenschmidt wrote:
> 
> The recent introduction of ptep_set_access_flags() with the optimisation
> of not flushing the TLB unfortunately broke ppc32 CPUs with no hash table.

Makes sense, applied.

However, wouldn't it make sense to have this on the ppc64 branch too?

Admittedly on ppc64, the flush_tlb_page_nohash() function would be a
no-op, since it always has the hash tables, but I'm a blue-eyed optimists,
and I'm still hoping that some day IBM will see the error of their ways, 
and get rid of the hash tables entirely. At which point ppc64 too will 
need to flush the TLB entry.

		Linus
