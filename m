Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVDFHOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVDFHOB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 03:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVDFHOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 03:14:00 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17097 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262039AbVDFHN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 03:13:57 -0400
Date: Wed, 6 Apr 2005 09:13:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/5] sched: remove degenerate domains
Message-ID: <20050406071341.GA7517@elte.hu>
References: <425322E0.9070307@yahoo.com.au> <20050406054412.GA5853@elte.hu> <20050406001041.A24403@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050406001041.A24403@unix-os.sc.intel.com>
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


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> Similarly I am working on adding a new core domain for dual-core 
> systems! All these domains are unnecessary and cause performance 
> isssues on non Multi-threading/Multi-core capable cpus! Agreed that 
> performance impact will be minor but still...

ok, lets keep it then. It may in fact simplify the domain setup code: we 
could generate the 'most generic' layout for a given arch all the time, 
and then optimize it automatically. I.e. in theory we could have just a 
single domain-setup routine, which would e.g. generate the NUMA domains 
on SMP too, which would then be optimized away.

	Ingo
