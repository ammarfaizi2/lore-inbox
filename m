Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbUC3HOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUC3HOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:14:53 -0500
Received: from mx1.elte.hu ([157.181.1.137]:20402 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262221AbUC3HOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:14:51 -0500
Date: Tue, 30 Mar 2004 09:15:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: nickpiggin@yahoo.com.au, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <20040330071519.GA20227@elte.hu>
References: <20040325203032.GA15663@elte.hu> <20040329084531.GB29458@wotan.suse.de> <4068066C.507@yahoo.com.au> <20040329080150.4b8fd8ef.ak@suse.de> <20040329114635.GA30093@elte.hu> <20040329221434.4602e062.ak@suse.de> <4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de> <20040330064015.GA19036@elte.hu> <20040330090716.67d2a493.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330090716.67d2a493.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > Andi, could you please try the patch below - this will test whether this
> > has to do with the rate of balancing between NUMA nodes. The patch
> > itself is not correct (it way overbalances on NUMA), but it tests the
> > theory.
> 
> This works much better, but wildly varying (my tests go from 2.8xCPU
> to ~3.8x CPU for 4 CPUs. 2,3 CPU cases are ok). A bit more consistent
> results would be better though.

ok, could you try min_interval,max_interval and busy_factor all with a
value as 4, in sched.h's SD_NODE_INIT template? (again, only for testing
purposes.)

	Ingo
