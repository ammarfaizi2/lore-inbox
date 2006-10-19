Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946212AbWJSQtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946212AbWJSQtO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946219AbWJSQtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:49:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51883 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946212AbWJSQtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:49:13 -0400
Date: Thu, 19 Oct 2006 09:49:05 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Anton Blanchard <anton@samba.org>
cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <20061019163044.GB5819@krispykreme>
Message-ID: <Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
References: <1161026409.31903.15.camel@farscape>
 <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
 <1161031821.31903.28.camel@farscape> <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
 <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
 <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
 <17719.1849.245776.4501@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
 <20061019163044.GB5819@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006, Anton Blanchard wrote:

> > Would you please make memory available on the node that you bootstrap 
> > the slab allocator on? numa_node_id() must point to a node that has memory 
> > available.
> 
> So we've gone from something that worked around sub optimal memory
> layouts to something that panics. Sounds like a step backwards to me.

Could you confirm that there is indeed no memory on node 0? 

The expectation to have memory available on the node that you 
bootstrap on is not unrealistic.

