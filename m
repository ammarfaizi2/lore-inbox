Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbVLVWxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbVLVWxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 17:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVLVWxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 17:53:41 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:42139 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S965180AbVLVWxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 17:53:40 -0500
Message-ID: <43AB29B8.7050204@bigpond.net.au>
Date: Fri, 23 Dec 2005 09:33:28 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of	NFS	client	on	interactive
 response
References: <43A8EF87.1080108@bigpond.net.au>	 <1135145341.7910.17.camel@lade.trondhjem.org>	 <43A8F714.4020406@bigpond.net.au>	 <1135171280.7958.16.camel@lade.trondhjem.org>	 <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>	 <1135172453.7958.26.camel@lade.trondhjem.org>	 <43AA0EEA.8070205@bigpond.net.au> <1135289282.9769.2.camel@lade.trondhjem.org>
In-Reply-To: <1135289282.9769.2.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 22 Dec 2005 22:33:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Thu, 2005-12-22 at 13:26 +1100, Peter Williams wrote:
> 
> 
>>>Then have io_schedule() automatically set that flag, and convert NFS to
>>>use io_schedule(), or something along those lines. I don't want a bunch
>>>of RT-specific flags littering the NFS/RPC code.
>>
>>This flag isn't RT-specific.  It's used in the scheduling SCHED_NORMAL 
>>tasks and has no other semantic effects.
> 
> 
> It still has sod all business being in the NFS code. We don't touch task
> scheduling in the filesystem code.

How do you explain the use of the TASK_INTERRUPTIBLE flag then?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
