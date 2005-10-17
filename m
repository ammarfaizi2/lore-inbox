Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVJQQ3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVJQQ3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVJQQ3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:29:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:3291 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750704AbVJQQ3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:29:34 -0400
Date: Mon, 17 Oct 2005 21:53:26 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051017162326.GB13665@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4353CADB.8050709@cosmosbay.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 06:01:31PM +0200, Eric Dumazet wrote:
> Linus Torvalds a écrit :
> 
> >
> > - post-14: work on making sure rcu callbacks are done in a more timely 
> >   manner when the rcu queue gets long. This would involve TIF_RCUPENDING 
> >   and whatever else to make sure that we have timely quiescent periods, 
> >   and we do the RCU callback tasklet more often if the queue is long.
> >
> 
> Absolutely. Keeping a count of (percpu) queued items is basically free if 
> kept in the cache line used by list head, so the 'queue length on this cpu' 
> is a cheap metric.

Or 'sudden increase in queue length on this cpu' :)

> A 'realtime refinement' would be to use a different maxbatch limit 
> depending on the caller's priority : Let a softirq thread have a lower 
> batch count than a regular user thread.

Yes, would be interesting.

Thanks
Dipankar
