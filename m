Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVBKROD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVBKROD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVBKROB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:14:01 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:3977 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262280AbVBKRNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:13:38 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Fri, 11 Feb 2005 08:54:52 -0800
User-Agent: KMail/1.7.2
Cc: Paul Jackson <pj@sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
       dino@in.ibm.com, mbligh@aracnet.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
References: <415F37F9.6060002@bigpond.net.au> <20050209175928.GA5710@chandralinux.beaverton.ibm.com> <20050211024606.GB19997@chandralinux.beaverton.ibm.com>
In-Reply-To: <20050211024606.GB19997@chandralinux.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502110854.53870.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 10, 2005 6:46 pm, Chandra Seetharaman wrote:
> On Wed, Feb 09, 2005 at 09:59:28AM -0800, Chandra Seetharaman wrote:
> > On Tue, Feb 08, 2005 at 12:42:34PM -0800, Paul Jackson wrote:
>
> --stuff deleted---
>
> > memset_controller would be similar to this, before pitching it I will
> > talk with Matt about why he thought that there is a problem.
>
> Talked to Matt Dobson and explained him the CKRM architecture and how
> cpuset/memset can be implemented as a ckrm controller. He is now convinced
> that there is no problem in making memset also a ckrm controller.
>
> As explained in the earlier mail, memset also can be implemented in the
> same way as cpuset.

Arg!  Look, cpusets is *done* (i.e. it works well) and relatively simple and 
easy to use.  It's also been in -mm for quite some time.  It also solves the 
problem of being able to deal with large jobs on large systems rather 
elegantly.  Why oppose its inclusion upstream?

CKRM seems nice, but why is it not in -mm?  I've heard it talked about a lot, 
but it usually comes up as a response to some other, simpler project, in the 
vein of "ckrm can do this, so your project is not needed" and needless to say 
that's a bit frustrating.  I'm not saying that ckrm isn't useful--indeed it 
seems like an idea with a lot of utility (I liked Rik's ideas for using it to 
manage desktop boxes and multiuser systems as a sort of per-process rlimits 
on steroids), but using it for system partitioning or systemwide accounting 
seems a bit foolish to me...

Jesse
