Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933615AbWKQOXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933615AbWKQOXo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933616AbWKQOXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:23:44 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:29717 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S933615AbWKQOXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:23:43 -0500
Subject: Re: Re : vm: weird behaviour when munmapping
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061117141230.70698.qmail@web23105.mail.ird.yahoo.com>
References: <20061117141230.70698.qmail@web23105.mail.ird.yahoo.com>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 15:21:08 +0100
Message-Id: <1163773268.5968.122.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 14:12 +0000, moreau francis wrote:
> Peter Zijlstra wrote:
> > No indeed. You seem confused with remaining and new. 
> > 
> > It has one VMA (A) it needs to split that into two pieces, it happens to
> > do it like (B,A') where A' is the old VMA object with new a start
> > address, and B is a new VMA object.
> 
> Is there any rules to decide which VMA is the new one ? 

The new object is the one allocated using:
	new = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);

> From what you wrote it seems that we call B the new object because
> it has a new end address...

No, because its newly allocated.

> From my point of view, I called B the old VMA simply because it's
> going to be destroyed...

Please read Mel Gorman's book on memory management to gain a better
understanding.

http://www.phptr.com/bookstore/product.asp?isbn=0131453483&rl=1


