Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWAEObj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWAEObj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWAEObj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:31:39 -0500
Received: from mail.gmx.de ([213.165.64.21]:35524 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751323AbWAEObh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:31:37 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Thu, 05 Jan 2006 15:31:17 +0100
To: Peter Williams <pwil3058@bigpond.net.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client 
  on	interactive response
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43BD038E.9070204@bigpond.net.au>
References: <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net>
 <43BB2414.6060400@bigpond.net.au>
 <43A8EF87.1080108@bigpond.net.au>
 <1135145341.7910.17.camel@lade.trondhjem.org>
 <43A8F714.4020406@bigpond.net.au>
 <20060102110145.GA25624@aitel.hist.no>
 <43B9BD19.5050408@bigpond.net.au>
 <43BB2414.6060400@bigpond.net.au>
 <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0601-0, 01/02/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:31 PM 1/5/2006 +1100, Peter Williams wrote:
>Mike Galbraith wrote:
>>At 08:51 AM 1/5/2006 +1100, Peter Williams wrote:
>>
>>>I think that some of the harder to understand parts of the scheduler 
>>>code are actually attempts to overcome the undesirable effects (such as 
>>>those I've described) of inappropriately identifying tasks as 
>>>interactive.  I think that it would have been better to attempt to fix 
>>>the inappropriate identifications rather than their effects and I think 
>>>the prudent use of TASK_NONINTERACTIVE is an important tool for achieving this.
>>
>>IMHO, that's nothing but a cover for the weaknesses induced by using 
>>exclusively sleep time as an information source for the priority 
>>calculation.  While this heuristic does work pretty darn well, it's 
>>easily fooled (intentionally or otherwise).  The challenge is to find the 
>>right low cost informational component, and to stir it in at O(1).
>
>TASK_NONINTERACTIVE helps in this regard, is no cost in the code where 
>it's used and probably decreases the costs in the scheduler code by 
>enabling some processing to be skipped.  If by its judicious use the 
>heuristic is only fed interactive sleep data the heuristics accuracy in 
>identifying interactive tasks should be improved.  It may also allow the 
>heuristic to be simplified.

I disagree.  You can nip and tuck all the bits of sleep time you want, and 
it'll just shift the lumpy spots around (btdt).

         -Mike 

