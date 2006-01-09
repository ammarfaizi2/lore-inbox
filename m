Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbWAIAaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbWAIAaV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWAIAaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:30:21 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:44269 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965051AbWAIAaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:30:20 -0500
Subject: Re: 2.6.15-rt2 x86_64 SMP instability
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Rigg <lk@sound-man.co.uk>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.58.0601081923430.26375@gandalf.stny.rr.com>
References: <20060108230724.GA4197@localhost.localdomain>
	 <Pine.LNX.4.58.0601081923430.26375@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 19:30:17 -0500
Message-Id: <1136766618.2997.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-08 at 19:26 -0500, Steven Rostedt wrote:
> Yep, this is a known issue, with the x86_64 SMP.  The timestamp counter
> does not run in sync with each cpu, so the timing gets all screwed up.
> If you want to fix this, boot with the command line option idle=poll.
> But, unfortunately, this means that the cpu will waste energy even when
> it's not doing anything.
> 
> I'm looking into ways to fix this for my main machine which is also a
> x86_64 SMP.
> 

I thought this could be worked around by using the ACPI PM timer?

Lee

