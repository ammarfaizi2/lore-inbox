Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263174AbTCYSdg>; Tue, 25 Mar 2003 13:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbTCYSdg>; Tue, 25 Mar 2003 13:33:36 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:13582 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263174AbTCYSdf>; Tue, 25 Mar 2003 13:33:35 -0500
Date: Tue, 25 Mar 2003 18:44:42 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK FBDEV] A few more updates.
In-Reply-To: <1048616901.10476.3.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0303251843121.4568-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You "fixed" it by using GFP_ATOMIC but didn't test the result of
> kmalloc. That is very bad. GFP_ATOMIC can fail (return NULL), thus
> you will crash the kernel under high memory pressure.
> 
> I think the proper fix is, as you asked me, using a workqueue,
> that way, you can both use GFP_KERNEL allocations, and avoid
> the spinlock you added to fbmem.c, thus letting the fb_sync()
> ops on fbdev's be able to block.

Ug! The quick fix was a bad idea. I will work on the workqueue idea 
instead. Ignore the pull. 



