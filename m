Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbVBYSLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVBYSLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 13:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbVBYSLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 13:11:12 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:4578 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262770AbVBYSLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 13:11:10 -0500
Message-ID: <421F6A6A.5050503@sgi.com>
Date: Fri, 25 Feb 2005 10:11:54 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Kaigai Kohei <kaigai@ak.jp.nec.com>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net, tim@physik3.uni-rostock.de,
       erikj@subway.americas.sgi.com, limin@dbear.engr.sgi.com,
       jbarnes@sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
References: <42168D9E.1010900@sgi.com> <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com> <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com> <421CEC38.7010008@sgi.com> <421EB299.4010906@ak.jp.nec.com> <20050224212839.7953167c.akpm@osdl.org> <421F6139.5020207@sgi.com> <20050225174525.GF28536@shell0.pdx.osdl.net>
In-Reply-To: <20050225174525.GF28536@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Jay Lan (jlan@sgi.com) wrote:
> 
>>Andrew Morton wrote:
>>
>>>Kaigai Kohei <kaigai@ak.jp.nec.com> wrote:
>>>
>>>
>>>>In my understanding, what Andrew Morton said is "If target functionality 
>>>>can
>>>>implement in user space only, then we should not modify the kernel-tree".
>>>
>>>
>>>fork, exec and exit upcalls sound pretty good to me.  As long as
>>>
>>>a) they use the same common machinery and
>>>
>>>b) they are next-to-zero cost if something is listening on the netlink
>>>  socket but no accounting daemon is running.
>>>
>>>Question is: is this sufficient for CSA?
>>
>>Yes, fork, exec, and exit upcalls are sufficient for CSA.
> 
> 
> As soon as you want to throttle tasks at the Job level, this would be
> insufficient.  But, IIRC, that's not one of PAGG/Job/CSA's requirements
> right?

PAGG serves more than JOB+CSA.

I am looking into possiblity/feasibility of implementing JOB at
userspace. However, even with JOB as a kernel module, the fork,
exec and exit upcalls would be sufficient to support JOB+CSA.

Thanks,
  - jay

> 
> thanks,
> -chris

