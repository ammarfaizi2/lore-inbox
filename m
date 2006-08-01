Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWHAT4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWHAT4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWHAT4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:56:08 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:26322 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750969AbWHAT4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:56:07 -0400
Date: Tue, 1 Aug 2006 12:55:29 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
In-Reply-To: <1154460913.30391.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608011254270.18917@schroedinger.engr.sgi.com>
References: <20060801030443.GA2221@gondor.apana.org.au> 
 <20060731210418.084f9f5d.akpm@osdl.org>  <20060801050259.GA3126@gondor.apana.org.au>
  <20060731225454.19981a5f.akpm@osdl.org>  <Pine.LNX.4.64.0608011034540.18006@schroedinger.engr.sgi.com>
  <1154459316.29772.5.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0608011209560.18537@schroedinger.engr.sgi.com>
 <1154460913.30391.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006, Steven Rostedt wrote:

> > Yes. But then that number must always be a fraction of pagesize.
> > 
> 
> understood, as is 1024, 2048, and 4096 are.  Well, if pagesize is 4096
> is 4096 really a fraction of 4096? :)
> 
> Also, isn't all sizes for kmalloc that are under pagesize a fraction of
> the page size? Or more correctly, a power of 2?

Well the size of the object and the alignment must be a fraction of the 
pagesize. If you get page aligned pages then I wonder why use the slab 
allocator? The page allocator will be much better suited.

