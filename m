Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267763AbUHJVzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267763AbUHJVzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267764AbUHJVzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:55:42 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52151 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267763AbUHJVzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:55:39 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040810132654.GA28915@elte.hu>
References: <1090795742.719.4.camel@mindpipe>
	 <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu>  <20040810132654.GA28915@elte.hu>
Content-Type: text/plain
Message-Id: <1092174959.5061.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 17:56:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 09:26, Ingo Molnar wrote:
> i've uploaded the latest version of the voluntary-preempt patch:
>     
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc3-O5
> 
> -O5 fixes the APIC lockup issues. The bug was primarily caused by PCI
> POST delays causing IRQ storms of level-triggered IRQ sources that were
> hardirq-redirected. Also found some bugs in delayed-IRQ masking and
> unmasking. SMP should thus work again too.
> 

The mlockall() issue seems to be fixed.  Now I get this one when
starting jackd:

(jackd/12427): 10882us non-preemptible critical section violated 400 us preempt threshold starting at kernel_fpu_begin+0x10/0x60 and ending at fast_clear_page+0x75/0xa0
 [<c0106777>] dump_stack+0x17/0x20
 [<c01140eb>] sub_preempt_count+0x4b/0x60
 [<c01d1585>] fast_clear_page+0x75/0xa0
 [<c013ea86>] do_anonymous_page+0x86/0x180
 [<c013ebd0>] do_no_page+0x50/0x300
 [<c013f041>] handle_mm_fault+0xc1/0x170
 [<c013da33>] get_user_pages+0x133/0x3d0
 [<c013f198>] make_pages_present+0x68/0x90
 [<c0140948>] do_mmap_pgoff+0x3f8/0x640
 [<c010b7f6>] sys_mmap2+0x76/0xb0
 [<c0106117>] syscall_call+0x7/0xb

Lee

