Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319683AbSH2Xr4>; Thu, 29 Aug 2002 19:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319684AbSH2Xrz>; Thu, 29 Aug 2002 19:47:55 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:62703 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S319683AbSH2Xrz>; Thu, 29 Aug 2002 19:47:55 -0400
Date: Thu, 29 Aug 2002 19:52:18 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-mm@kvack.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: weirdness with ->mm vs ->active_mm handling
Message-ID: <20020829195218.I17288@redhat.com>
References: <20020829193413.H17288@redhat.com> <Pine.GSO.4.21.0208291940350.15425-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0208291940350.15425-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Aug 29, 2002 at 07:45:49PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 07:45:49PM -0400, Alexander Viro wrote:
> Lazy-TLB == "promise not to use a lot of stuff in the kernel".  In particular,
> any page fault in that state is a bug.

In that case the lazy vmalloc faulting code is busted, as accessing a vmalloc 
page may need to fill in a pgd/pmd entry from a lazy tlb task.  Got an idea 
for a more preferable fix?

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
