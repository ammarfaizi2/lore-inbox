Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266781AbUHDU1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266781AbUHDU1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUHDU1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:27:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47527 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266781AbUHDU1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:27:45 -0400
Date: Wed, 4 Aug 2004 22:10:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Message-ID: <20040804201019.GA25908@elte.hu>
References: <20040804122414.4f8649df.akpm@osdl.org> <211490000.1091648060@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <211490000.1091648060@flay>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin J. Bligh <mbligh@aracnet.com> wrote:

> >>  SDET 16  (see disclaimer)
> >>                             Throughput    Std. Dev
> >>                      2.6.7       100.0%         0.3%
> >>                  2.6.8-rc2        99.5%         0.3%
> >>              2.6.8-rc2-mm2       118.5%         0.6%
> > 
> > hum, interesting.  Can Con's changes affect the inter-node and inter-cpu
> > balancing decisions, or is this all due to caching effects, reduced context
> > switching etc?

Martin, could you try 2.6.8-rc2-mm2 with staircase-cpu-scheduler 
unapplied a re-run at least part of your tests?

there are a number of NUMA improvements queued up on -mm, and it would
be nice to know what effect these cause, and what effect the staircase
scheduler has.

	Ingo
