Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUHQGj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUHQGj7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 02:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUHQGj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 02:39:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:50836 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263714AbUHQGj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 02:39:57 -0400
Date: Mon, 16 Aug 2004 23:38:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: sam@ravnborg.org, nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-Id: <20040816233816.262b5666.akpm@osdl.org>
In-Reply-To: <141950000.1092723938@[10.10.2.4]>
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
	<121120000.1092699569@flay>
	<1092706344.3081.4.camel@booger>
	<20040817065901.GB7173@mars.ravnborg.org>
	<141950000.1092723938@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> Well ... that worked - thanks. But NUMA is still FITH.
> 
> 
>  arch/i386/mm/discontig.c: In function `zone_sizes_init':
>  arch/i386/mm/discontig.c:422: warning: passing arg 3 of `free_area_init_node' from incompatible pointer type
>  arch/i386/mm/discontig.c:422: warning: passing arg 4 of `free_area_init_node' makes pointer from integer without a cast
>  arch/i386/mm/discontig.c:422: warning: passing arg 5 of `free_area_init_node' makes integer from pointer without a cast
>  arch/i386/mm/discontig.c:422: too few arguments to function `free_area_init_node'
>  arch/i386/mm/discontig.c:430: warning: passing arg 3 of `free_area_init_node' from incompatible pointer type
>  arch/i386/mm/discontig.c:430: warning: passing arg 4 of `free_area_init_node' makes pointer from integer without a cast
>  arch/i386/mm/discontig.c:430: warning: passing arg 5 of `free_area_init_node' makes integer from pointer without a cast
>  arch/i386/mm/discontig.c:430: too few arguments to function `free_area_init_node'
>  make[1]: *** [arch/i386/mm/discontig.o] Error 1

Oh crap - I seem to have misread a backout patch from Dave as a fix, so
most-but-not-all of that damn patch is reverted.  If you back out
dont-pass-mem_map-into-init-functions-even-more-fixes.patch it should work
OK.

I'll drop the whole thing.
