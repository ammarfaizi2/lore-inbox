Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWBXLYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWBXLYz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 06:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWBXLYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 06:24:55 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:61112 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932146AbWBXLYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 06:24:54 -0500
Date: Fri, 24 Feb 2006 16:55:04 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, sct@redhat.com, mason@suse.com,
       linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org,
       sonny@burdell.org
Subject: Re: [RFC][WIP] DIO simplification and AIO-DIO stability
Message-ID: <20060224112504.GA2501@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20060223072955.GA14244@in.ibm.com> <1140741566.22756.170.camel@dyn9047017100.beaverton.ibm.com> <20060223171336.7b412efc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223171336.7b412efc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 05:13:36PM -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > I am still trying to understand the whole proposal to give you better
> >  feedback. But, my gut feeling is - its not going to be any more simpler
> >  than what we have today :(
> > 
> 
> Yes, that's my general reaction as well.  That code's solving a complex and
> messy problem, so it got complex and messy.

True. As you say, we just understand extent of the problem better now.
I think Stephen put in considerable thought into the implementation for
2.4, but at that time he probably didn't have to contend with the
locking modes and AIO, which have exposed a lot more scenarios, especially
with regard to error handling.

> 
> Of course, a reimplementation might certainly end up faster, cleaner,
> better.  A throw-away-and-reimplement exercise often has that result, but
> mainly because on the second time the reimplementors understand the full
> scope of the problem at the outset rather than at the end.  So this time
> around, as you imply, we'd need to get a full problem description and set
> of testcases collected.
> 
> That code does a _lot_ of stuff.  Fortunately, It's basically all in
> direct-io.c and that file exports a single function.  So it's possible that
> a reimplmentation could tick along alongside the existing implementation and
> ideally, it's just a matter of changing one entry in each filesystem's a_ops.

Sounds like a good idea.

Regards
Suparna

> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

