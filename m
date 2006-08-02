Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWHBIJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWHBIJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 04:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWHBIJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 04:09:11 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:63876 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751340AbWHBIJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 04:09:09 -0400
Date: Wed, 2 Aug 2006 13:39:40 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>,
       mason@suse.com
Subject: Re: [PATCH] [AIO] remove unused aio_run_iocbs()
Message-ID: <20060802080939.GA13539@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20060731221229.18058.82700.sendpatchset@tetsuo.zabbo.net> <20060801072731.GA20484@in.ibm.com> <44CF7DDB.3070705@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CF7DDB.3070705@oracle.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 09:14:19AM -0700, Zach Brown wrote:
> > Chris Mason's aio pipe patches used these to reduce the large
> > number of context switches he was observing when running pipetest.
> > Of course aio pipe support hasn't been merged into mainline so far, and hence
> > you could argue that we put these back in if/when we hit that problem.
> 
> Yeah, and that's trivial.
> 
> > But why
> > not just put in a comment there for now to ease the confusion ... generally
> > I'd rather go a little slow in removing apparently unused code at this
> > point when we are churning things up again.
> 
> The only thing slower than not removing it after *years* of not being
> used would be to never remove it :)

By slow, I meant having enough time between posting the RFC/patch and
its getting included in -mm or mainline. The AIO core code is tricky and
subtle in parts, so it is better to err on the side of caution during such
cleanups, at least give ourselves time to remember why something was there
in the first place. Especially now that there are several out-of-tree patches
under re-consideration.

> 
> So I don't see any value in keeping it, but I won't make a fight of it
> either.

Its not a big deal either way in this particular case - possibly only
some redundant work eventually. And I think its already in -mm anyway.

I'm just raising the flag about the need to be very careful about cleanups
in this part of the code in general.  Under such circumstances, I would
tend to look at it from the angle of "Is there a value in removing it ?"
rather than the other way around.

Regards
Suparna

> 
> - z
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

