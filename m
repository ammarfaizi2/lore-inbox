Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268719AbUI3OrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268719AbUI3OrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 10:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268900AbUI3OrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 10:47:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46331 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268719AbUI3OrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 10:47:05 -0400
Message-ID: <415C1C6D.1030307@watson.ibm.com>
Date: Thu, 30 Sep 2004 10:47:09 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][1/1] Per-priority statistics for CFQ w/iopriorities 2.6.8.1
References: <20040930065917.GA2288@suse.de> <415C1643.8000605@watson.ibm.com> <20040930142004.GB3251@suse.de>
In-Reply-To: <20040930142004.GB3251@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Thu, Sep 30 2004, Shailabh Nagar wrote:
> 
>>Jens Axboe wrote:
>>
>>>Hi,
>>>
>>>Missed this patch the first time over (thank you lwn :-) - why are you
>>>using atomic counters? In all the paths you set them, you already have
>>>the queue lock.
>>>
>>
>>Thats right, there's no need for them. I used these instinctively....
>>Will fix in next version, unless (hint, hint) you're taking a look at 
>>adding priorities back to mainline's CFQ.
> 
> 
> It will never be for the mainline cfq, that is a dead code base. -mm has
> a first stab at a cfq v2 with persistent io contexts, the priority based
> code will go on top of that.
> 

Great. In CKRM, we'll switch to using -mm's cfq then.

-- Shailabh
