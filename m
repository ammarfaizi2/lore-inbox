Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263410AbTDCOpJ>; Thu, 3 Apr 2003 09:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263411AbTDCOpJ>; Thu, 3 Apr 2003 09:45:09 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:61828 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S263410AbTDCOpI>;
	Thu, 3 Apr 2003 09:45:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16012.19359.948383.217572@enequist.it.uu.se>
Date: Thu, 3 Apr 2003 16:56:31 +0200
From: mikpe@csd.uu.se
To: ak@suse.de
CC: linux-kernel@vger.kernel.org
Subject: 2.5.66 x86_64 oops when swapoff via IA32 emulation
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this oops from swapoff when shutting down 2.5.66 on
x86_64 with 32-bit user-space (RH8.0). This was from the first
run with 2.5.66, I wasn't able to reproduce it in later runs.

/Mikael

Kernel BUG at page_alloc:687
invalid operand: 0000 [#1]
CPU 0 
Pid: 364, comm: swapoff Not tainted
RIP: 0010:[<ffffffff80143c64>] <ffffffff80143c64>{__free_pages+20}
RSP: 0000:000001000f4a5f30  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000019 RCX: 0000000000101000
RDX: 0000000000000018 RSI: 0000000000000000 RDI: 0000010001074952
RBP: 000001000fea2bc0 R08: 000000000000fbff R09: 00000000ffffdb68
R10: 000001000f4a4000 R11: 0000000000000000 R12: 0000000000000001
R13: 000001000f62f280 R14: 0000010004360cc0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff802cd5c0(0000) knlGS:00000000a0047080
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000420d40b0 CR3: 0000000000101000 CR4: 00000000000006a0
Process swapoff (pid: 364, stackpage=10001605100)
Stack: ffffffff801531d9 ffffff0000000000 ffffffff802a18a0 0000000000000000 
       ffffffff80155627 000000000804b328 00000000ffffdb68 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff801531d9>{__vunmap+169} <ffffffff80155627>{sys_swapoff+631} 
       <ffffffff801179fe>{ia32_do_syscall+30} 

Code: 0f 0b ab f3 23 80 ff ff ff ff af 02 ff 4f 08 0f 94 c0 84 c0 
