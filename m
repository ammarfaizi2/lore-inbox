Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVJNGVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVJNGVu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 02:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVJNGVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 02:21:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32174 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932153AbVJNGVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 02:21:49 -0400
Date: Fri, 14 Oct 2005 08:22:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc4-rt1
Message-ID: <20051014062212.GA30874@elte.hu>
References: <20051011111454.GA15504@elte.hu> <1129135337.21743.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129135337.21743.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Badari Pulavarty <pbadari@gmail.com> wrote:

> Hi Ingo,
> 
> 
> I am getting similar segfault on boot problem on 2.6.14-rc4-rt1 on my 
> x86-64 box (with LATENCY_TRACE).

> INIT: version 2.86 booting
> hotplug[877]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp
> 00007fffff8bee68 error 15

what does the ffffffff8010f588 RIP address map to? You can find out by 
building the kernel via DEBUG_INFO, then doing 'gdb vmlinux' and 'list 
*0xffffffff8010f588'. NOTE: the RIP might change in a DEBUG_INFO 
compile, so you'll need to reboot.

Another method is to disassemble the vmlinux via 'objdump -d vmlinux > 
vmlinux.asm', and to search for that RIP value in an editor - could you 
send me the surrounding assembly code? (~20 lines are enough)

	Ingo
