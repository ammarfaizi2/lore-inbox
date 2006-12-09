Return-Path: <linux-kernel-owner+w=401wt.eu-S1759292AbWLICkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759292AbWLICkb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 21:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759616AbWLICkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 21:40:31 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:33740 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759292AbWLICka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 21:40:30 -0500
Date: Sat, 9 Dec 2006 11:43:33 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [1/4]  map and
 unmap
Message-Id: <20061209114333.355c62e9.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061208162819.f809d703.akpm@osdl.org>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208160142.d40cf636.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208162819.f809d703.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 16:28:19 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Generally we prefer to simply *require* that the function vector be filled
> in appropriately.  So if the caller has no special needs, the caller will
> set their gen_map_kern_ops.k_pte_alloc to point at pte_alloc_kernel().
> 
> erk, pte_alloc_kernel() is a macro.  As is pmd_alloc(), etc.  Well, let
> that be a lesson to us.  What a mess.
> 
> I suppose we could go through and convert them all to inlines and then the
> compiler will generate an out-of-line copy for us.  Better would be to turn
> these things into regular, out-of-line C functions.
> 
> What a mess.
> 

Thank you for review. I'll remove this default action.

-Kame

