Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbTA0Jl6>; Mon, 27 Jan 2003 04:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbTA0Jl6>; Mon, 27 Jan 2003 04:41:58 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:30479 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S266971AbTA0Jl4>; Mon, 27 Jan 2003 04:41:56 -0500
Message-ID: <3E35012D.69A90F93@aitel.hist.no>
Date: Mon, 27 Jan 2003 10:51:41 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.59-mm6
References: <20030126231015.6ad982e4.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
>   Which _looks_ like a request queueing problem, but Andres says it goes
>   away when devfs is disabled in config.  So I've dropped the smalldevfs
>   patch for now - would be appreciated if devfs users could retest this
>   patch, with CONFIG_DEVFS=y.

mm6 works where mm5 failed. You are probably right suspecting devfs,
I have devfs enabled although I don't actually use it.  No problems
with RAID1 either.

I enabled hangcheck timer, and gets this now and then:

Warning! Detected 2106 micro-second gap between interrupts.
  Compensating for 1 lost ticks.
Call Trace:
 [<c010a6ad>] handle_IRQ_event+0x29/0x4c
 [<c010a881>] do_IRQ+0xbd/0x138
 [<c0106cc0>] default_idle+0x0/0x28
 [<c0106cc0>] default_idle+0x0/0x28
 [<c01093e0>] common_interrupt+0x18/0x20
 [<c0106cc0>] default_idle+0x0/0x28
 [<c0106cc0>] default_idle+0x0/0x28
 [<c0106ce3>] default_idle+0x23/0x28
 [<c0106d63>] cpu_idle+0x37/0x48
 [<c0105000>] rest_init+0x0/0x50
 [<c010504d>] rest_init+0x4d/0x50

Warning! Detected 2043 micro-second gap between interrupts.
  Compensating for 1 lost ticks.
Call Trace:
 [<c010a6ad>] handle_IRQ_event+0x29/0x4c
 [<c010a881>] do_IRQ+0xbd/0x138
 [<c0106cc0>] default_idle+0x0/0x28
 [<c0106cc0>] default_idle+0x0/0x28
 [<c01093e0>] common_interrupt+0x18/0x20
 [<c0106cc0>] default_idle+0x0/0x28
 [<c0106cc0>] default_idle+0x0/0x28
 [<c0106ce3>] default_idle+0x23/0x28
 [<c0106d63>] cpu_idle+0x37/0x48
 [<c0105000>] rest_init+0x0/0x50
 [<c010504d>] rest_init+0x4d/0x50


Helge Hafting
