Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266109AbTIKFri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 01:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266105AbTIKFri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 01:47:38 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:22690 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266109AbTIKFrd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 01:47:33 -0400
Date: Thu, 11 Sep 2003 11:24:30 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How reliable is SLAB_HWCACHE_ALIGN?
Message-ID: <20030911055428.GA1140@llm08.in.ibm.com>
References: <20030910081654.GA1129@llm08.in.ibm.com> <1063208464.700.35.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063208464.700.35.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 11:41:04AM -0400, Robert Love wrote:
> On Wed, 2003-09-10 at 04:16, Ravikiran G Thirumalai wrote:
> 
> > Am I missing something or can there really be two objects on the same 
> > cacheline even when SLAB_HWCACHE_ALIGN is specified?
> 
> No, you are right.
> 
> If your object _must_ be cache aligned, use SLAB_MUST_HWCACHE_ALIGN.
> 

WOW!!!
Looking at the code though, SLAB_MUST_HWCACHE_ALIGN is never considered
by kmem_cache_create or kmem_cache_alloc. So, right now, there is no way of 
getting objects which are _guaranteed_ to be cacheline aligned!!!(?)

Kiran
