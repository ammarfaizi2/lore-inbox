Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266785AbUG1FN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266785AbUG1FN6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 01:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266787AbUG1FN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 01:13:57 -0400
Received: from services.exanet.com ([212.143.73.102]:22281 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S266785AbUG1FNr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 01:13:47 -0400
Message-ID: <41073607.4060909@exanet.com>
Date: Wed, 28 Jul 2004 08:13:43 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
References: <41050300.90800@exanet.com>	 <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com>	 <20040727203438.GB2149@elf.ucw.cz> <4106C2E8.905@exanet.com>	 <41070183.5000701@yahoo.com.au> <1090981035.14637.30.camel@lade.trondhjem.org>
In-Reply-To: <1090981035.14637.30.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Jul 2004 05:13:44.0176 (UTC) FILETIME=[A75D0F00:01C47461]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>På ty , 27/07/2004 klokka 21:29, skreiv Nick Piggin:
>
>  
>
>>There is some need arising for a call to set the PF_MEMALLOC flag for
>>userspace tasks, so you could probably get a patch accepted. Don't
>>call it KSWAPD_HELPER though, maybe MEMFREE or RECLAIM or RECLAIM_HELPER.
>>
>>But why is your NFS server needed to reclaim memory? Do you have the
>>filesystem mounted locally?
>>    
>>
>
>...and why can't this problem be fixed by judicious use of mlock()?
>
>  
>
I mlock(MLOCK_ALL) as soon as I wake up in the morning (and I never ask 
the kernel for more memory), but the kernel likes to allocate memory 
when performing some syscalls for me.


Avi
