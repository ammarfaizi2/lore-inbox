Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVAGBWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVAGBWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVAGBVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:21:55 -0500
Received: from waste.org ([216.27.176.166]:31129 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261265AbVAGBSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:18:47 -0500
Date: Thu, 6 Jan 2005 17:18:20 -0800
From: Matt Mackall <mpm@selenic.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andreas Steinmetz <ast@domdv.de>, Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107011820.GC2995@waste.org>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de> <1104898693.24187.162.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104898693.24187.162.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 04:18:15AM +0000, Alan Cox wrote:
> On Mer, 2005-01-05 at 01:35, Andreas Steinmetz wrote:
> > Let me remind you all that according to lkml history hch has always been 
> > biased and objecting to anything related to lsm. Nobody can take hch's 
> > opinion here as objective. I would even go so far that when things are 
> > related to lsm(s) he's just tro...
> 
> Oh I don't think so. Everyone thinks Christoph has it in for their
> project (me included quite often). He's just blessed with a lot of taste
> and determination to enforce it, and cursed (or perhaps blessed) with
> the ability to explain bluntly and clearly his opinion.
> 
> gid hacks are not a good long term plan.
> 
> Can we use capabilities, if not - why not and how do we fix it so we can
> do the job right. Do we need some more capability bits that are
> implicitly inherited and not touched by setuidness ?

Why can't this be done with a simple SUID helper to promote given
tasks to RT with sched_setschedule, doing essentially all the checks
this LSM is doing? 

Objections of "because it requires dangerous root or suid" don't fly,
an RT app under user control can DoS the box trivially. Never mind you
need root to configure the LSM anyway..

-- 
Mathematics is the supreme nostalgia of our time.
