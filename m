Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267594AbUH2CVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267594AbUH2CVS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 22:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267596AbUH2CVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 22:21:18 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60373 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267594AbUH2CUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 22:20:45 -0400
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin
	and others)
From: Lee Revell <rlrevell@joe-job.com>
To: spaminos-ker@yahoo.com
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040829011936.39122.qmail@web13907.mail.yahoo.com>
References: <20040829011936.39122.qmail@web13907.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1093746044.7078.29.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 22:20:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 21:19, spaminos-ker@yahoo.com wrote:
> --- Lee Revell <rlrevell@joe-job.com> wrote:
> > Is this an SMP machine?  There were problems with that version of the
> > voluntary preemption patches on SMP.  The latest version, Q3, should fix
> > these.
> > 
> No, it's a single CPU Athlon 1800+, the kernel is compiled in with support for
> SMP system, but that should not have any impact.
> 

It shouldn't, but it can.  For example taking a spinlock just disables
preemption with a UP kernel, but with an SMP kernel I believe you can
actually end up spinning.  You would have to have hit a locking bug or
race condition for this to happen.  Just to be certain, can you
reproduce the problem with a UP kernel?

Lee

