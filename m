Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSFOBx5>; Fri, 14 Jun 2002 21:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSFOBx4>; Fri, 14 Jun 2002 21:53:56 -0400
Received: from topbg-gw.peers.Sofia.0rbitel.net ([212.95.178.150]:41234 "HELO
	ns.unixsol.bg") by vger.kernel.org with SMTP id <S314829AbSFOBxy>;
	Fri, 14 Jun 2002 21:53:54 -0400
Message-ID: <3D0A9E32.1060304@unixsol.org>
Date: Sat, 15 Jun 2002 04:53:54 +0300
From: Georgi Chorbadzhiyski <gf@unixsol.org>
Organization: Unix Solutions Ltd. (http://unixsol.org)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.18 oops: truncate_list_pages
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From syslog
Jun 15 02:00:01 player logger: -- MARK --
Jun 15 02:00:17 player kernel: EXT2-fs error (device ide0(3,3)): ext2_new_block: Free blocks count corrupted for block group 335
Jun 15 02:00:50 player kernel: EXT2-fs error (device ide0(3,3)): ext2_new_block: Free blocks count corrupted for block group 335
Jun 15 02:01:23 player kernel: EXT2-fs error (device ide0(3,3)): ext2_new_block: Free blocks count corrupted for block group 335
Jun 15 02:01:56 player kernel: EXT2-fs error (device ide0(3,3)): ext2_new_block: Free blocks count corrupted for block group 335
Jun 15 02:01:56 player kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jun 15 02:01:56 player kernel:  printing eip:
Jun 15 02:01:56 player kernel: 00000000
Jun 15 02:01:56 player kernel: *pde = 00000000
Jun 15 02:01:56 player kernel: Oops: 0000
Jun 15 02:01:56 player kernel: CPU:    0
Jun 15 02:01:56 player kernel: EIP:    0010:[<00000000>]    Not tainted
Jun 15 02:01:56 player kernel: EFLAGS: 00010286
Jun 15 02:01:56 player kernel: eax: 00000000   ebx: c10baec0   ecx: c10baec0   edx: 00000000
Jun 15 02:01:56 player kernel: esi: 00000000   edi: 00000000   ebp: dfc1ea50   esp: c6033edc
Jun 15 02:01:56 player kernel: ds: 0018   es: 0018   ss: 0018
Jun 15 02:01:56 player kernel: Process rsync (pid: 17973, stackpage=c6033000)
Jun 15 02:01:56 player kernel: Stack: c10baec0 c011ff06 c10baec0 00000000 c6033f1c 00000000 dfc1ea50 00000000
Jun 15 02:01:56 player kernel:        00000001 c6033f1c 00000000 c011ffab dfc1e9a0 c1874e00 c0232a00 d662b320
Jun 15 02:01:56 player kernel:        00000000 c013d81c dfc1ea50 00000000 00000000 d662b320 dfc1e9a0 c1807320
Jun 15 02:01:56 player kernel: Call Trace: [<c011ff06>] [<c011ffab>] [<c013d81c>] [<c013b78e>] [<c012cac7>]
Jun 15 02:01:56 player kernel:    [<c012bb5c>] [<c01147a8>] [<c0114d5f>] [<c0114eaa>] [<c0106b1b>]
Jun 15 02:01:56 player kernel:
Jun 15 02:01:56 player kernel: Code:  Bad EIP value.

/proc/version
Linux version 2.4.18 (root@player) (gcc version 2.95.3 20010315 (release)) #1 Sun May 5 06:13:51 EEST 2002


Module                  Size  Used by    Not tainted
stradis                31136   1
videodev                2912   3  [stradis]


ksymoops 2.4.5 on i686 2.4.18.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.18/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jun 15 02:01:56 player kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jun 15 02:01:56 player kernel: 00000000
Jun 15 02:01:56 player kernel: *pde = 00000000
Jun 15 02:01:56 player kernel: Oops: 0000
Jun 15 02:01:56 player kernel: CPU:    0
Jun 15 02:01:56 player kernel: EIP:    0010:[<00000000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 15 02:01:56 player kernel: EFLAGS: 00010286
Jun 15 02:01:56 player kernel: eax: 00000000   ebx: c10baec0   ecx: c10baec0   edx: 00000000
Jun 15 02:01:56 player kernel: esi: 00000000   edi: 00000000   ebp: dfc1ea50   esp: c6033edc
Jun 15 02:01:56 player kernel: ds: 0018   es: 0018   ss: 0018
Jun 15 02:01:56 player kernel: Process rsync (pid: 17973, stackpage=c6033000)
Jun 15 02:01:56 player kernel: Stack: c10baec0 c011ff06 c10baec0 00000000 c6033f1c 00000000 dfc1ea50 00000000
Jun 15 02:01:56 player kernel:        00000001 c6033f1c 00000000 c011ffab dfc1e9a0 c1874e00 c0232a00 d662b320
Jun 15 02:01:56 player kernel:        00000000 c013d81c dfc1ea50 00000000 00000000 d662b320 dfc1e9a0 c1807320
Jun 15 02:01:56 player kernel: Call Trace: [<c011ff06>] [<c011ffab>] [<c013d81c>] [<c013b78e>] [<c012cac7>]
Jun 15 02:01:56 player kernel:    [<c012bb5c>] [<c01147a8>] [<c0114d5f>] [<c0114eaa>] [<c0106b1b>]
Jun 15 02:01:56 player kernel: Code:  Bad EIP value.


 >>EIP; 00000000 Before first symbol

 >>ebx; c10baec0 <_end+e15d04/2057ee44>
 >>ecx; c10baec0 <_end+e15d04/2057ee44>
 >>ebp; dfc1ea50 <_end+1f979894/2057ee44>
 >>esp; c6033edc <_end+5d8ed20/2057ee44>

Trace; c011ff06 <truncate_list_pages+fe/160>
Trace; c011ffab <truncate_inode_pages+43/6c>
Trace; c013d81c <iput+9c/198>
Trace; c013b78e <dput+ce/124>
Trace; c012cac7 <fput+af/d0>
Trace; c012bb5c <filp_close+5c/64>
Trace; c01147a8 <put_files_struct+54/bc>
Trace; c0114d5f <do_exit+a7/1cc>
Trace; c0114eaa <sys_exit+e/10>
Trace; c0106b1b <system_call+33/38>


1 warning issued.  Results may not be reliable.

