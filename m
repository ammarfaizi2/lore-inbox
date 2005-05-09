Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVEIUjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVEIUjX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 16:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVEIUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 16:39:23 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:40609 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261517AbVEIUjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 16:39:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: [BUG][Resend] 2.6.12-rc3-mm3: Kernel BUG at "mm/slab.c":1219
Date: Mon, 9 May 2005 22:39:37 +0200
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505092239.37834.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this from 2.6.12-rc3-mm3 on a UP AMD64 box (Asus L5D), 100% of the time:

]--snip--[
ACPI: bus type pci registered
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
kmem_cache_create: Early error in slab <NULL>
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "mm/slab.c":1219
invalid operand: 0000 [1]
CPU 0
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.12-rc3-mm3
RIP: 0010:[<ffffffff80179eeb>] <ffffffff80179eeb>{kmem_cache_create+139}
RSP: 0000:ffff810001ca1eb8  EFLAGS: 00010292
RAX: 0000000000000034 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000dd3 RDI: ffffffff804167e0
RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000008 R12: 0000000000042000
R13: 0000000000000000 R14: 0000ffffffff8010 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff8055a840(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000004000 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff810001ca0000, task ffff810001c5a7a0)
Stack: fffffffffffffff8 0000000000000000 0000000000000000 0000000000000000
       0000000000000010 0000000000000000 0000000000000005 0000000000000006
       00000000ffffffff 0000ffffffff8010
Call Trace:<ffffffff8057a11d>{init_bio+93} <ffffffff8010c0f2>{init+178}
       <ffffffff8010fc37>{child_rip+8} <ffffffff8010c040>{init+0}
       <ffffffff8010fc2f>{child_rip+0}


Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
