Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbVKBSx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbVKBSx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbVKBSx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:53:56 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:54739 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965175AbVKBSx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:53:56 -0500
Subject: Re: any fairness in NTPL pthread mutexes?
From: Lee Revell <rlrevell@joe-job.com>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4368FBA6.5040604@superbug.co.uk>
References: <43665B08.6040005@nortel.com>  <4368FBA6.5040604@superbug.co.uk>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 13:47:54 -0500
Message-Id: <1130957274.9163.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 17:47 +0000, James Courtier-Dutton wrote:
> Christopher Friesen wrote:
> > 
> > I'm using NPTL.
> > 
> > If I have a pthread mutex currently owned by a task, and two other tasks 
> > try to lock it, when the mutex is unlocked, are there any rules about 
> > the order in which the waiting tasks get the mutex (ie priority, FIFO, 
> > etc.)?
> > 
> > Thanks,
> > 
> > Chris
> > -
> 
> There is no fairness at all. It's currently not designed to be fair 
> either. The reasons for this I can't remember, but there was talk at the 
> KS about it and I just remember the answer. I think it had something to 
> do with "If we implement fairness, general locking performance will drop 
> and we prefer performance over fairness."
> 
> The solution is to modify your program so as not to rely on fairness.

Or try RT-NPTL + realtime and robust mutexes kernel patches.  The
problem and solution is described in more detail here:

http://developer.osdl.org/dev/robustmutexes/src/fusyn.hg/Documentation/fusyn/fusyn-why.txt

Lee

