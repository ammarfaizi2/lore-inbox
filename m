Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVDAM1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVDAM1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 07:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVDAM1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 07:27:32 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:17098 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262725AbVDAM1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 07:27:30 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050401051947.GA23990@elte.hu>
References: <1112212608.3691.147.camel@localhost.localdomain>
	 <1112218750.3691.165.camel@localhost.localdomain>
	 <20050331110330.GA24842@elte.hu>
	 <1112273378.3691.228.camel@localhost.localdomain>
	 <20050331141040.GA2544@elte.hu>
	 <1112290916.12543.19.camel@localhost.localdomain>
	 <20050331174927.GA11483@elte.hu>
	 <1112317173.28076.10.camel@localhost.localdomain>
	 <20050401044307.GB22753@elte.hu>
	 <1112332426.28076.21.camel@localhost.localdomain>
	 <20050401051947.GA23990@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 01 Apr 2005 07:27:25 -0500
Message-Id: <1112358445.28076.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 07:19 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > could you send me your latest patch for the bit-spin issue? My main 
> > > issue was cleanliness, so that the patch doesnt get stuck in the -RT 
> > > tree forever.
> > 
> > I think that's the main problem. Without changing the design of the 
> > ext3 system, I don't think there is a clean patch.  The implementation 
> > that I finally settled down with was to make the j_state and 
> > j_journal_head locks two global locks. I had to make a few 
> > modifications to some spots to avoid deadlocks, but this worked out 
> > well. The problem I was worried about was this causing too much 
> > overhead. So the ext3 buffers would have to contend with each other. I 
> > don't have any tests to see if this had too much of an impact.
> 
> yeah - i think Andrew said that a global lock at that particular place 
> might not be that much of an issue.
> 

OK, I'll start stripping it out of my kernel today and make a clean
patch for you.

-- Steve

