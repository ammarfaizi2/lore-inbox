Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbUDAShx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUDAShx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:37:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:61347 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263034AbUDAShv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:37:51 -0500
Date: Thu, 1 Apr 2004 10:37:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Flavio Bruno Leitner <fbl@conectiva.com.br>
Cc: dwcraig@qualcomm.com, list@noduck.net, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/timer.c:370!
Message-Id: <20040401103718.5a599055.akpm@osdl.org>
In-Reply-To: <20040401172401.GD2132@conectiva.com.br>
References: <0320111483D8B84AAAB437215BBDA526847F70@NAEX01.na.qualcomm.com>
	<20040401142458.GB2132@conectiva.com.br>
	<20040401172401.GD2132@conectiva.com.br>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Flavio Bruno Leitner <fbl@conectiva.com.br> wrote:
>
> cascade: c03b3128 != c03b28c0           
>  kernel/timer.c:296: spin_lock(kernel/timer.c:c03b28c0) already locked by kernel/timer.c/401
>  handler=c03b3120 (0xc03b3120)                                                              
>  Call Trace:                  
>   [<c01347ef>] cascade+0x7f/0xb0
>   [<c0135025>] run_timer_softirq+0x315/0x3f0
>   [<c012fa35>] do_softirq+0xa5/0xb0         
>   [<c010caea>] do_IRQ+0x21a/0x360  
>   [<c012b5bf>] profile_hook+0x1f/0x23
>   [<c010a934>] common_interrupt+0x18/0x20
>   [<c0107066>] default_idle+0x26/0x40    
>   [<c01070f4>] cpu_idle+0x34/0x40    
>   [<c0434829>] start_kernel+0x189/0x1e0
>   [<c0434540>] unknown_bootoption+0x0/0x120

Is the machine SMP?

What was the machine doing at the time?

Can you have a look in System.map, see if you can work out what's at
0xc03b3120?

