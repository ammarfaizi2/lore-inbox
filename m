Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318804AbSHLT7R>; Mon, 12 Aug 2002 15:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318805AbSHLT7R>; Mon, 12 Aug 2002 15:59:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15074 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318804AbSHLT7P>;
	Mon, 12 Aug 2002 15:59:15 -0400
Date: Tue, 13 Aug 2002 01:35:46 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1 of 2] Scalable statistics counters
Message-ID: <20020813013546.A7819@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020812183524.B1992@in.ibm.com> <20020812144605.A4595@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020812144605.A4595@infradead.org>; from hch@infradead.org on Mon, Aug 12, 2002 at 02:46:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 02:46:05PM +0100, Christoph Hellwig wrote:
> On Mon, Aug 12, 2002 at 06:35:24PM +0530, Ravikiran G Thirumalai wrote:
> > Hi Andrew,
> > Here is the new statctr patch with some of the changes suggested by Christoph.
> > Do you think the foll patch is ready to get into the mainline kernel now? 
> > If so, will you forward this to Linus or shall I send the patch to him?
> > The following patch works on 2.5.31. I will be mailing out the 2.5.31
> > version of Dipankar's kmalloc_percpu dynamic memory allocator in a separate
> > mail (since statctrs depend on them ).
> 
> But you ignored the most important suggestion.  Using proc_calc_metrics()
> in new code is a mistake.  It's a sign you want to use the seq_file
> interface.  And exporting it outside proc_misc.c is an even bigger mistake.

Christoph,

Suppose I use seq_file interface and not put all statctrs in one /proc
file, how do I associate the statctr data structure with the /proc
inode ? IOW, how do I quickly get the statctr_pentry corresponding to the
counter in statctr_open() ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
