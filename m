Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbUDGOu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUDGOu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:50:56 -0400
Received: from ns.suse.de ([195.135.220.2]:6110 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263698AbUDGOus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:50:48 -0400
Date: Wed, 7 Apr 2004 16:50:41 +0200
From: Andi Kleen <ak@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: david@gibson.dropbear.id.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, paulus@samba.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-Id: <20040407165041.23d8d82a.ak@suse.de>
In-Reply-To: <20040407142748.GO26474@krispykreme>
References: <20040407074239.GG18264@zax>
	<20040407143447.4d8f08af.ak@suse.de>
	<20040407142748.GO26474@krispykreme>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004 00:27:48 +1000
Anton Blanchard <anton@samba.org> wrote:

>  
> > Implementing this for ppc64 only is just wrong. Before you do this 
> > I would suggest to factor out the common code in the various hugetlbpage
> > implementations and then implement it in common code.
> 
> I could say a similar thing about your i386 specific largepage modifications
> in the NUMA api :)

All they did was to modify the code to lazy faulting. That is architecture specific

(and add the mpol code, but that was pretty minor) 

COW is a different thing though.

> 
> We should probably look at making lots of the arch specific hugetlb code
> common but im not sure we want that to become a prerequisite for merging
> NUMA API and hugepage COW.

That would just make the merging later harder. Making it common first and then
adding features would be better.

-Andi
