Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVBKSqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVBKSqB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVBKSqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:46:01 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:22518 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262283AbVBKSp0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:45:26 -0500
Date: Fri, 11 Feb 2005 10:42:57 -0800
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Paul Jackson <pj@sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
       dino@in.ibm.com, mbligh@aracnet.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <20050211184257.GB21260@chandralinux.beaverton.ibm.com>
References: <415F37F9.6060002@bigpond.net.au> <20050209175928.GA5710@chandralinux.beaverton.ibm.com> <20050211024606.GB19997@chandralinux.beaverton.ibm.com> <200502110854.53870.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502110854.53870.jbarnes@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 08:54:52AM -0800, Jesse Barnes wrote:
> On Thursday, February 10, 2005 6:46 pm, Chandra Seetharaman wrote:
> > On Wed, Feb 09, 2005 at 09:59:28AM -0800, Chandra Seetharaman wrote:
> > > On Tue, Feb 08, 2005 at 12:42:34PM -0800, Paul Jackson wrote:
> >
> > --stuff deleted---
> >
> > > memset_controller would be similar to this, before pitching it I will
> > > talk with Matt about why he thought that there is a problem.
> >
> > Talked to Matt Dobson and explained him the CKRM architecture and how
> > cpuset/memset can be implemented as a ckrm controller. He is now convinced
> > that there is no problem in making memset also a ckrm controller.
> >
> > As explained in the earlier mail, memset also can be implemented in the
> > same way as cpuset.
> 
> Arg!  Look, cpusets is *done* (i.e. it works well) and relatively simple and 
> easy to use.  It's also been in -mm for quite some time.  It also solves the 
> problem of being able to deal with large jobs on large systems rather 
> elegantly.  Why oppose its inclusion upstream?

Jesse,

Do note that I did not oppose the cpuset inclusion(by saying that, "I am not
pitching for a marriage"), and here are the reasons:

1.Eventhough cpuset can be implemented under ckrm, currently the cpu controller
  and mem controller(in ckrm) cannot handle the isolating part of the cpuset stuff
  cleanly and provide the resource management capabilities ckrm is supposed to 
  provide. For that reason, one cannot expect both the cpuset and ckrm functionality
  in a same kernel.
2.I doubt that users that need cpuset will need the resource management capabilities
  ckrm provides.

My email was intented mainly to erase the notion that ckrm cannot handle cpuset.
Also, I wanted to understand if there is any real issues and that is why I talked
with Matt about why he thought ckrm cannot accomodate memset before sending the
second piece of mail.

> 
> CKRM seems nice, but why is it not in -mm?  I've heard it talked about a lot, 
> but it usually comes up as a response to some other, simpler project, in the 

We did post to lkml a while back and got comments on it. We are working on it and
will post the fixed code again in few weeks with couple of controllers.

> vein of "ckrm can do this, so your project is not needed" and needless to say 
> that's a bit frustrating.  I'm not saying that ckrm isn't useful--indeed it 
> seems like an idea with a lot of utility (I liked Rik's ideas for using it to 
> manage desktop boxes and multiuser systems as a sort of per-process rlimits 
> on steroids), but using it for system partitioning or systemwide accounting 
> seems a bit foolish to me...
> 
> Jesse

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
