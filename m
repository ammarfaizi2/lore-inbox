Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVCaHnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVCaHnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVCaHnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:43:05 -0500
Received: from mx1.elte.hu ([157.181.1.137]:10123 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262539AbVCaHjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:39:55 -0500
Date: Thu, 31 Mar 2005 09:39:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-ID: <20050331073921.GA17455@elte.hu>
References: <1112137487.5386.33.camel@mindpipe> <1112138283.11346.2.camel@lade.trondhjem.org> <1112192778.17365.2.camel@mindpipe> <1112194256.10634.35.camel@lade.trondhjem.org> <20050330115640.0bc38d01.akpm@osdl.org> <1112217299.10771.3.camel@lade.trondhjem.org> <1112236017.26732.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112236017.26732.4.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> > Yes. Together with the radix tree-based sorting of dirty requests,
> > that's pretty much what I've spent most of today doing. Lee, could you
> > see how the attached combined patch changes your latency numbers?
> 
> Different code path, and the latency is worse.  See the attached ~7ms 
> trace.

could you check the -41-23 -RT kernel at the usual place:

   http://redhat.com/~mingo/realtime-preempt/

i've added Trond's radix lookup code, plus the lockbreaker patch.

(one thing that is not covered yet is nfs_scan_list() - that still scans 
a list. Trond, is that fixable too?)

	Ingo
