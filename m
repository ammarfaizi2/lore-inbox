Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272122AbRIVUrC>; Sat, 22 Sep 2001 16:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272118AbRIVUqw>; Sat, 22 Sep 2001 16:46:52 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:34200 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S272122AbRIVUqj>; Sat, 22 Sep 2001 16:46:39 -0400
Date: Sat, 22 Sep 2001 16:46:47 -0400
To: Peter Magnusson <iocc@linux-kernel.flashdance.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <20010922164645.D15681@cs.cmu.edu>
Mail-Followup-To: Peter Magnusson <iocc@linux-kernel.flashdance.cx>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0109222159240.26518-100000@flashdance>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0109222159240.26518-100000@flashdance>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 09:59:59PM +0200, Peter Magnusson wrote:
> Jan Harkes wrote:
> > Because pages aren't 'aged' until there is swap allocated for them, your
> > kernel should actually work better if it has a lot of pages backed by
> > swap. The only thing is, we don't really make the right decision about
> 
> It doesnt. It just gets slower.
> If it really become faster i would not have written my orginal posting.

Only when the wrong pages have been swapped out and need to be swapped
in again. Swapped out pages should be relatively inactive, the amount of
swap space allocated number that you see in 'free' is not the same as
the amount of pages that are actually swapped out and removed from
memory, any active ones should still be around in the pagecache.

> Use the swap as little as possible == good.

Nope, Use the swap-in as little as possible == good, I don't mind having
4GB of data in swap, as long as I typically don't need to load it back
into in memory. And every page that is in swap that I don't really need
means another page that can be used to avoid paging out an executable,
or purging the dentry lookup caches, or dropping one of those files I
access once every 5 minutes.

Jan

