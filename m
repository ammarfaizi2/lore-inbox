Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTFDWLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 18:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbTFDWLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 18:11:49 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:8910 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264226AbTFDWLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 18:11:47 -0400
Message-ID: <3EDE7067.1090200@us.ibm.com>
Date: Wed, 04 Jun 2003 15:19:19 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mm3 hang
References: <1274420000.1054758735@flay> <3EDE68F8.7DF2D0AC@digeo.com> <1282280000.1054762987@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> --On Wednesday, June 04, 2003 14:47:36 -0700 Andrew Morton <akpm@digeo.com> wrote:
> 
> 
>>"Martin J. Bligh" wrote:
>>
>>>SDET hangs it every few runs.
>>
>>You have a large number of `ps' instances which appear to be
>>stuck on /proc's i_sem and lots of processes stuck in
>>sched_balance_exec->set_cpus_allowed->wait_for_completion.
> 
> 
> OK, thanks. I'm getting several different hangs, so getting confused ;-)
> 
> 
>>The latter is a NUMA-special.  You might want to examine the
>>sched_best_cpu() fixes carefully.  
> 
> Mmm. those looked like they were only for nodes with no cpus ... matt?

I don't think that set of patches would do much for this problem, but 
one never knows?

>>Also see whether 2.5.70+bk does the same thing.
> 
> 
> Good point - will try that.
> 
> Thanks,
> 
> M.

