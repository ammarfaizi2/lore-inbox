Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbUC3ISN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 03:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUC3ISM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 03:18:12 -0500
Received: from mx1.elte.hu ([157.181.1.137]:44236 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263364AbUC3ISL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 03:18:11 -0500
Date: Tue, 30 Mar 2004 10:18:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: nickpiggin@yahoo.com.au, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <20040330081840.GA22733@elte.hu>
References: <4068066C.507@yahoo.com.au> <20040329080150.4b8fd8ef.ak@suse.de> <20040329114635.GA30093@elte.hu> <20040329221434.4602e062.ak@suse.de> <4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de> <20040330064015.GA19036@elte.hu> <20040330090716.67d2a493.ak@suse.de> <20040330071519.GA20227@elte.hu> <20040330094811.622af0f4.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330094811.622af0f4.ak@suse.de>
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

> > ok, could you try min_interval,max_interval and busy_factor all with a
> > value as 4, in sched.h's SD_NODE_INIT template? (again, only for testing
> > purposes.)
> 
> I kept the old patch and made these changes. The results are much more
> consistent now 3+x CPU. I still get varyations of ~2GB/s, but I had
> this with older kernels too.

great.

now, could you try the following patch, against vanilla -mm5:

	redhat.com/~mingo/scheduler-patches/sched2.patch

this includes 'context balancing' and doesnt touch the NUMA async
balancing tunables. Do you get better performance than with stock -mm5?

	Ingo
