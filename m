Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTE2RCD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbTE2RCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:02:02 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:54433 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262363AbTE2RCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:02:01 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Hugh Dickins <hugh@veritas.com>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [RFC][PATCH] Avoid vmtruncate/mmap-page-fault race
Date: Thu, 29 May 2003 19:15:22 +0200
User-Agent: KMail/1.5.1
Cc: <akpm@digeo.com>, <hch@infradead.org>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305291723310.1800-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0305291723310.1800-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305291915.22235.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 May 2003 18:33, you wrote:
> On Thu, 29 May 2003, Paul E. McKenney wrote:
> > On Fri, May 23, 2003 at 11:42:02AM -0700, Paul E. McKenney wrote:
> > > Exactly -- allows a ->nopage() to drop some lock to avoid races
> > > between pagefault and either vmtruncate() or invalidate_mmap_range().
> > > This race (from the cross-host mmap viewpoint) is described in:
> > >
> > >     http://marc.theaimsgroup.com/?l=linux-kernel&m=105286345316249&w=2
> >
> > Rediffed for 2.5.70-mm1.
>
> Me?  I much preferred your original, much sparer, nopagedone patch
> (labelled "uglyh as hell" by hch).

"me too".

The fat patch that hits every fs to get rid of two lines and .5 cycles per 
no_page fault could be an epilogue (if/when it passes muster) to the little 
one that does the job and has already been thoroughly tested.

I see both sides of the argument.  The third side, not yet discussed, is the 
value of doing things incrementally, with widespread testing of the system at 
each step.

Regards,

Daniel

