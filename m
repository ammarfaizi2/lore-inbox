Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWEXMtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWEXMtF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 08:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbWEXMtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 08:49:04 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:21335 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S932302AbWEXMtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 08:49:03 -0400
Subject: Re: [PATCH 04/33] readahead: page flag PG_readahead
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060524123740.GA16304@mail.ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	 <20060524111858.869793445@localhost.localdomain>
	 <1148473656.10561.46.camel@lappy> <20060524123740.GA16304@mail.ustc.edu.cn>
Content-Type: text/plain
Date: Wed, 24 May 2006 14:48:48 +0200
Message-Id: <1148474928.10561.56.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 20:37 +0800, Wu Fengguang wrote:
> On Wed, May 24, 2006 at 02:27:36PM +0200, Peter Zijlstra wrote:
> > On Wed, 2006-05-24 at 19:12 +0800, Wu Fengguang wrote:


> > > --- linux-2.6.17-rc4-mm3.orig/include/linux/page-flags.h
> > > +++ linux-2.6.17-rc4-mm3/include/linux/page-flags.h
> > > @@ -89,6 +89,7 @@
> > >  #define PG_reclaim		17	/* To be reclaimed asap */
> > >  #define PG_nosave_free		18	/* Free, should not be written */
> > >  #define PG_buddy		19	/* Page is free, on buddy lists */
> > > +#define PG_readahead		20	/* Reminder to do readahead */
> > >  
> > 
> > Page flags are gouped by four, 20 would start a new set.
> > Also in my tree (git from a few days ago), 20 is taken by PG_unchached.
> 
> Thanks, grouped and renumbered it as 21.
> 
> > What code is this patch-set against?
> 
> It's against the latest -mm tree: linux-2.6.17-rc4-mm3.

Ah, now I see, -mm has got a trick up its sleeve for PG_uncached.

20 would indeed be the correct number for -mm. Then my sole comment
would be the grouping, which is a stylish nit really.

Sorry for the confusion.

Peter

