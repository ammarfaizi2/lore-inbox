Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbWCWL4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWCWL4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 06:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWCWL4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 06:56:04 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:63386 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750730AbWCWL4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 06:56:02 -0500
Date: Thu, 23 Mar 2006 12:56:01 +0100
From: Andreas Mohr <andim2@users.sourceforge.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       linux-mm@kvack.org, wli@holomorphy.com
Subject: Re: mm/hugetlb.c/alloc_fresh_huge_page(): slow division on NUMA
Message-ID: <20060323115601.GA1044@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
References: <20060323110831.GA14855@rhlx01.fht-esslingen.de> <20060323034750.2ba076f0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323034750.2ba076f0.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 23, 2006 at 03:47:50AM -0800, Andrew Morton wrote:
> Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> >
> > on NUMA there
> >  indeed is an idiv opcode in the mm/hugetlb.o output:
> > 
> >   138:   e8 fc ff ff ff          call   139 <alloc_fresh_huge_page+0x32>
> 
> Stop looking at ancient 2.6.16 kernels.  That code isn't there any more ;)
Hrmpf. I had just gotten some awful suspicion when looking at 2.6.16-mm1
changelog mentioning hugemem changes. Oh well...

I'm going to hunt for similar modulo cases in the future.

Andreas
