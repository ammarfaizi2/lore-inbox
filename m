Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWGGWYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWGGWYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWGGWYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:24:50 -0400
Received: from horus.tecnoera.com ([200.24.235.2]:47747 "EHLO
	horus.tecnoera.com") by vger.kernel.org with ESMTP id S932353AbWGGWYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:24:49 -0400
Subject: BUG: soft lockup detected
From: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 07 Jul 2006 18:24:41 -0400
Message-Id: <1152311081.22174.151.camel@blackbird.tecnoera.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am getting this error.. although the system works well. I don't know
if I should ignore this error or what. Please advice me what to do:

Ending clean XFS mount for filesystem: loop0
BUG: soft lockup detected on CPU#0!

Call Trace: <IRQ> <ffffffff8024afa3>{softlockup_tick+210}
       <ffffffff802324a8>{update_process_times+66}
<ffffffff802144b4>{smp_local_timer_interrupt+35}
       <ffffffff80214519>{smp_apic_timer_interrupt+65}
<ffffffff8020a354>{apic_timer_interrupt+132} <EOI>
       <ffffffff880a1cdb>{:serpent:serpent_encrypt+1695}
<ffffffff802ef402>{cbc_process_encrypt+91}
       <ffffffff880a163c>{:serpent:serpent_encrypt+0}
<ffffffff802ef01f>{xor_128+0}
       <ffffffff802ef1a2>{crypt+364} <ffffffff802228c7>{try_to_wake_up
+955}
       <ffffffff802ef39a>{crypt_iv_unaligned+138}
<ffffffff802ef6d1>{cbc_encrypt_iv+64}
       <ffffffff880a163c>{:serpent:serpent_encrypt+0}
<ffffffff802ef3a7>{cbc_process_encrypt+0}
       <ffffffff8809d291>{:cryptoloop:cryptoloop_transfer_cbc+222}
       <ffffffff8027561c>{blkdev_get_block+30}
<ffffffff802ef691>{cbc_encrypt_iv+0}
       <ffffffff8809727f>{:loop:do_lo_send_aops+303}
<ffffffff88097904>{:loop:loop_thread+609}
       <ffffffff88097150>{:loop:do_lo_send_aops+0}
<ffffffff804243b7>{_spin_unlock_irq+7}
       <ffffffff8020a6aa>{child_rip+8}
<ffffffff880976a3>{:loop:loop_thread+0}
       <ffffffff8020a6a2>{child_rip+0}


This is a Dual Opteron Dual-core, using cryptoloop to encrypt a device,
using serpent, and XFS. 2.6.17.3 #1 SMP.

Thank you.

