Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbTJVJAO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 05:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTJVJAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 05:00:14 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:54159 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263170AbTJVJAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 05:00:08 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 22 Oct 2003 11:13:00 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: test8 oops (ipv6 related?)
Message-ID: <20031022091300.GA27824@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is what I got on the serial console:

Unable to handle kernel paging request at 000000ff00388090 RIP:
<ffffffff801a0042>{__memcpy+114}PML4 0
Oops: 0000 [1]
CPU 0
Pid: 0, comm: swapper Not tainted
RIP: 0010:[<ffffffff801a0042>] <ffffffff801a0042>{__memcpy+114}
RSP: 0018:ffffffff80388038  EFLAGS: 00010246
RAX: 000001001c526da8 RBX: ffffffff80388098 RCX: 0000000000000000
RDX: 0000000000000008 RSI: 000000ff00388090 RDI: 000001001c526da8
RBP: 0000000000000001 R08: 753ee006a6923b09 R09: 000000000018584c
R10: 000000003f964523 R11: 0000000000000000 R12: 0000000000000002
R13: 000001001c526d90 R14: 000001001c526d40 R15: 0000010000000000
FS:  00000000005424a0(0000) GS:ffffffff80384180(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 000000ff00388090 CR3: 0000000000101000 CR4: 00000000000006a0
Process swapper (pid: 0, stackpage=ffffffff802c3e20)
Stack: ffffffff80388098 ffffffff8019b50f 0000000000000061 000001001d2c7e00
       ffffffff803880c8 000001001d2c7ec4 0000000000000000 ffffffff8038bf28
       0000000000000000 ffffffffa0121df0
Call Trace:<IRQ> <ffffffff8019b50f>{update+111} <ffffffffa0121df0>{:ipv6:__ipv6_regen_rndid+336}
       <ffffffff8012eab0>{recalc_task_prio+432} <ffffffffa0121f23>{:ipv6:ipv6_regen_rndid+67}
       <ffffffff8013a3f8>{run_timer_softirq+344} <ffffffff80116d59>{timer_interrupt+473}
       <ffffffff8013659b>{do_softirq+123} <ffffffff80113e41>{do_IRQ+257}
       <ffffffff8010f760>{default_idle+0} <ffffffff80111b99>{ret_from_intr+0}
        <EOI> <ffffffff8010f780>{default_idle+32} <ffffffff8010f80a>{cpu_idle+26}
       <ffffffff8038f6f2>{start_kernel+386}

Code: 4c 8b 06 4c 89 07 48 8d 7f 08 48 8d 76 08 75 ee 89 d1 83 e1
RIP <ffffffff801a0042>{__memcpy+114} RSP <ffffffff80388038>
CR2: 000000ff00388090
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Any idea?

  Gerd

