Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUJHDQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUJHDQY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUJHDPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 23:15:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14551 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267745AbUJHDK5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 23:10:57 -0400
Date: Thu, 7 Oct 2004 22:08:11 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: "Gabor Z. Papp" <gzp@papp.hu>, Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] 0-order allocation failed
Message-ID: <20041008010811.GC16968@logos.cnet>
References: <200410071318.21091.mbuesch@freenet.de> <20041007153929.GB14614@logos.cnet> <x67jq2bcy3@gzp> <200410072054.17097@WOLK> <20041008010539.GB16968@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041008010539.GB16968@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 10:05:39PM -0300, Marcelo Tosatti wrote:
> On Thu, Oct 07, 2004 at 08:54:16PM +0200, Marc-Christian Petersen wrote:
> > On Thursday 07 October 2004 20:28, Gabor Z. Papp wrote:
> > 
> > Hi all,
> > 
> > > | > > Can you check how much swap space is there available when
> > > | > > the OOM killer trigger? I bet this is the case.
> > > | > The machine doesn't have swap.
> > > | Well then you're probably facing true OOM.
> > > | Add some swap.
> > 
> > > There is really no way to run 2.4 without swap?
> > > I have the same problem with nfsroot and ramdisk based setups after
> > > 1-2 weeks uptime.
> > 
> > stop whining about braindead 2.4 mainline vm. Apply the attached patch and be 
> > happy :p
> 
> As I told you in private, I can't see how badly this patch could affect performance.
> But then, as you answered, with all anonymous pages added to LRU you see much better
> behavior (tons less swapping) on several workloads. That must be due to 
> refill_inactive()/shrink_cache() balancing.

Ah, I dont think this will fix the OOM killer cases with no swap. They look 
like plain OOM condition to me.

Wish I'm wrong.

> The same patch also fixes kswapd excessive CPU consumption on huge
> memory box.
> 
> Its easy enough to be applied because behaviour is unchanged by default
> (you need to change a sysctl value for that).
> 
> I would like to understand why does it cause so much improved behaviour
> though.
> 
> > Marcelo: Is there something wrong with my VM documentation update patches for 
> > 2.4? Or do you not care and think: "Hello my friend, let's stick with 2.2 VM 
> > documentation even if almost all of the documentation is not longer valid"
> 
> As I said to you in private, please resend.
> 

> Thanks!
