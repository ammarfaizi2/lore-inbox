Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUEPMI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUEPMI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 08:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbUEPMI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 08:08:56 -0400
Received: from cicero0.cybercity.dk ([212.242.40.52]:15369 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id S263574AbUEPMIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 08:08:52 -0400
Subject: Kernel OOPS
From: tmp <skrald@amossen.dk>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Ex6q8zuP6xRDKoDMrcHn"
Message-Id: <1084709330.743.8.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 16 May 2004 14:08:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ex6q8zuP6xRDKoDMrcHn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I get the attached oops message in syslog on my 2.6.6 kernel. I have
also attached the ksymoops output.

When the oops has occured, I cannot open any shell (including a login
shell).


--=-Ex6q8zuP6xRDKoDMrcHn
Content-Disposition: attachment; filename=oops1.txt
Content-Type: text/plain; name=oops1.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

May 16 13:29:34 debian kernel: Unable to handle kernel paging request at virtual address 1841b518
May 16 13:29:34 debian kernel:  printing eip:
May 16 13:29:34 debian kernel: c016c02e
May 16 13:29:34 debian kernel: *pde = 00000000
May 16 13:29:34 debian kernel: Oops: 0000 [#1]
May 16 13:29:34 debian kernel: CPU:    0
May 16 13:29:34 debian kernel: EIP:    0060:[proc_get_inode+110/272]    Not tainted
May 16 13:29:34 debian kernel: EFLAGS: 00010202   (2.6.6) 
May 16 13:29:34 debian kernel: EIP is at proc_get_inode+0x6e/0x110
May 16 13:29:34 debian kernel: eax: 00000000   ebx: df107850   ecx: 0114df68   edx: 36013bf9
May 16 13:29:34 debian kernel: esi: dffec810   edi: dffdee00   ebp: 00000007   esp: d5037e30
May 16 13:29:34 debian kernel: ds: 007b   es: 007b   ss: 0068
May 16 13:29:35 debian kernel: Process emacs (pid: 743, threadinfo=d5036000 task=d3ec8030)
May 16 13:29:35 debian kernel: Stack: df107850 f0000000 df7f19c0 e0820ead dffec810 c5bef353 dffec863 c016e8e3 
May 16 13:29:35 debian kernel:        dffdee00 f0000000 dffec810 ffffffea 00000000 dffdddd0 d5037f70 c5bef2d0 
May 16 13:29:35 debian kernel:        c5bef2d0 c016c1d1 dffdddd0 c5bef2d0 d5037f70 fffffff4 dffdde38 dffdddd0 
May 16 13:29:35 debian kernel: Call Trace:
May 16 13:29:35 debian kernel:  [pg0+541367981/1069707264] unix_stream_sendmsg+0x24d/0x3a0 [unix]
May 16 13:29:35 debian kernel:  [proc_lookup+179/192] proc_lookup+0xb3/0xc0
May 16 13:29:35 debian kernel:  [proc_root_lookup+49/128] proc_root_lookup+0x31/0x80
May 16 13:29:35 debian kernel:  [real_lookup+203/240] real_lookup+0xcb/0xf0
May 16 13:29:35 debian kernel:  [do_lookup+150/176] do_lookup+0x96/0xb0
May 16 13:29:35 debian kernel:  [link_path_walk+1052/2048] link_path_walk+0x41c/0x800
May 16 13:29:35 debian kernel:  [path_lookup+105/272] path_lookup+0x69/0x110
May 16 13:29:35 debian kernel:  [open_namei+131/1024] open_namei+0x83/0x400
May 16 13:29:35 debian kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
May 16 13:29:35 debian kernel:  [filp_open+62/112] filp_open+0x3e/0x70
May 16 13:29:35 debian kernel:  [sys_open+91/144] sys_open+0x5b/0x90
May 16 13:29:35 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May 16 13:29:35 debian kernel: 
May 16 13:29:35 debian kernel: Code: 8b 46 18 c7 43 38 00 00 00 00 89 43 34 0f b7 46 0e 66 85 c0 

--=-Ex6q8zuP6xRDKoDMrcHn
Content-Disposition: attachment; filename=ksymoops.txt
Content-Type: text/plain; name=ksymoops.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

ksymoops 2.4.9 on i686 2.6.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.6/ (default)
     -m /boot/System.map-2.6.6 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
May 16 13:29:34 debian kernel: Unable to handle kernel paging request at virtual address 1841b518
May 16 13:29:34 debian kernel: c016c02e
May 16 13:29:34 debian kernel: *pde = 00000000
May 16 13:29:34 debian kernel: Oops: 0000 [#1]
May 16 13:29:34 debian kernel: CPU:    0
May 16 13:29:34 debian kernel: EIP:    0060:[proc_get_inode+110/272]    Not tainted
May 16 13:29:34 debian kernel: EFLAGS: 00010202   (2.6.6) 
May 16 13:29:34 debian kernel: eax: 00000000   ebx: df107850   ecx: 0114df68   edx: 36013bf9
May 16 13:29:34 debian kernel: esi: dffec810   edi: dffdee00   ebp: 00000007   esp: d5037e30
May 16 13:29:34 debian kernel: ds: 007b   es: 007b   ss: 0068
May 16 13:29:35 debian kernel: Stack: df107850 f0000000 df7f19c0 e0820ead dffec810 c5bef353 dffec863 c016e8e3 
May 16 13:29:35 debian kernel:        dffdee00 f0000000 dffec810 ffffffea 00000000 dffdddd0 d5037f70 c5bef2d0 
May 16 13:29:35 debian kernel:        c5bef2d0 c016c1d1 dffdddd0 c5bef2d0 d5037f70 fffffff4 dffdde38 dffdddd0 
May 16 13:29:35 debian kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>ebx; df107850 <pg0+1ed30850/3fc27000>
>>esi; dffec810 <pg0+1fc15810/3fc27000>
>>edi; dffdee00 <pg0+1fc07e00/3fc27000>
>>esp; d5037e30 <pg0+14c60e30/3fc27000>

May 16 13:29:35 debian kernel: Code: 8b 46 18 c7 43 38 00 00 00 00 89 43 34 0f b7 46 0e 66 85 c0 
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 46 18                  mov    0x18(%esi),%eax
Code;  00000003 Before first symbol
   3:   c7 43 38 00 00 00 00      movl   $0x0,0x38(%ebx)
Code;  0000000a Before first symbol
   a:   89 43 34                  mov    %eax,0x34(%ebx)
Code;  0000000d Before first symbol
   d:   0f b7 46 0e               movzwl 0xe(%esi),%eax
Code;  00000011 Before first symbol
  11:   66 85 c0                  test   %ax,%ax


1 warning and 1 error issued.  Results may not be reliable.

--=-Ex6q8zuP6xRDKoDMrcHn--

