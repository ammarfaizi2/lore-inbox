Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751852AbWCILrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbWCILrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWCILrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:47:05 -0500
Received: from cantor2.suse.de ([195.135.220.15]:61582 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751852AbWCILrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:47:03 -0500
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add percpu_counter_mod_bh
Date: Thu, 9 Mar 2006 05:14:55 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, bcrl@kvack.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       netdev@vger.kernel.org, shai@scalex86.org
References: <20060307181301.4dd6aa96.akpm@osdl.org> <20060308163258.36f3bd79.akpm@osdl.org> <20060309080651.GA3599@localhost.localdomain>
In-Reply-To: <20060309080651.GA3599@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603090514.56740.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 March 2006 09:06, Ravikiran G Thirumalai wrote:
> On Wed, Mar 08, 2006 at 04:32:58PM -0800, Andrew Morton wrote:
> > Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> > >
> > > On Wed, Mar 08, 2006 at 03:43:21PM -0800, Andrew Morton wrote:
> > > > Benjamin LaHaise <bcrl@kvack.org> wrote:
> > > > >
> > > > > I think it may make more sense to simply convert local_t into a long, given 
> > > > > that most of the users will be things like stats counters.
> > > > > 
> > > > 
> > > > Yes, I agree that making local_t signed would be better.  It's consistent
> > > > with atomic_t, atomic64_t and atomic_long_t and it's a bit more flexible.
> > > > 
> > > > Perhaps.  A lot of applications would just be upcounters for statistics,
> > > > where unsigned is desired.  But I think the consistency argument wins out.
> > > 
> > > It already is... for most of the arches except x86_64.
> > 
> > x86 uses unsigned long.
> 
> Here's a patch making x86_64 local_t to 64 bits like other 64 bit arches.
> This keeps local_t unsigned long.  (We can change it to signed value 
> along with other arches later in one go I guess)

I already did that change in my tree
(except it's currently unsigned long as Andrew Indicated) 

-Andi


>
