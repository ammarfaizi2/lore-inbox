Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbUDBOms (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 09:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUDBOms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 09:42:48 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:7901 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264057AbUDBOmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 09:42:46 -0500
Date: Fri, 2 Apr 2004 11:42:38 -0300
From: Flavio Bruno Leitner <fbl@conectiva.com.br>
To: Andrew Morton <akpm@osdl.org>
Cc: dwcraig@qualcomm.com, list@noduck.net, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/timer.c:370!
Message-ID: <20040402144238.GB2068@conectiva.com.br>
References: <0320111483D8B84AAAB437215BBDA526847F70@NAEX01.na.qualcomm.com> <20040401142458.GB2132@conectiva.com.br> <20040401172401.GD2132@conectiva.com.br> <20040401103718.5a599055.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040401103718.5a599055.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
X-Bogosity: No, tests=bogofilter, spamicity=0.105097, version=0.16.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 10:37:18AM -0800, Andrew Morton wrote:
> Flavio Bruno Leitner <fbl@conectiva.com.br> wrote:
> >
> > cascade: c03b3128 != c03b28c0           
> >  kernel/timer.c:296: spin_lock(kernel/timer.c:c03b28c0) already locked by kernel/timer.c/401
> >  handler=c03b3120 (0xc03b3120)                                                              
> >  Call Trace:                  
> >   [<c01347ef>] cascade+0x7f/0xb0
> >   [<c0135025>] run_timer_softirq+0x315/0x3f0
> >   [<c012fa35>] do_softirq+0xa5/0xb0         
> >   [<c010caea>] do_IRQ+0x21a/0x360  
> >   [<c012b5bf>] profile_hook+0x1f/0x23
> >   [<c010a934>] common_interrupt+0x18/0x20
> >   [<c0107066>] default_idle+0x26/0x40    
> >   [<c01070f4>] cpu_idle+0x34/0x40    
> >   [<c0434829>] start_kernel+0x189/0x1e0
> >   [<c0434540>] unknown_bootoption+0x0/0x120
> 
> Is the machine SMP?

No, it's a simple Pentium II .

> What was the machine doing at the time?

I were running process like postfix, pump, ntpd. Well, after you do this
question, I tried to reproduce with runlevel 1 (single), but I can't until
now. Next step will be disable one per one service until I can't reproduce 
anymore.


> 
> Can you have a look in System.map, see if you can work out what's at
> 0xc03b3120?

c03b3128 => Not found in System.map
c03b28c0 => per_cpu__tvec_bases
c03b3120 => Not found in System.map


-- 
Flávio Bruno Leitner <fbl@conectiva.com.br>
[ E74B 0BD0 5E05 C385 239E  531C BC17 D670 7FF0 A9E0 ]
