Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbVBYRcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVBYRcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 12:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVBYRcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 12:32:24 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:39639 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262762AbVBYRcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 12:32:11 -0500
Message-ID: <421F6139.5020207@sgi.com>
Date: Fri, 25 Feb 2005 09:32:41 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Kaigai Kohei <kaigai@ak.jp.nec.com>, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       tim@physik3.uni-rostock.de, erikj@subway.americas.sgi.com,
       limin@dbear.engr.sgi.com, jbarnes@sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
References: <42168D9E.1010900@sgi.com>	<20050218171610.757ba9c9.akpm@osdl.org>	<421993A2.4020308@ak.jp.nec.com>	<421B955A.9060000@sgi.com>	<421C2B99.2040600@ak.jp.nec.com>	<421CEC38.7010008@sgi.com>	<421EB299.4010906@ak.jp.nec.com> <20050224212839.7953167c.akpm@osdl.org>
In-Reply-To: <20050224212839.7953167c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Kaigai Kohei <kaigai@ak.jp.nec.com> wrote:
> 
>>In my understanding, what Andrew Morton said is "If target functionality can
>> implement in user space only, then we should not modify the kernel-tree".
> 
> 
> fork, exec and exit upcalls sound pretty good to me.  As long as
> 
> a) they use the same common machinery and
> 
> b) they are next-to-zero cost if something is listening on the netlink
>    socket but no accounting daemon is running.
> 
> Question is: is this sufficient for CSA?

Yes, fork, exec, and exit upcalls are sufficient for CSA.

The framework i proposed earlier should satisfy your requirement a
and b, and provides upcalls needed by BSD, ELSA and CSA. Maybe i
misunderstood your concern of the 'very light weight' framework
i proposed besides being "overkill"?

- jay


