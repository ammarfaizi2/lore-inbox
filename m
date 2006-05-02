Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWEBNU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWEBNU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWEBNU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:20:56 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:56583 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S964807AbWEBNUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:20:55 -0400
Message-ID: <44575CA1.1090009@shadowen.org>
Date: Tue, 02 May 2006 14:20:33 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "Martin J. Bligh" <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com> <20060428012022.7b73c77b.akpm@osdl.org> <44561A1E.7000103@google.com> <200605012034.26763.ak@suse.de>
In-Reply-To: <200605012034.26763.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 01 May 2006 16:24, Martin J. Bligh wrote:
> 
> 
>>double fault: 0000 [1] SMP
>>last sysfs file: /devices/pci0000:00/0000:00:06.0/resource
>>CPU 0
>>Modules linked in:
>>Pid: 20519, comm: mtest01 Not tainted 2.6.17-rc3-mm1-autokern1 #1
>>RIP: 0010:[<ffffffff8047c8b8>] <ffffffff8047c8b8>{__sched_text_start+1856}
>>RSP: 0000:0000000000000000  EFLAGS: 00010082
>>RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff805d9438
>>RDX: ffff8100db12c0d0 RSI: ffffffff805d9438 RDI: ffff8100db12c0d0
>>RBP: ffffffff805d9438 R08: 0000000000000000 R09: 0000000000000000
>>R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>R13: ffff8100e39bd440 R14: ffff810008003620 R15: 000002b02751726c
>>FS:  0000000000000000(0000) GS:ffffffff805fa000(0063) knlGS:00000000f7dd0460
>>CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
>>CR2: fffffffffffffff8 CR3: 00000000da399000 CR4: 00000000000006e0
>>Process mtest01 (pid: 20519, threadinfo ffff8100b1bb4000, task 
>>ffff8100db12c0d0)
>>Stack: ffffffff80579e20 ffff8100db12c0d0 0000000000000001 ffffffff80579f58
>>        0000000000000000 ffffffff80579e78 ffffffff8020b0b2 ffffffff80579f58
>>        0000000000000000 ffffffff80485520
>>Call Trace: <#DF> <ffffffff8020b0b2>{show_registers+140}
>>        <ffffffff8020b357>{__die+159} <ffffffff8020b3cc>{die+50}
>>        <ffffffff8020bba6>{do_double_fault+115} 
>><ffffffff8020aa91>{double_fault+125}
>>        <ffffffff8047c8b8>{__sched_text_start+1856} <EOE>
> 
> 
> That's really strange - i wonder why the backtracer can't find the original
> stack. Should probably add some printk diagnosis here.
> 
> Can you send the output with this patch?

Submitted, they should show up in teh matrix forthwith.  Will drop you
the output when done.

-apw
