Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVDAFXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVDAFXR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 00:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVDAFUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 00:20:51 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59031 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262644AbVDAFUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 00:20:08 -0500
Date: Fri, 1 Apr 2005 07:19:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050401051947.GA23990@elte.hu>
References: <1112212608.3691.147.camel@localhost.localdomain> <1112218750.3691.165.camel@localhost.localdomain> <20050331110330.GA24842@elte.hu> <1112273378.3691.228.camel@localhost.localdomain> <20050331141040.GA2544@elte.hu> <1112290916.12543.19.camel@localhost.localdomain> <20050331174927.GA11483@elte.hu> <1112317173.28076.10.camel@localhost.localdomain> <20050401044307.GB22753@elte.hu> <1112332426.28076.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112332426.28076.21.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > could you send me your latest patch for the bit-spin issue? My main 
> > issue was cleanliness, so that the patch doesnt get stuck in the -RT 
> > tree forever.
> 
> I think that's the main problem. Without changing the design of the 
> ext3 system, I don't think there is a clean patch.  The implementation 
> that I finally settled down with was to make the j_state and 
> j_journal_head locks two global locks. I had to make a few 
> modifications to some spots to avoid deadlocks, but this worked out 
> well. The problem I was worried about was this causing too much 
> overhead. So the ext3 buffers would have to contend with each other. I 
> don't have any tests to see if this had too much of an impact.

yeah - i think Andrew said that a global lock at that particular place 
might not be that much of an issue.

	Ingo
