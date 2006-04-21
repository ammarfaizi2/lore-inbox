Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWDUWzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWDUWzK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 18:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWDUWzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 18:55:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750709AbWDUWzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 18:55:09 -0400
Date: Fri, 21 Apr 2006 15:57:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: sekharan@us.ibm.com
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
Message-Id: <20060421155727.4212c41c.akpm@osdl.org>
In-Reply-To: <1145638722.14804.0.camel@linuxchandra>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
	<1145630992.3373.6.camel@localhost.localdomain>
	<1145638722.14804.0.camel@linuxchandra>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman <sekharan@us.ibm.com> wrote:
>
> On Fri, 2006-04-21 at 07:49 -0700, Dave Hansen wrote:
> > On Thu, 2006-04-20 at 19:24 -0700, sekharan@us.ibm.com wrote:
> > > CKRM has gone through a major overhaul by removing some of the complexity,
> > > cutting down on features and moving portions to userspace.
> > 
> > What do you want done with these patches?  Do you think they are ready
> > for mainline?  -mm?  Or, are you just posting here for comments?
> > 
> 
> We think it is ready for -mm. But, want to go through a review cycle in
> lkml before i request Andrew for that.

>From a quick scan, the overall code quality is probably the best I've seen
for an initial submission of this magnitude.  I had a few minor issues and
questions, but it'd need a couple of hours to go through it all.

So.  Send 'em over when you're ready.

I have one concern.  If we merge this framework into mainline then we'd
(quite reasonably) expect to see an ongoing dribble of new controllers
being submitted.  But we haven't seen those controllers yet.  So there is a
risk that you'll submit a major new controller (most likely a net or memory
controller) and it will provoke a reviewer revolt.  We'd then be in a
situation of cant-go-forward, cant-go-backward.

It would increase the comfort level if we could see what the major
controllers look like before committing.  But that's unreasonable.

Could I ask that you briefly enumerate

a) which controllers you think we'll need in the forseeable future

b) what they need to do

c) pointer to prototype code if poss

Thanks.
