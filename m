Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282137AbRK1MS4>; Wed, 28 Nov 2001 07:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282131AbRK1MSr>; Wed, 28 Nov 2001 07:18:47 -0500
Received: from cauchy.eii.us.es ([150.214.141.179]:15244 "HELO
	cauchy.eii.us.es") by vger.kernel.org with SMTP id <S282136AbRK1MSm>;
	Wed, 28 Nov 2001 07:18:42 -0500
Date: Wed, 28 Nov 2001 13:18:14 +0100 (CET)
From: Manuel Cepedello Boiso <manuel@cauchy.eii.us.es>
To: <linux-kernel@vger.kernel.org>
Subject: Oops when mounting a CD.
Message-ID: <Pine.LNX.4.33L2.0111281312080.11318-100000@cauchy.eii.us.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running Linux 2.2.16 (on a ix86 system ) I got this kernel oops when
trying to mount a CD. The device is an IDE ATAPI CD-RW under the ide-scsi
simulation.


Nov 27 23:03:26 cauchy kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000010
Nov 27 23:03:26 cauchy kernel:  printing eip:
Nov 27 23:03:26 cauchy kernel: e0979712
Nov 27 23:03:26 cauchy kernel: *pde = 00000000
Nov 27 23:03:26 cauchy kernel: Oops: 0000
Nov 27 23:03:26 cauchy kernel: CPU:    0
Nov 27 23:03:26 cauchy kernel: EIP:    0010:[<e0979712>]    Tainted: PF
Nov 27 23:03:26 cauchy kernel: EFLAGS: 00010246
Nov 27 23:03:26 cauchy kernel: eax: 00000000   ebx: 00000990   ecx:
deeef780   edx: 00000000
Nov 27 23:03:26 cauchy kernel: esi: d908fe00   edi: d908ff08   ebp:
c27303e0   esp: c8b0fda0
Nov 27 23:03:26 cauchy kernel: ds: 0018   es: 0018   ss: 0018
Nov 27 23:03:26 cauchy kernel: Process mount (pid: 8753,
stackpage=c8b0f000)
Nov 27 23:03:26 cauchy kernel: Stack: 00000800 d908fe00 c2730430 d908ff08
c27303e0 00000000 00000000 e09568ed
Nov 27 23:03:26 cauchy kernel:        d908fe00 00000282 c8b0fe00 c8b0e000
d908fc00 e097c040 de8e25a0 deeef780
Nov 27 23:03:26 cauchy kernel:        00000000 c017d3b4 deeef798 c8b0fe00
c0116054 deeef798 c8b0fe1c d765e6e0
Nov 27 23:03:26 cauchy kernel: Call Trace: [<e09568ed>] [<e097c040>]
[generic_unplug_device+32/40] [__run_task_queue+76/96]
[__wait_on_buffer+90/144]
Nov 27 23:03:26 cauchy kernel:    [bread+81/112] [<e0984ee4>]
[get_sb_bdev+571/732] [<e0989124>] [set_devname+39/84]
[do_kern_mount+175/336]
Nov 27 23:03:26 cauchy kernel:    [<e0989124>] [do_add_mount+33/204]
[do_mount+319/344] [copy_mount_options+77/156] [sys_mount+132/196]
[system_call+51/56]
Nov 27 23:03:26 cauchy kernel:
Nov 27 23:03:26 cauchy kernel: Code: 0f b6 40 10 50 e8 38 1a 00 00 83 c4
08 eb 0d 68 20 b6 97 e0


Manuel Cepedello Boiso
e-mail: manuel@cauchy.eii.us.es

