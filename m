Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbUKRXlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUKRXlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUKRXkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:40:15 -0500
Received: from [194.90.79.130] ([194.90.79.130]:50437 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S261200AbUKRXi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:38:29 -0500
Message-ID: <419D3271.7050804@argo.co.il>
Date: Fri, 19 Nov 2004 01:38:25 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Keith Owens <kaos@ocs.com.au>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WTF is VLI?
References: <200411181808.iAII8ECH009759@laptop11.inf.utfsm.cl>
In-Reply-To: <200411181808.iAII8ECH009759@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2004 23:38:26.0629 (UTC) FILETIME=[B3767F50:01C4CDC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>>ksymoops can disasemble the entire code line, but starting at different 
>>offsets (up to the maximum instruction length) from the start. the first 
>>disassembly to include the program counter in the output would be deemed 
>>correct.
>>    
>>
>
>There might be several... I see no reason to consider the first one
>correct.
>  
>
Of course, there is no way to guarantee correctness. the point is with 
the current system the chances of being correct are around 1:(average 
instruction length) (a bit better because there is a chance to resync), 
while with my proposal to be _incorrect_ you need to start wrong _and_ 
hit a bad resync.

I don't get to see many oopsen, but it seems to me most would have 
garbage before eip, no?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

