Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVBYFHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVBYFHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 00:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVBYFHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 00:07:19 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:41439 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262532AbVBYFG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 00:06:57 -0500
Message-ID: <421EB299.4010906@ak.jp.nec.com>
Date: Fri, 25 Feb 2005 14:07:37 +0900
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       tim@physik3.uni-rostock.de, erikj@subway.americas.sgi.com,
       limin@dbear.engr.sgi.com, Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
References: <42168D9E.1010900@sgi.com> <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com> <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com> <421CEC38.7010008@sgi.com>
In-Reply-To: <421CEC38.7010008@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for this late reply.

 >> [1] Is it necessary 'fork/exec/exit' event handling framework ?
    ...<ommited>...
 >> Some process-aggregation model have own philosophy and implemantation,
 >> so it's hard to integrate. Thus, I think that common 'fork/exec/exit'
 >> event handling
 >> framework to implement any kinds of process-aggregation.
 >
 >
 > BSD needs an exit hook and ELSA needs a fork hook. I am still
 > evaluating whether CSA can use the ELSA module. If CSA can use the
 > ELSA module, CSA maybe would be fine with the fork hook.

If CSA can use an ELSA module, then we must modify the kernel-tree
for ELSA's fork-connecter. This means it's hard to implement the fork/exec/exit
event notification to userspace (,or any kernel module) without kernel-support.
How CSA shoule be implemented is interesting and important, but should it be
main subject in this discussion that such a kinds of kernel hook is necessary
to implement process-accounting per process-aggregation reasonable ?

In my understanding, what Andrew Morton said is "If target functionality can
implement in user space only, then we should not modify the kernel-tree".
But, any kind of kernel support was required to handle process lifecycle events
for the accounting per process-aggregation and so on, from our discussion.

I'm also opposed to an adhoc approach, like CSA depending on ELSA.
We should walk hight road.

Thanks,
-- 
Linux Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>
