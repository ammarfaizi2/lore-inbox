Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031046AbWKUQYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031046AbWKUQYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 11:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031049AbWKUQYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 11:24:33 -0500
Received: from gateway-1237.mvista.com ([63.81.120.155]:56545 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1031046AbWKUQYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 11:24:33 -0500
Message-ID: <4563289A.2000702@ru.mvista.com>
Date: Tue, 21 Nov 2006 19:26:02 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       ltt-dev@shafik.org, mgreer@mvista.com, mlachwani@mvista.com
Subject: Re: LTTng do_page_fault vs handle_mm_fault instrumentation
References: <20061121160629.GA6944@Krystal>
In-Reply-To: <20061121160629.GA6944@Krystal>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Mathieu Desnoyers wrote:

> I would like to discuss your suggestion of moving the do_page_fault
> instrumentation to handle_mm_fault. On one side, it helps removing architecture
> dependant instrumentation, but on the other hand :

> 1- We cannot access the struct pt_regs in all cases (there may be an invalid
>    current task struct).
> 2- We cannot distinguish between calls to handle_mm_fault from the page fault
>    handler or from get_user_pages.
> 3- Some people complain about not having enough information about the cause of
>    the page fault (see the forward below).
> 
> So instead of staying between my users who ask for those feature and kernel
> developers who wish to reduce the intrusiveness of instrumentation (which is a
> nice goal : moving the syscall entry/exit instrumentation do do_syscall_trace
> has helped simplifying the instrumentation), I prefer to open the discussion
> about it.

    It seems I've missed the whole story behind this move.
    For me, it was more a question of consistency: if we're trying to trace 
all trap handlers, why not page fault one? So, I just wanted my old LTT 
tracepoints back. :-)

> Ideas/comments are welcome.

> Regards,

> Mathieu

WBR, Sergei
