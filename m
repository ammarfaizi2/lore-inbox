Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135246AbRD3OA5>; Mon, 30 Apr 2001 10:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135243AbRD3OAs>; Mon, 30 Apr 2001 10:00:48 -0400
Received: from ehopper-host33.dsl.visi.com ([208.42.65.33]:52867 "HELO
	omnifarious.mn.org") by vger.kernel.org with SMTP
	id <S135249AbRD3OAh> convert rfc822-to-8bit; Mon, 30 Apr 2001 10:00:37 -0400
Date: Mon, 30 Apr 2001 09:00:35 -0500
From: "Eric M. Hopper" <eric-kernel@omnifarious.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 bug report, non-member post
Message-ID: <20010430090035.A5070@omnifarious.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using a brand-new 2.4.4 kernel without devfs.  If you need to know
some option I turned off or on while compiling, email me and I'll tell
you.  I did use 'kgcc' (egcs-2.91.66) from RH 7.0.

I mounted an MSDOS floppy image using the 'vfat' filesystem through the
loopback device, and every program which tried to access files on this
filesystem was promptly killed, and this message appear in the kernel
logs:

----
Apr 29 17:01:58 monster kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Apr 29 17:01:58 monster kernel:  printing eip:
Apr 29 17:01:58 monster kernel: 00000000
Apr 29 17:01:58 monster kernel: *pde = 00000000
Apr 29 17:01:58 monster kernel: Oops: 0000
Apr 29 17:01:58 monster kernel: CPU:    0
Apr 29 17:01:58 monster kernel: EIP:    0010:[agp_frontend_cleanup+0/-1072693248]
Apr 29 17:01:58 monster kernel: EFLAGS: 00010286
Apr 29 17:01:58 monster kernel: eax: 00000000   ebx: d3336c40   ecx: 00010000   edx: d3336c60
Apr 29 17:01:58 monster kernel: esi: 080af768   edi: 00010000   ebp: bffff5f0   esp: c5265f84
Apr 29 17:01:58 monster kernel: ds: 0018   es: 0018   ss: 0018
Apr 29 17:01:58 monster kernel: Process vi (pid: 8746, stackpage=c5265000)
Apr 29 17:01:58 monster kernel: Stack: e5a65a2d d3336c40 080af768 00010000 d3336c60 ffffffea d3336c40 c012ed6e 
Apr 29 17:01:58 monster kernel:        d3336c40 080af768 00010000 d3336c60 c5264000 00010000 080af768 c0106ce7 
Apr 29 17:01:58 monster kernel:        00000003 080af768 00010000 00010000 080af768 bffff5f0 00000003 0000002b 
Apr 29 17:01:58 monster kernel: Call Trace: [<e5a65a2d>] [sys_read+142/208] [system_call+51/56] 
Apr 29 17:01:58 monster kernel: 
Apr 29 17:01:58 monster kernel: Code:  Bad EIP value.
----

On an unrelated note.  After installing the 2.4.4 kernel, I'm getting
weird process hangs whenever I try to su from 'root' to anybody else.
If I run strace on 'su' when I do this, it works fine.  When su hangs, I
kill it, and it tells me it's killing the child shell process, then,
after a few seconds, comes back to my prompt.  It's like the child shell
process isn't being allowed to use the pty or something.

These two problems have me spooked, and I'm moving back to 2.4.3 soon.
If anybody has suggestions, or requests for info, please email me.

Thanks,
-- 
The best we can hope for concerning the people at large is that they
be properly armed.  -- Alexander Hamilton
-- Eric Hopper (eric-kernel@omnifarious.org  http://www.omnifarious.org/~hopper) --
