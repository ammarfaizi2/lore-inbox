Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVGVD4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVGVD4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 23:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVGVD4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 23:56:03 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15039 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261905AbVGVD4B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 23:56:01 -0400
To: Peter Williams <pwil3058@bigpond.net.au>
cc: Paul Jackson <pj@sgi.com>, Matthew Helsley <matthltc@us.ibm.com>,
       akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: 2.6.13-rc3-mm1 (ckrm) 
In-reply-to: Your message of Fri, 22 Jul 2005 13:46:37 +1000.
             <42E06C1D.8050802@bigpond.net.au> 
Date: Thu, 21 Jul 2005 20:55:05 -0700
Message-Id: <E1Dvocr-0007n2-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Jul 2005 13:46:37 +1000, Peter Williams wrote:
> Gerrit Huizenga wrote:
> >>I imagine that the cpu controller is missing from this version of CKRM 
> >>because the bugs introduced to the cpu controller during upgrading from 
> >>2.6.5 to 2.6.10 version have not yet been resolved.
> > 
> > 
> >  I don't know what bugs you are referring to here.  I don't think we
> >  have any open defects with SuSE on the CPU scheduler in their releases.
> >  And that is not at all related to the reason for not having a CPU
> >  controller in the current patch set.
> 
> The bugs were in the patches for the 2.6.10 kernel not SuSE's 2.6.5 
> kernel.  I reported some of them to the ckrm-tech mailing list at the 
> time.  There were changes to the vanilla scheduler between 2.6.5 and 
> 2.6.10 that were not handled properly when the CKRM scheduler was 
> upgraded to the 2.6.10 kernel.

Ah - okay - that makes sense.  Those patches haven't gone through my
review yet and I'm not directly tracking their status until I figure
out what the right direction is with respect to a fair share style
scheduler of some sort.  I'm not convinced that the current one is
something that is ready for mainline or is necessarily the right answer
currently.  But we do need to figure out something that will provide
some level of CPU allocation minima & maxima for a class, where that
solution will work well on a laptop or a huge server.

Ideas in that space are welcome - I know of several proposed ideas
in progress - the scheduler in SuSE and the forward port to 2.6.10
that you referred to; an idea for building a very simple interface
on top of sched_domains for SMP systems (no fairness within a
single CPU) and a proposal for timeslice manipulation that might
provide some fairness that the Fujitsu folks are thinking about.
There are probably others and honestly, I don't have any clue yet as
to what the right long term/mainline direction should be here as yet.

gerrit
