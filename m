Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVCaOvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVCaOvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVCaOvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:51:54 -0500
Received: from mx2.elte.hu ([157.181.151.9]:2752 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261486AbVCaOu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:50:29 -0500
Date: Thu, 31 Mar 2005 16:50:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-ID: <20050331145015.GA4830@elte.hu>
References: <1112237239.26732.8.camel@mindpipe> <1112240918.10975.4.camel@lade.trondhjem.org> <20050331065942.GA14952@elte.hu> <20050330231801.129b0715.akpm@osdl.org> <20050331073017.GA16577@elte.hu> <1112270304.10975.41.camel@lade.trondhjem.org> <1112272451.10975.72.camel@lade.trondhjem.org> <20050331135825.GA2214@elte.hu> <1112279522.20211.8.camel@lade.trondhjem.org> <20050331143930.GA4032@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331143930.GA4032@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > So the overhead you are currently seeing should just be that of 
> > iterating through the list, locking said requests and adding them to 
> > our private list.
> 
> ah - cool! This was a 100 MB writeout so having 3.7 msecs to process 
> 20K+ pages is not unreasonable. To break the latency, can i just do a 
> simple lock-break, via the patch below?

with this patch the worst-case latency during NFS writeout is down to 40 
usecs (!).

Lee: i've uploaded the -42-05 release with this patch included - could 
you test it on your (no doubt more complex than mine) NFS setup?

	Ingo
