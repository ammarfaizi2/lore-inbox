Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261981AbTC1DMA>; Thu, 27 Mar 2003 22:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261997AbTC1DMA>; Thu, 27 Mar 2003 22:12:00 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:41470
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261981AbTC1DL6>; Thu, 27 Mar 2003 22:11:58 -0500
Date: Thu, 27 Mar 2003 22:19:33 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: task_struct slab cache use after free in 2.5.66
Message-ID: <Pine.LNX.4.50.0303272211180.2884-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a few stability problems with 2.5.66 under test loads. I 
can't quite parse the slab debugging stuff. Is this actually useful to 
anyone?

Slab corruption: start=c1f23380, expend=c1f2399f, problemat=c1f23388
Data: ********6A 
******************************************************************************************************* 
Next: ********************************
slab error in check_poison_obj(): cache `task_struct': object was modified after freeing
Call Trace:
 [<c0142953>] check_poison_obj+0x123/0x170
 [<c0144337>] kmem_cache_alloc+0x117/0x160
 [<c011fdde>] dup_task_struct+0x9e/0xc0
 [<c011fdde>] dup_task_struct+0x9e/0xc0
 [<c0120b82>] copy_process+0x82/0xe30
 [<c0126d3b>] do_softirq+0xbb/0xc0
 [<c012196f>] do_fork+0x3f/0x170
 [<c01077b7>] sys_fork+0x17/0x30
 [<c0109497>] syscall_call+0x7/0xb


-- 
function.linuxpower.ca
