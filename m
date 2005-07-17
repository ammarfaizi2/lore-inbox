Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVGQUEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVGQUEl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 16:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVGQUEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 16:04:41 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:35543 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261366AbVGQUEk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 16:04:40 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: rt-preempt and x86_64?
Date: Sun, 17 Jul 2005 21:04:40 +0100
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <200507171346.11377.s0348365@sms.ed.ac.uk> <42DA8779.3020005@stud.feec.vutbr.cz>
In-Reply-To: <42DA8779.3020005@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507172104.40073.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 Jul 2005 17:29, Michal Schmidt wrote:
> Alistair John Strachan wrote:
> > Hi Ingo,
> >
> > (I searched the list for rt realtime x86_64 x86-64 before posting this,
> > so I hope it's not a duplicate).
> >
> > I've noticed -31 compiles without notable error or warning on x86-64, so
> > I thought maybe it was a valid time to file a bug report about it not
> > working.
> >
> > The machine currently runs 2.6.12 but when booting with PREEMPT_RT mode
> > on the same machine I get:
> >
> > init[1]: segfault at ffffffff8010e9c4 rip ffffffff8010e9c4 rsp
> > 00007fffffe28018
> > [...]
>
> Do you have latency tracing enabled in the kernel config? Try disabling
> it. It's a known problem that it doesn't work on x86_64.
>

Thanks Michal, this was the problem. Unless x86_64 is going to receive an 
implementation of LATENCY_TRACE soon, it might be an idea to only let this be 
selectable on x86.

(Unfortunately I couldn't use the resulting kernel anyway, as my lirc modules 
hang the system when modprobe'd; it's probably easy even for me to fix if I 
inspect Ingo's rt-preempt patch.)

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
