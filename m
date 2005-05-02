Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVEBTMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVEBTMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 15:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVEBTMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 15:12:05 -0400
Received: from colin.muc.de ([193.149.48.1]:33547 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261713AbVEBTMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 15:12:00 -0400
Date: 2 May 2005 21:11:59 +0200
Date: Mon, 2 May 2005 21:11:59 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: venkatesh.pallipadi@intel.com, racing.guo@intel.com, luming.yu@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]porting lockless mce from x86_64 to i386
Message-ID: <20050502191159.GI27150@muc.de>
References: <88056F38E9E48644A0F562A38C64FB60049EED02@scsmsx403.amr.corp.intel.com> <20050502171551.GG27150@muc.de> <20050502113125.19320ceb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502113125.19320ceb.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 11:31:25AM -0700, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> >  > 
> >  > Doing it either way should be OK with this mce code. But I feel, 
> >  > despite of the patch size, it is better to keep all the shared 
> >  > code in i386 tree and link it from x86-64. Otherwise, it may become 
> >  > kind of messy in future, with various links between i386 and x86-64.
> > 
> >  i386 already uses code from x86-64 (earlyprintk.c) - it is nothing 
> >  new.
> 
> I must say I don't like the bidirectional sharing either.

Why exactly? X86-64 is not a "slave" of i386, they are equal peers; 
free to share from each other, but none better than the other ... ,-) 

-Andi (fighting for the rights of the repressed architectures ;-)
> 
> But I guess it'll be simple enough to fix up if it causes any real problems
> in the future.

The only complaint I heard so far was from a kernel hacker who deleted
all  non i386 architectures in his kernel trees, but I was not 
very sympathetic to that one. In fact I think it is better
when people have full trees around so when they change something
globally grep finds really all instances.

-Andi


> 
