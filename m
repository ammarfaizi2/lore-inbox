Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbULAWX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbULAWX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbULAWX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:23:27 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:16313 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261428AbULAWXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:23:22 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2-mm4: NUMA-related oops on dual-Opteron
Date: Wed, 1 Dec 2004 23:26:06 +0100
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20041130095045.090de5ea.akpm@osdl.org>
In-Reply-To: <20041130095045.090de5ea.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200412012326.06841.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 of November 2004 18:50, Andrew Morton wrote:
> 
> 
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/
> 
> - Various fixes and cleanups
> 
> - A decent-sized x86_64 update.

It oopses for me at startup on a dual-Opteron box w/ NUMA (Tyan Thunder K8W):

CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0
Unable to handle kernel paging request at ffffffffd595d4ce RIP:
<ffffffff8052ae37>{numa_add_cpu+7}
PML4 103027 PGD 2070b067 PMD 0
Oops: 0000 [1] SMP
CPU 0
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.10-rc2-mm4
RIP: 0010:[<ffffffff8052ae37>] <ffffffff8052ae37>{numa_add_cpu+7}
RSP: 0018:ffffffff8051bf68  EFLAGS: 00010206
RAX: 0000000055554f12 RBX: 0000000000000000 RCX: 0000000000000411
RDX: 0000000000000000 RSI: 0000000000000410 RDI: 0000000055554f12
RBP: 5555555555554f12 R08: 0000000000000000 R09: 0000000000000005
R10: 0000000000000000 R11: 0000000000000010 R12: ffffffff80100150
R13: 00000000ffffffff R14: 0000ffffffff8010 R15: ffffffff8051bfb0
FS:  0000000000000000(0000) GS:ffffffff80514100(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffffd595d4ce CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff8051a000, task ffffffff80401e40)
Stack: ffffffff80521b63 0000000000000881 0000000000000881 ffffffff80401e40
       ffffffff8051c74b ffffffff804c93e0 ffffffff8051c288 0000000000000000
       0000000000090000 80108e0000100150
Call Trace:<ffffffff80521b63>{ide

That's all I could get from the serial console.

The .config is available at:
http://www.sisk.pl/kernel/041201/2.6.10-rc2-mm4-AMD64-NUMA.config

Please let me know if you need more information.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
