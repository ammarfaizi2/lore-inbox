Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267655AbRGPSdL>; Mon, 16 Jul 2001 14:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267628AbRGPSdC>; Mon, 16 Jul 2001 14:33:02 -0400
Received: from kermit.one-2-one.net ([217.115.142.66]:6929 "EHLO
	kermit.one-2-one.net") by vger.kernel.org with ESMTP
	id <S267623AbRGPScp>; Mon, 16 Jul 2001 14:32:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dominik Sacher <sacher@dvoid.org>
To: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel paging request at virtual address
Date: Mon, 16 Jul 2001 20:27:21 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01071620272102.02650@jukebox.juke.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi !
i not a kernel hacker, so i don't know, whom to write to.
maybe you can help !
i get several application-crashs on my redhat7.1 (updated to kernel 2.4.3-12) 
and every crash produces some kind of this:

----------------------------------------------------------------------------
Jul 16 20:04:35 jukebox kernel:  <1>Unable to handle kernel paging request at 
virtual address 41648370
Jul 16 20:04:35 jukebox kernel:  printing eip:
Jul 16 20:04:35 jukebox kernel: c013f6bc
Jul 16 20:04:35 jukebox kernel: pgd entry c8dd6414: 0000000000000000
Jul 16 20:04:35 jukebox kernel: pmd entry c8dd6414: 0000000000000000
Jul 16 20:04:35 jukebox kernel: ... pmd not present!
Jul 16 20:04:35 jukebox kernel: Oops: 0000
Jul 16 20:04:35 jukebox kernel: CPU:    0
Jul 16 20:04:35 jukebox kernel: EIP:    0010:[d_lookup+96/260]
Jul 16 20:04:35 jukebox kernel: EIP:    0010:[<c013f6bc>]
Jul 16 20:04:35 jukebox kernel: EFLAGS: 00010a87
Jul 16 20:04:35 jukebox kernel: eax: c1640000   ebx: 41648328   ecx: 0000000f 
  edx: 134b8ec9
Jul 16 20:04:35 jukebox kernel: esi: 134b8ec9   edi: c6c99f84   ebp: 41648340 
  esp: c6c99eb4
Jul 16 20:04:35 jukebox kernel: ds: 0018   es: 0018   ss: 0018
Jul 16 20:04:35 jukebox kernel: Process gkrellm (pid: 6233, 
stackpage=c6c99000)
Jul 16 20:04:35 jukebox kernel: Stack: c1648340 c43e000a 134b8ec9 00000005 
c6c99f18 134b8ec9 c6c99f84 c43e000f 
Jul 16 20:04:35 jukebox kernel:        c01377f6 ca020f60 c6c99f18 c6c99f18 
c0137eb7 ca020f60 c6c99f18 00000000 
Jul 16 20:04:35 jukebox kernel:        c6c99f04 c6c99f04 00000001 00000000 
00000000 c33df7e0 000009f7 000001f4 
Jul 16 20:04:35 jukebox kernel: Call Trace: [cached_lookup+14/72] 
[path_walk+1275/1880] [open_namei+145/1456] [filp_open+50/80] [getname+92/
152] 
Jul 16 20:04:35 jukebox kernel: Call Trace: [<c01377f6>] [<c0137eb7>] 
[<c01385c1>] [<c012dd72>] [<c0137608>] 
Jul 16 20:04:35 jukebox kernel:    [sys_open+49/148] [system_call+51/56] 
Jul 16 20:04:35 jukebox kernel:    [<c012e029>] [<c0106c1f>] 
Jul 16 20:04:35 jukebox kernel: 
Jul 16 20:04:35 jukebox kernel: Code: 39 53 48 8b 6d 00 0f 85 80 00 00 00 8b 
44 24 24 39 43 0c 75 
----------------------------------------------------------------------------

i even can compile me a new kernel (2.4.6 / 2.2.19), because everytime i try, 
i get this bug and the "make" process dies.
maybe someone can give a hint.

thanks a lot !
d.sacher

