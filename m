Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUCHVdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUCHVca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:32:30 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:2688 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261312AbUCHVb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:31:57 -0500
Date: Mon, 8 Mar 2004 22:31:55 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.25 oops
Message-ID: <20040308213155.GA423@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.25 oopsed after 13 days of uptime.  The machine hasn't
had problems running older 2.4 kernels so far.

The setup is an elderly P2/350, two Adaptec AIC-2940 Ultra
controllers, md raid1, reiserfs 3.6.

-- 
Tomas Szepe <szepe@pinerecords.com>

ksymoops 2.4.9 on i686 2.4.25.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.25/ (default)
     -m /boot/System.map (specified)

Mar  8 22:14:05 ls kernel: Unable to handle kernel paging request at virtual address 9db0d889
Mar  8 22:14:05 ls kernel: c01336f8
Mar  8 22:14:05 ls kernel: *pde = 00000000
Mar  8 22:14:05 ls kernel: Oops: 0002
Mar  8 22:14:05 ls kernel: CPU:    0
Mar  8 22:14:05 ls kernel: EIP:    0010:[<c01336f8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar  8 22:14:05 ls kernel: EFLAGS: 00010282
Mar  8 22:14:05 ls kernel: eax: cb4eb000   ebx: 00005410   ecx: 000000ff   edx: 9db0d875
Mar  8 22:14:05 ls kernel: esi: fffffff7   edi: bffffab4   ebp: bffffaa8   esp: cc675fa4
Mar  8 22:14:05 ls kernel: ds: 0018   es: 0018   ss: 0018
Mar  8 22:14:05 ls kernel: Process bash (pid: 14960, stackpage=cc675000)
Mar  8 22:14:05 ls kernel: Stack: c013efb9 cc674000 bffffad0 00003a70 bffffaa8 00390000 00000000 c0106b43 
Mar  8 22:14:05 ls kernel:        000000ff 00005410 bffffab4 bffffad0 00003a70 bffffaa8 00000036 0000002b 
Mar  8 22:14:05 ls kernel:        0000002b 00000036 400f6244 00000023 00000206 bffffa88 0000002b 
Mar  8 22:14:05 ls kernel: Call Trace:    [<c013efb9>] [<c0106b43>]
Mar  8 22:14:05 ls kernel: Code: ff 42 14 89 d0 c3 89 f6 8b 4c 24 04 ff 49 14 0f 94 c0 84 c0 

>>EIP; c01336f8 <fget+20/28>   <=====

>>eax; cb4eb000 <_end+b21ec68/10628cc8>
>>esp; cc675fa4 <_end+c3a9c0c/10628cc8>

Trace; c013efb9 <sys_ioctl+1d/234>
Trace; c0106b43 <system_call+33/38>

Code;  c01336f8 <fget+20/28>
00000000 <_EIP>:
Code;  c01336f8 <fget+20/28>   <=====
   0:   ff 42 14                  incl   0x14(%edx)   <=====
Code;  c01336fb <fget+23/28>
   3:   89 d0                     mov    %edx,%eax
Code;  c01336fd <fget+25/28>
   5:   c3                        ret    
Code;  c01336fe <fget+26/28>
   6:   89 f6                     mov    %esi,%esi
Code;  c0133700 <put_filp+0/44>
   8:   8b 4c 24 04               mov    0x4(%esp,1),%ecx
Code;  c0133704 <put_filp+4/44>
   c:   ff 49 14                  decl   0x14(%ecx)
Code;  c0133707 <put_filp+7/44>
   f:   0f 94 c0                  sete   %al
Code;  c013370a <put_filp+a/44>
  12:   84 c0                     test   %al,%al

Mar  8 22:14:05 ls kernel:  <1>Unable to handle kernel paging request at virtual address 9db0d889
Mar  8 22:14:05 ls kernel: c013269b
Mar  8 22:14:05 ls kernel: *pde = 00000000
Mar  8 22:14:05 ls kernel: Oops: 0000
Mar  8 22:14:05 ls kernel: CPU:    0
Mar  8 22:14:05 ls kernel: EIP:    0010:[<c013269b>]    Not tainted
Mar  8 22:14:05 ls kernel: EFLAGS: 00010282
Mar  8 22:14:05 ls kernel: eax: cb4eb000   ebx: 9db0d875   ecx: 00000000   edx: 9db0d875
Mar  8 22:14:05 ls kernel: esi: 000000ff   edi: cc51aaa0   ebp: 00000008   esp: cc675e64
Mar  8 22:14:05 ls kernel: ds: 0018   es: 0018   ss: 0018
Mar  8 22:14:05 ls kernel: Process bash (pid: 14960, stackpage=cc675000)
Mar  8 22:14:05 ls kernel: Stack: 00000001 000000ff cc51aaa0 c0118ab8 9db0d875 cc51aaa0 cbc54340 cc675f70 
Mar  8 22:14:05 ls kernel:        cc674000 0000000b cc51abbc c0119057 cc51aaa0 00000002 cc675f70 c6833ea0 
Mar  8 22:14:05 ls kernel:        9db0d889 c0107106 0000000b 00000000 000224ee c01133f7 c020f7be cc675f70 
Mar  8 22:14:05 ls kernel: Call Trace:    [<c0118ab8>] [<c0119057>] [<c0107106>] [<c01133f7>] [<c0113084>]
Mar  8 22:14:05 ls kernel:   [<c01131e4>] [<c0113084>] [<c0106c34>] [<c01336f8>] [<c013efb9>] [<c0106b43>]
Mar  8 22:14:05 ls kernel: Code: 8b 43 14 85 c0 75 11 68 00 1d 21 c0 e8 6c 42 fe ff 31 c0 83 

>>EIP; c013269b <filp_close+b/60>   <=====

>>eax; cb4eb000 <_end+b21ec68/10628cc8>
>>edi; cc51aaa0 <_end+c24e708/10628cc8>
>>esp; cc675e64 <_end+c3a9acc/10628cc8>

Trace; c0118ab8 <put_files_struct+54/bc>
Trace; c0119057 <do_exit+af/240>
Trace; c0107106 <die+56/58>
Trace; c01133f7 <do_page_fault+373/4a0>
Trace; c0113084 <do_page_fault+0/4a0>
Trace; c01131e4 <do_page_fault+160/4a0>
Trace; c0113084 <do_page_fault+0/4a0>
Trace; c0106c34 <error_code+34/3c>
Trace; c01336f8 <fget+20/28>
Trace; c013efb9 <sys_ioctl+1d/234>
Trace; c0106b43 <system_call+33/38>

Code;  c013269b <filp_close+b/60>
00000000 <_EIP>:
Code;  c013269b <filp_close+b/60>   <=====
   0:   8b 43 14                  mov    0x14(%ebx),%eax   <=====
Code;  c013269e <filp_close+e/60>
   3:   85 c0                     test   %eax,%eax
Code;  c01326a0 <filp_close+10/60>
   5:   75 11                     jne    18 <_EIP+0x18>
Code;  c01326a2 <filp_close+12/60>
   7:   68 00 1d 21 c0            push   $0xc0211d00
Code;  c01326a7 <filp_close+17/60>
   c:   e8 6c 42 fe ff            call   fffe427d <_EIP+0xfffe427d>
Code;  c01326ac <filp_close+1c/60>
  11:   31 c0                     xor    %eax,%eax
Code;  c01326ae <filp_close+1e/60>
  13:   83 00 00                  addl   $0x0,(%eax)
