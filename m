Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756753AbWK1VgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbWK1VgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 16:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756867AbWK1VgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 16:36:23 -0500
Received: from smtp1.Stanford.EDU ([171.67.22.28]:55715 "EHLO
	smtp1.stanford.edu") by vger.kernel.org with ESMTP id S1756753AbWK1VgW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 16:36:22 -0500
Subject: Re: 2.6.19-rc6-rt7: Kernel BUG at kernel/rtmutex.c:672
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20061128200611.GB25364@elte.hu>
References: <1164737474.15887.10.camel@cmn3.stanford.edu>
	 <20061128200611.GB25364@elte.hu>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 13:36:19 -0800
Message-Id: <1164749780.15887.56.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 21:06 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > (a normal non-root user was left logged in and was running jackd with 
> > realtime privileges, irqs' priority reordered with the rtirq script - 
> > I was getting, and still are under -rt8, lots of audio xruns but 
> > that's for another thread).
> 
> do you get those xruns even with maxcpus=1? I.e. is it an SMP-only 
> regression - or is UP affected too? [if it's UP then it would be simpler 
> to trace that xrun]

It appears to be smp related, I just booted with maxcpus=1 and I'm
seeing a lot less in terms of xruns (three so far in the range 0.029 to
0.041 ms). 

-- Fernando


