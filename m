Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751965AbWI3U5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbWI3U5P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWI3U5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:57:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:46542 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751965AbWI3U5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:57:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R5f6lfyLes9Sge9agRmFG1m7I9Y2dCiL2RVD4peChl7LIJo12eWza7sLP0tgjQWNSeGJ4GXF2jisfGKehfy7sfeysuo42MTKNPlDe4uTmCOuPkuABgkKZ8RvUWfeAMaT8eMW20D6Ts2dzSh5l7wUx51EWsx9GakR17iUG6vFAT4=
Message-ID: <5f3c152b0609301357x530a18e0ibdc0d71cc2755921@mail.gmail.com>
Date: Sat, 30 Sep 2006 22:57:12 +0200
From: "Eric Rannaud" <eric.rannaud@gmail.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       mingo@elte.hu, akpm@osdl.org, nagar@watson.ibm.com,
       "Ravikiran G Thirumalai" <kiran@scalex86.org>
In-Reply-To: <1159645755.13651.54.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
	 <1159645755.13651.54.camel@lappy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm1/broken-out/slab-fix-lockdep-warnings.patch
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm1/broken-out/slab-fix-lockdep-warnings-fix.patch
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm1/broken-out/slab-fix-lockdep-warnings-fix-2.patch
>
> Those should rid you off the trace seen under:
>
> > ---- console for (1) without numa=noacpi
> > Sep 30 15:54:06 liw64 kernel:


Somehow, it doesn't freeze anymore, althought the BUG is still there
with more or less the same stacktrace.

er.

---- (v2.6.18 with the 3 patches, w/o numa=noacpi)
[  209.281596] BUG: warning at
kernel/lockdep.c:565/print_infinite_recursion_bug()
[  209.281667]
[  209.281668] Call Trace:
[  209.281862]  [<ffffffff8020b22d>] show_trace+0xad/0x3b0
[  209.281921]  [<ffffffff8020b775>] dump_stack+0x15/0x20
[  209.281981]  [<ffffffff8024ba6d>] print_infinite_recursion_bug+0x3d/0x50
[  209.282098]  [<ffffffff8024bb7f>] find_usage_backwards+0x2f/0xd0
[  209.282212]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.282326]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.282439]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.282567]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.282695]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.282822]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.282949]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.283076]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.283203]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.283330]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.283457]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.283584]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.283711]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.283838]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.283965]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.284092]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.284220]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.284353]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.284398] powernow-k8: Found 16 Dual Core AMD Opteron(tm)
Processor 880 processors (version 2.00.00)
[  209.284442] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.284479] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.284516] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.284558] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.284599] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.284638] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.284682] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.284720] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.284767] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.284891] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.284932] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.284972] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.285014] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.285051] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.285454]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.285581]  [<ffffffff8024bbe3>] find_usage_backwards+0x93/0xd0
[  209.285709]  [<ffffffff8024c590>] check_usage+0x40/0x2b0
[  209.285836]  [<ffffffff8024de60>] __lock_acquire+0xa50/0xd20
[  209.285964]  [<ffffffff8024e4bb>] lock_acquire+0x8b/0xc0
[  209.286095]  [<ffffffff804ac595>] _spin_lock+0x25/0x40
[  209.286227]  [<ffffffff80227e4b>] double_rq_lock+0x2b/0x50
[  209.286327]  [<ffffffff8022cffa>] rebalance_tick+0x19a/0x340
[  209.286430]  [<ffffffff8022d21f>] scheduler_tick+0x7f/0x390
[  209.286534]  [<ffffffff8023b013>] update_process_times+0x73/0x90
[  209.286648]  [<ffffffff8021639b>] smp_local_timer_interrupt+0x2b/0x60
[  209.286733]  [<ffffffff80216b58>] smp_apic_timer_interrupt+0x58/0x70
[  209.286819]  [<ffffffff8020a76f>] apic_timer_interrupt+0x6b/0x70
[  209.286894]  [<ffffffff804aca80>] _spin_unlock_irq+0x30/0x40
[  209.287024]  [<ffffffff80249d69>] hrtimer_run_queues+0x159/0x180
[  209.287149]  [<ffffffff8023b34a>] run_timer_softirq+0x2a/0x200
[  209.287265]  [<ffffffff80237320>] __do_softirq+0x80/0x110
[  209.287373]  [<ffffffff8020adf8>] call_softirq+0x1c/0x28
[  209.287442]  [<ffffffff8020c57d>] do_softirq+0x3d/0xc0
[  209.287512]  [<ffffffff80236ff7>] irq_exit+0x57/0x60
[  209.287619]  [<ffffffff80216b5d>] smp_apic_timer_interrupt+0x5d/0x70
[  209.287704]  [<ffffffff8020a76f>] apic_timer_interrupt+0x6b/0x70
[  209.287772]  [<ffffffff802086b2>] default_idle+0x42/0x80
[  209.287836]  [<ffffffff8020875a>] cpu_idle+0x6a/0x90
[  209.287903]  [<ffffffff80a4c9ac>] start_secondary+0x4fc/0x510
[  209.288027] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.288134] powernow-k8: MP systems not supported by PSB BIOS structure
[  209.288614] Freeing unused kernel memory: 256k freed
[  209.310446] SCSI subsystem initialized
[  209.314846] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16
00:01:03 EST 2006)
----
