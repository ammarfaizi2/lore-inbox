Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVCZTLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVCZTLg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 14:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVCZTLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 14:11:36 -0500
Received: from mx1.elte.hu ([157.181.1.137]:39835 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261241AbVCZTLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 14:11:30 -0500
Date: Sat, 26 Mar 2005 20:11:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050326191122.GA8144@elte.hu>
References: <20050324113912.GA20911@elte.hu> <Pine.OSF.4.05.10503242307330.25274-100000@da410.phys.au.dk> <20050325061907.GA20242@elte.hu> <Pine.LNX.4.58.0503261125420.27746@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503261125420.27746@localhost.localdomain>
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

> > i think this should be covered by the 'unschedule/unwakeup' feature,
> > mentioned in the latest mails.
> 
> The first implementation would probably just be the setting of a 
> "pending owner" bit. But the better one may be to unschedule. But, 
> what would the overhead be for unscheduling. Since you need to grab 
> the run queue locks for that. This might make for an interesting case 
> study. The waking up of a process who had the lock stolen may not 
> happen that much.  The lock stealing, would (as I see in my runs) 
> happen quite a bit though. But on UP, the waking of the robbed owner, 
> would never happen, unless it also owned a lock that a higher priority 
> process wanted.

yeah, lets skip the unscheduling for now, the 'pending owner' bit is the 
important one.

	Ingo
