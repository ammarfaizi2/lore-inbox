Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129526AbRBACUy>; Wed, 31 Jan 2001 21:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbRBACUn>; Wed, 31 Jan 2001 21:20:43 -0500
Received: from heron.tripnet.se ([195.100.19.3]:54600 "HELO heron.tripnet.se")
	by vger.kernel.org with SMTP id <S129314AbRBACU3>;
	Wed, 31 Jan 2001 21:20:29 -0500
Message-ID: <3A78C840.4F2C7CD0@tripnet.se>
Date: Thu, 01 Feb 2001 03:21:52 +0100
From: Magnus Walldal <rannug@tripnet.se>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG in 2.4.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I was playing around with Gnome when I got this Kernel BUG in my syslog.

Kernel is 2.4.0 running on updated RedHat 7. My box is a Pentium III
(440BX)
with 256 MB RAM.

System just froze, I could not move the mouse or switch virtual console,
after
hitting SysRq repeatedly the system finally shutdown.


Feb  1 00:22:05 osho kernel: kernel BUG at page_alloc.c:72!
Feb  1 00:22:05 osho kernel: invalid operand: 0000
Feb  1 00:22:05 osho kernel: CPU:    0
Feb  1 00:22:05 osho kernel: EIP:    0010:[__free_pages_ok+35/784]
Feb  1 00:22:05 osho kernel: EFLAGS: 00013282
Feb  1 00:22:05 osho kernel: eax: 0000001f   ebx: c133c6c0   ecx:
00000002   edx: 00000000
Feb  1 00:22:05 osho kernel: esi: cc2ec000   edi: 00000000   ebp:
cc2ee4a0   esp: ca907e68
Feb  1 00:22:05 osho kernel: ds: 0018   es: 0018   ss: 0018
Feb  1 00:22:05 osho kernel: Process X (pid: 1035, stackpage=ca907000)
Feb  1 00:22:05 osho kernel: Stack: c01e5f45 c01e60d3 00000048 c0223378
00003203 fffffffc cc2ec000 cc2ec000
Feb  1 00:22:05 osho kernel:        cc2ed000 cc2ec000 00000000 cf178240
c012d5ce ca907ea8 cf178344 00000001
Feb  1 00:22:05 osho kernel:        00000000 cf178240 cfffa49c cf178240
c31d4f60 c012d657 cf178240 cf178240
Feb  1 00:22:05 osho kernel: Call Trace: [shmem_truncate+222/304]
[shmem_delete_inode+55/80] [iput+165/336] [dput+237/320] [fput+113/208]
[unmap_fixup+86/304] [do_munmap+550/672]
Feb  1 00:22:05 osho gnome-name-server[1085]: input condition is: 0x11,
exiting
Feb  1 00:22:05 osho kernel:        [sys_shmdt+93/128] [sys_ipc+454/512]
[system_call+51/56]
Feb  1 00:22:05 osho kernel:
Feb  1 00:22:05 osho kernel: Code: 0f 0b 83 c4 0c 8b 73 08 85 f6 74 16
6a 4a 68 d3 60 1e c0 68

Output from ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux osho 2.4.0 #1 Fri Jan 5 03:46:57 CET 2001 i686 unknown
Kernel modules         2.3.21
Gnu C                  2.96
Gnu Make               3.79.1
Binutils               2.10.0.18
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         sr_mod ide-cd cdrom eepro100 agpgart au8830
soundcore aic7xxx ncr53c8xx


Let me know if I can be of further assistance, please mail me directly
since I'm not subscibed to lmkl!

Regards,
Magnus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
