Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWBQDQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWBQDQR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 22:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWBQDQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 22:16:17 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:11367 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932189AbWBQDQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 22:16:16 -0500
Message-ID: <43F53FFD.7020209@bigpond.net.au>
Date: Fri, 17 Feb 2006 14:16:13 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       npiggin@suse.de, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linus Torvalds <torvalds@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Fix smpnice high priority task hopping problem
References: <43F3C9C6.5080606@bigpond.net.au> <20060216171357.A27025@unix-os.sc.intel.com> <43F53553.50904@bigpond.net.au> <43F53A42.2090909@bigpond.net.au> <20060216185837.C27025@unix-os.sc.intel.com>
In-Reply-To: <20060216185837.C27025@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 17 Feb 2006 03:16:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Fri, Feb 17, 2006 at 01:51:46PM +1100, Peter Williams wrote:
> 
>>Peter Williams wrote:
>>
>>>There's a rational argument (IMHO) that this patch should be applied 
>>>even in the absence of the smpnice patches as it prevents 
>>>active_load_balance() doing unnecessary work.  If this isn't good for 
>>>hypo threading then hypo threading is a special case and needs to handle 
>>>it as such.
>>
>>OK.  The good news is that (my testing shows that) the "sched: fix 
>>smpnice abnormal nice anomalies" fixes the imbalance problem and the 
>>consequent CPU hopping.
> 
> 
> Thats because find_busiest_group() is no longer showing the imbalance :)
> Anyhow if I get time I will review this patch before I start my vacation.
> Otherwise I assume Nick and Ingo will review this closely..
> 
> 
>>BUT I still think that this patch (modified if necessary to handle any 
>>HT special cases) should be applied.  On a normal system, it will (as 
>>I've already said) stop active_load_balance() from doing a lot of 
>>unnecessary work INCLUDING holding the run queue locks for TWO run 
>>queues for no good reason.
> 
> 
> Please see my earlier response to this..

I saw nothing there to convince me that this patch isn't worthwhile. 
Perhaps a better explanation would help me?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
