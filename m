Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264725AbUD1KmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbUD1KmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 06:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbUD1KmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 06:42:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:1923 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264725AbUD1KmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 06:42:01 -0400
Date: Wed, 28 Apr 2004 05:41:10 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, corbet@lwn.net,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 inode cache eats system, news at 11
Message-ID: <20040428104110.GU2995@rx8.ibm.com>
References: <20040426171856.22514.qmail@lwn.net> <20040426181235.2b5b62c8.akpm@osdl.org> <408DD2D5.1040306@yahoo.com.au> <20040426210237.788045cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040426210237.788045cf.akpm@osdl.org> (from akpm@osdl.org on Mon, Apr 26, 2004 at 23:02:37 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/04 23:02:37, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> >  Andrew Morton wrote:
> > 
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc2/2.6.6-rc2-mm2/broken-out/slab-order-0-for-vfs-caches.patch
> >  > 
> >  > is not a completely happy solution, but it should fix things up.
> > 
> >  Another thing you could be doing is not zeroing swapper->nr
> >  if the shrinker function doesn't do anything, in order to try
> >  to maintain pressure on the dcache. This would be similar to
> >  your deferred list idea.
> 
> Am now doing this.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc2/2.6.6-rc2-mm2/broken-out/shrink_slab-handle-GFP_NOFS.patch

Hi Andrew,

I've been fighting a similar problem to this one on a SpecSFS setup
that Im running and it seems that this patch fixes it.  While I was
trying several other patches at the time (all of them not dcache
related) and its hard right now to measure the exact improvement
percentage,  I would guess that these patches provides at least a 
11% improvement on my 64GB machine.

BTW: I was using JFS on my setup.

Thanks

-JRS

