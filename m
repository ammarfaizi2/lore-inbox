Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWFTQBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWFTQBD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWFTQBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:01:03 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:19092 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751357AbWFTQBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:01:01 -0400
Date: Tue, 20 Jun 2006 17:55:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060620155556.GA19439@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060620123342.GA26579@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620123342.GA26579@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jun 20, 2006 at 01:17:13PM +0100, Steven Whitehouse wrote:
> > Hi,
> > 
> > Linus, Andrew suggested to me to send this pull request to you directly.
> > Please consider merging the GFS2 filesystem and DLM from (they are both
> > in the same tree for ease of testing):
> 
> Did anyone actually bother to review it?  It's huge and was in pretty 
> bad shapre when I looked last time.  Also in the -mm merge writeup you 
> guys said it's only scheduled for 2.6.19 so I didn't even bother 
> looking at the huge mess.

i'm confused, are we looking at the same piece of code? Perhaps you are 
still looking at some older codebase? fs/gfs2/ in Steven's current GIT 
tree is a nicely isolated 29K lines of code, fs/dlm/ [distributed lock 
manager] is 11K lines of code. Both look and work like normal Linux 
code. (and there's almost zero impact to generic code.)

Contrast that size for example to the 111K lines of code in fs/xfs/, 
which no doubt has improved recently but still looks a bit alien. For 
example the myriads locking APIs are still quite confusing in XFS, and 
it still feels like a kernel within the kernel. The other cluster 
filesystem which was merged recently, OCFS2, is 44K lines of code. So 
really, on what basis do you call GFS2 "huge"?

	Ingo
