Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUHCEjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUHCEjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 00:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUHCEjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 00:39:47 -0400
Received: from alt.aurema.com ([203.217.18.57]:33445 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S265040AbUHCEj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 00:39:28 -0400
Message-ID: <410F16DE.5030201@bigpond.net.au>
Date: Tue, 03 Aug 2004 14:38:54 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
References: <2oEEn-197-9@gated-at.bofh.it> <m3isc1smag.fsf@averell.firstfloor.org> <410EDBF5.40205@bigpond.net.au> <20040802205332.3413cd6d.akpm@osdl.org>
In-Reply-To: <20040802205332.3413cd6d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
>>>Have you considered submitting one to -mm* for wider testing?
>>
>> I've made patches available for 2.6.8-rc2-mm1 and I'll provide them for 
>> mm2 as soon as possible.  Is there something else I should be doing?
> 
> 
> I'll probably drop staircase soon, give nicksched a whizz for a couple of
> cycles.  You're welcome to join the queue ;)

OK, thanks.

> 
> But let me re-repeat again that CPU scheduler problems tend to take a
> _long_ time to turn up - you make some change and two months later some
> person with a weird workload on expensive hardware hits a nasty corner
> case.  So I do think that we'd have to hit a nasty problem with the current
> scheduler to go making deep changes.
> 
> Although most of the fragility has been in CPU/node/HT balancing rather
> than in the timeslice allocation area.  I assume you're not touching the
> former.

Correct.  No (algorithmic) changes have been made to load balancing type 
code.  There have been some modifications so that my statistics 
gathering copes with a task moving to different CPU and some 
modifications due to changes in data structures but these should not 
change the way that load balancing etc. work.

>  It's the desktop users who seem to be more affected by the
> timeslice allocation algorithms, and the testing turnaround is much faster
> there.

OK.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
