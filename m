Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUARQ1z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 11:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbUARQ1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 11:27:55 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:21416 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261928AbUARQ1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 11:27:50 -0500
Date: Sun, 18 Jan 2004 08:27:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: pather@comhem.se
Subject: [Bug 1906] New: VNC server crash randomly 
Message-ID: <1215470000.1074443263@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1906

           Summary: VNC server crash randomly
    Kernel Version: 2.6.1 vanilla source
            Status: NEW
          Severity: normal
             Owner: other_other@kernel-bugs.osdl.org
         Submitter: pather@comhem.se


Distribution: Slackware 9.1
Hardware Environment: 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP 1700+
stepping        : 2
cpu MHz         : 1467.420

Software Environment:
Linux Athlon 2.6.1 #1 Fri Jan 16 17:57:42 CET 2004 i686 unknown unknown 
GNU/Linux
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.14
e2fsprogs              1.34
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 2.0.16
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         uhci_hcd ohci_hcd ehci_hcd snd_cmipci snd_opl3_lib 
snd_hwdep snd_mpu401_uart snd_rawmidi

Problem Description:
Jan 18 15:35:37 Athlon kernel: ------------[ cut here ]------------
Jan 18 15:35:37 Athlon kernel: kernel BUG at mm/vmscan.c:615!
Jan 18 15:35:37 Athlon kernel: invalid operand: 0000 [#7]
Jan 18 15:35:37 Athlon kernel: CPU:    0
Jan 18 15:35:37 Athlon kernel: EIP:    0060:[<c013e102>]    Not tainted
Jan 18 15:35:37 Athlon kernel: EFLAGS: 00010046
Jan 18 15:35:37 Athlon kernel: EIP is at refill_inactive_zone+0x92/0x520
Jan 18 15:35:37 Athlon kernel: eax: 00000000   ebx: c034ba44   ecx: c12702d0   
edx: c034ba44
Jan 18 15:35:37 Athlon kernel: esi: c12702b8   edi: 00000000   ebp: c0721d00   
esp: c0721c60
Jan 18 15:35:37 Athlon kernel: ds: 007b   es: 007b   ss: 0068
Jan 18 15:35:37 Athlon kernel: Process ld (pid: 1851, threadinfo=c0720000 
task=c07238c0)
Jan 18 15:35:37 Athlon kernel: Stack: c0997080 00000001 00000aa8 c034ba44 
00000000 00000000 00000000 00000001 
Jan 18 15:35:37 Athlon kernel:        00000000 00000034 00000000 c0721c8c 
c0721c8c c0721c94 c0721c94 c0721c9c 
Jan 18 15:35:37 Athlon kernel:        c0721c9c c0b03aa8 c0997080 00000000 
c39a16c0 c39a16e0 c07238c0 c0721d6c 
Jan 18 15:35:37 Athlon kernel: Call Trace:
Jan 18 15:35:37 Athlon kernel:  [<c011578d>] do_page_fault+0x35d/0x579
Jan 18 15:35:37 Athlon kernel:  [<c018a060>] ext3_readpages+0x0/0x30
Jan 18 15:35:37 Athlon kernel:  [<c0139ca3>] read_pages+0x123/0x130
Jan 18 15:35:37 Athlon kernel:  [<c013e62f>] shrink_zone+0x9f/0xb0
Jan 18 15:35:37 Athlon kernel:  [<c013e6dd>] shrink_caches+0x9d/0xc0
Jan 18 15:35:37 Athlon kernel:  [<c013e7ad>] try_to_free_pages+0xad/0x180
Jan 18 15:35:37 Athlon kernel:  [<c0137f0a>] __alloc_pages+0x1fa/0x350
Jan 18 15:35:37 Athlon kernel:  [<c013ccc6>] __pagevec_lru_add_active+0xf6/0x120
Jan 18 15:35:37 Athlon kernel:  [<c01416ad>] do_anonymous_page+0x7d/0x1f0
Jan 18 15:35:37 Athlon kernel:  [<c014187a>] do_no_page+0x5a/0x310
Jan 18 15:35:37 Athlon kernel:  [<c0141d12>] handle_mm_fault+0xe2/0x180
Jan 18 15:35:37 Athlon kernel:  [<c011578d>] do_page_fault+0x35d/0x579
Jan 18 15:35:37 Athlon kernel:  [<c014422c>] do_brk+0x14c/0x220
Jan 18 15:35:37 Athlon kernel:  [<c0142a10>] sys_brk+0xf0/0x120
Jan 18 15:35:37 Athlon kernel:  [<c0115430>] do_page_fault+0x0/0x579
Jan 18 15:35:37 Athlon kernel:  [<c0109505>] error_code+0x2d/0x38
Jan 18 15:35:37 Athlon kernel: 
Jan 18 15:35:37 Athlon kernel: Code: 0f 0b 67 02 56 e1 30 c0 8b 01 8b 51 04 89 
50 04 89 02 c7 41 
Jan 18 15:35:37 Athlon kernel:  <6>note: ld[1851] exited with preempt_count 1
Jan 18 15:35:37 Athlon kernel: Debug: sleeping function called from invalid 
context at include/linux/rwsem.h:43
Jan 18 15:35:37 Athlon kernel: in_atomic():1, irqs_disabled():0
Jan 18 15:35:37 Athlon kernel: Call Trace:
Jan 18 15:35:37 Athlon kernel:  [<c011896b>] __might_sleep+0xab/0xd0
Jan 18 15:35:37 Athlon kernel:  [<c011d0cf>] do_exit+0xaf/0x430
Jan 18 15:35:37 Athlon kernel:  [<c0109ee0>] do_invalid_op+0x0/0xc0
Jan 18 15:35:37 Athlon kernel:  [<c0109ba1>] die+0xe1/0xf0
Jan 18 15:35:37 Athlon kernel:  [<c0109f93>] do_invalid_op+0xb3/0xc0
Jan 18 15:35:37 Athlon kernel:  [<c013e102>] refill_inactive_zone+0x92/0x520
Jan 18 15:35:37 Athlon kernel:  [<c0137e7a>] __alloc_pages+0x16a/0x350
Jan 18 15:35:37 Athlon kernel:  [<c0226372>] generic_make_request+0x112/0x1a0
Jan 18 15:35:37 Athlon kernel:  [<c0109505>] error_code+0x2d/0x38
Jan 18 15:35:37 Athlon kernel:  [<c013e102>] refill_inactive_zone+0x92/0x520
Jan 18 15:35:37 Athlon kernel:  [<c011578d>] do_page_fault+0x35d/0x579
Jan 18 15:35:37 Athlon kernel:  [<c018a060>] ext3_readpages+0x0/0x30
Jan 18 15:35:37 Athlon kernel:  [<c0139ca3>] read_pages+0x123/0x130
Jan 18 15:35:37 Athlon kernel:  [<c013e62f>] shrink_zone+0x9f/0xb0
Jan 18 15:35:37 Athlon kernel:  [<c013e6dd>] shrink_caches+0x9d/0xc0
Jan 18 15:35:37 Athlon kernel:  [<c013e7ad>] try_to_free_pages+0xad/0x180
Jan 18 15:35:37 Athlon kernel:  [<c0137f0a>] __alloc_pages+0x1fa/0x350
Jan 18 15:35:37 Athlon kernel:  [<c013ccc6>] __pagevec_lru_add_active+0xf6/0x120
Jan 18 15:35:37 Athlon kernel:  [<c01416ad>] do_anony

Steps to reproduce:
Run VNC server v 3.3.7 and connect a client. Do something, in this case I tried 
to compile some sources, running VNC client on a remote computer.


