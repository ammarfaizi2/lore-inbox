Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312444AbSCUSla>; Thu, 21 Mar 2002 13:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312445AbSCUSlV>; Thu, 21 Mar 2002 13:41:21 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:44586 "EHLO
	tsmtp7.mail.isp") by vger.kernel.org with ESMTP id <S312444AbSCUSlK>;
	Thu, 21 Mar 2002 13:41:10 -0500
Date: Thu, 21 Mar 2002 19:40:34 +0100
From: Diego Calleja <DiegoCG@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.19-pre3-ac3
Message-Id: <20020321194034.52acb5e0.DiegoCG@teleline.es>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two oops in 2.4.19-pre3-ac3 kernel

I was running gnome, and I started the gnome-db frontend. Then the panel dissapeared, here are the logs:

A _very_ strange thing was that i tried t reboot after this. When the swap partition had to be switched off, the init script didn't
make any progress (debian woody). I had to do  sysrq+s & sysrq+b to reboot.


ksymoops 2.4.3 on i686 2.4.19-pre3-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre3-ac3/ (default)
     -m /boot/System.map-2.4.19-pre3-ac3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Mar 21 16:13:56 localhost kernel: Unable to handle kernel paging request at virtual address 36d7f432
Mar 21 16:13:57 localhost kernel: c0122340
Mar 21 16:13:57 localhost kernel: *pde = 00000000
Mar 21 16:13:57 localhost kernel: Oops: 0000
Mar 21 16:13:57 localhost kernel: CPU:    0
Mar 21 16:13:57 localhost kernel: EIP:    0010:[add_page_to_hash_queue+0/40]    Not tainted
Mar 21 16:13:57 localhost kernel: EFLAGS: 00210206
Mar 21 16:13:57 localhost kernel: eax: c101c15c   ebx: c101c15c   ecx: c1056e70   edx: c10f64e8
Mar 21 16:13:57 localhost kernel: esi: c101c15c   edi: c10dab14   ebp: 00010c52   esp: c0989c80
Mar 21 16:13:57 localhost kernel: ds: 0018   es: 0018   ss: 0018
Mar 21 16:13:57 localhost kernel: Process panel (pid: 3719, stackpage=c0989000)
Mar 21 16:13:57 localhost kernel: Stack: c0123137 00000006 00001000 00001606 00010c52 c10f64e8 c013306b c10dab14
Mar 21 16:13:58 localhost kernel:        00010c52 000000f0 00000006 c10bf120 c013329f c10bf120 00010c52 00001000
Mar 21 16:13:58 localhost kernel:        00001606 00001000 00010c52 c10d8800 00010c52 c013141d 00001606 00010c52
Mar 21 16:13:58 localhost kernel: Call Trace: [find_or_create_page+163/208] [grow_dev_page+35/164] [grow_buffers+199/272] 
Mar 21 16:13:59 localhost kernel: Code: c0 89 c2 85 d2 75 bf a1 e0 36 21 c0 d1 e8 39 c3 76 05 e8 09
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   c0 89 c2 85 d2 75 bf      rorb   $0xbf,0x75d285c2(%ecx)
Code;  00000006 Before first symbol
   7:   a1 e0 36 21 c0            mov    0xc02136e0,%eax
Code;  0000000c Before first symbol
   c:   d1 e8                     shr    %eax
Code;  0000000e Before first symbol
   e:   39 c3                     cmp    %eax,%ebx
Code;  00000010 Before first symbol
  10:   76 05                     jbe    17 <_EIP+0x17> 00000016 Before first symbol
Code;  00000012 Before first symbol
  12:   e8 09 00 00 00            call   20 <_EIP+0x20> 00000020 Before first symbol


2 warnings issued.  Results may not be reliable.
ksymoops 2.4.3 on i686 2.4.19-pre3-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre3-ac3/ (default)
     -m /boot/System.map-2.4.19-pre3-ac3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Mar 21 16:13:59 localhost kernel:  <1>Unable to handle kernel paging request at virtual address 203a676e
Mar 21 16:13:59 localhost kernel: c0115eb7
Mar 21 16:13:59 localhost kernel: Oops: 0000
Mar 21 16:13:59 localhost kernel: CPU:    0
Mar 21 16:13:59 localhost kernel: EIP:    0010:[put_files_struct+11/180]    Not tainted
Mar 21 16:13:59 localhost kernel: EFLAGS: 00210286
Mar 21 16:13:59 localhost kernel: eax: 203a676e   ebx: c1f916e0   ecx: c098825c   edx: c098825c
Mar 21 16:13:59 localhost kernel: esi: c0988294   edi: 203a676e   ebp: c0e50a80   esp: c0989b64
Mar 21 16:13:59 localhost kernel: ds: 0018   es: 0018   ss: 0018
Mar 21 16:13:59 localhost kernel: Process panel (pid: 3719, stackpage=c0989000)
Mar 21 16:13:59 localhost kernel: Stack: c1f916e0 c0988294 00000006 c0e50a80 c0e50a80 c0116481 203a676e 00000000
Mar 21 16:13:59 localhost kernel:        36d7f432 c1f916fc c010716e 0000000b 00000000 c0110767 c01eb69e c0989c4c
Mar 21 16:13:59 localhost kernel:        00000000 c0988000 00000000 c0110468 00010c52 c156dfbc c0988000 c10d3000
Mar 21 16:13:59 localhost kernel: Call Trace: [do_exit+169/460] [die+82/84] [do_page_fault+767/1071] [do_page_fault+0/1071] 
Mar 21 16:13:59 localhost kernel: Code: ff 0f 0f 94 c0 84 c0 0f 84 96 00 00 00 8b 57 14 31 ed 31 f6
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff 0f                     decl   (%edi)
Code;  00000002 Before first symbol
   2:   0f 94 c0                  sete   %al
Code;  00000004 Before first symbol
   5:   84 c0                     test   %al,%al
Code;  00000006 Before first symbol
   7:   0f 84 96 00 00 00         je     a3 <_EIP+0xa3> 000000a2 Before first symbol
Code;  0000000c Before first symbol
   d:   8b 57 14                  mov    0x14(%edi),%edx
Code;  00000010 Before first symbol
  10:   31 ed                     xor    %ebp,%ebp
Code;  00000012 Before first symbol
  12:   31 f6                     xor    %esi,%esi


2 warnings issued.  Results may not be reliable.
