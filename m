Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVGOBNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVGOBNL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 21:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVGOBNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 21:13:11 -0400
Received: from mail.tmr.com ([64.65.253.246]:29625 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261733AbVGOBNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 21:13:10 -0400
Message-ID: <42D70F2C.4020706@tmr.com>
Date: Thu, 14 Jul 2005 21:19:40 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Vojtech Pavlik <vojtech@suse.cz>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org, torvalds@osdl.org,
       christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050712121008.GA7804@ucw.cz> <200507122239.03559.kernel@kolivas.org> <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

> On Wed, 13 Jul 2005, Bill Davidsen wrote:
>
>> How serious is the 1/HZ = sane problem, and more to the point how 
>> many programs get the HZ value with a system call as opposed to 
>> including a header or building it in? I know some of my older 
>> programs use header files, that was part of the planning for the 
>> future even before 2.5 started. At the time I didn't expect to have 
>> to use the system call.
>
>
> in binary 1/100 or 1/1000 are not sane values to start with so I don't 
> think that that this is likly to be that critical (remembering that 
> the kernel doesn't do floating point math) 


The kernel isn't the issue, it's programs which do timing and get values 
in ticks which they convert to time by dividing by HZ. I at least get 
that from a header, proper way would be with the syscall.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

