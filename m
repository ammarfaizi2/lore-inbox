Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422973AbWJRVTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422973AbWJRVTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422977AbWJRVTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:19:39 -0400
Received: from ozlabs.org ([203.10.76.45]:53690 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1422973AbWJRVTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:19:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
Date: Thu, 19 Oct 2006 07:19:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Will Schmidt <will_schmidt@vnet.ibm.com>, akpm@osdl.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	<1160769226.11239.22.camel@farscape>
	<1160773040.11239.28.camel@farscape>
	<Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
	<1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	<17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:

> > Linus' tree is currently broken for us.  Any suggestions for how to
> > fix it, since I am not very familiar with the NUMA code?
> 
> Have memory available for slab boot strap on node 0? Or modify the boot 
> code in such a way that it runs on node 1 or any other node that has 
> memory available.

OK, then I don't understand.  There is about 1GB of memory on node 0,
which is about half of the partition's memory, and it is even in a
contiguous chunk, but it doesn't start at pfn 0:

early_node_map[3] active PFN ranges
    1:        0 ->    32768
    0:    32768 ->   278528
    1:   278528 ->   524288

So it's not that node 0 doesn't have any pages.  Any other clues?

Thanks,
Paul.
