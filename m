Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTFDVkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTFDVkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:40:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:50824 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264143AbTFDVkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:40:51 -0400
Date: Wed, 04 Jun 2003 14:43:07 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, colpatch@us.ibm.com
Subject: Re: mm3 hang
Message-ID: <1282280000.1054762987@flay>
In-Reply-To: <3EDE68F8.7DF2D0AC@digeo.com>
References: <1274420000.1054758735@flay> <3EDE68F8.7DF2D0AC@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, June 04, 2003 14:47:36 -0700 Andrew Morton <akpm@digeo.com> wrote:

> "Martin J. Bligh" wrote:
>> 
>> SDET hangs it every few runs.
> 
> You have a large number of `ps' instances which appear to be
> stuck on /proc's i_sem and lots of processes stuck in
> sched_balance_exec->set_cpus_allowed->wait_for_completion.

OK, thanks. I'm getting several different hangs, so getting confused ;-)

> The latter is a NUMA-special.  You might want to examine the
> sched_best_cpu() fixes carefully.  

Mmm. those looked like they were only for nodes with no cpus ... matt?

> Also see whether 2.5.70+bk does the same thing.

Good point - will try that.

Thanks,

M.


