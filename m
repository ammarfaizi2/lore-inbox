Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270146AbRHGJLF>; Tue, 7 Aug 2001 05:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270152AbRHGJKr>; Tue, 7 Aug 2001 05:10:47 -0400
Received: from sol.alphadiz.com ([212.35.180.126]:13828 "EHLO sol.alphadiz.com")
	by vger.kernel.org with ESMTP id <S270146AbRHGJKd>;
	Tue, 7 Aug 2001 05:10:33 -0400
Message-Id: <200108070909.MAA01703@sol.alphadiz.com>
Content-Type: text/plain;
  charset="koi8-u"
From: Eugene Onischenko <oneugene@alphadiz.com>
Organization: Alpha Design Webstudio
To: linux-kernel@vger.kernel.org
Subject: kernel 2.2.19 prints Opps message
Date: Tue, 7 Aug 2001 12:09:25 +0300
X-Mailer: KMail [version 1.2.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Linux Kernel 2.2.19 prints oops message.

2. Approximately once a month kernel prints Oops: to console.
Some processes are in state uninterruptible sleep. One thing
I can do is to reboot the computer. Does anyone know what is
wrong?

3. Keywords:
kernel panic, oops message

4. Kernel version (/proc/version):
Linux version 2.2.19 (root@sol.alphadiz.com) (gcc version egcs-2.91.66 
19990314/Linux (egcs-1.1.2 release)) #4 Wed Jul 11 16:18:13 EEST 2001

5. Output of the Oops message (output of ksymoops):
ksymoops 2.4.1 on i686 2.2.19. �Options used
� � �-V (default)
� � �-k /proc/ksyms (default)
� � �-l /proc/modules (default)
� � �-o /lib/modules/2.2.19/ (default)
� � �-m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information. �I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc. �ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not 
found in System.map. �Ignoring ksyms_base entry
156a74>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 
Using defaults from ksymoops -t elf32-i386 -a i386

Code; �00000000 Before first symbol
00000000 <_EIP>:
Code; �00000000 Before first symbol
� �0: � 8b 01 � � � � � � � � � � movl � (%ecx),%eax
Code; �00000002 Before first symbol
� �2: � 89 03 � � � � � � � � � � movl � %eax,(%ebx)
Code; �00000004 Before first symbol
� �4: � 85 c0 � � � � � � � � � � testl �%eax,%eax
Code; �00000006 Before first symbol
� �6: � 74 2b � � � � � � � � � � je � � 33 <_EIP+0x33> 00000033 Before first 
symbol
Code; �00000008 Before first symbol
� �8: � 8b 7b 04 � � � � � � � � �movl � 0x4(%ebx),%edi
Code; �0000000b Before first symbol
� �b: � 85 ff � � � � � � � � � � testl �%edi,%edi
Code; �0000000d Before first symbol
� �d: � 75 10 � � � � � � � � � � jne � �1f <_EIP+0x1f> 0000001f Before first 
symbol
Code; �0000000f Before first symbol
� �f: � 89 19 � � � � � � � � � � movl � %ebx,(%ecx)
Code; �00000011 Before first symbol
� 11: � 89 c8 � � � � � � � � � � movl � %ecx,%eax
Code; �00000013 Before first symbol
� 13: � 2b 00 � � � � � � � � � � subl � (%eax),%eax

Unable to handle kernel paging request at virtual address 41040000
current->tss.cr3 = 06178000, %cr3 = 06178000
*pde = 00000000
Oops: 0000
CPU: � �0
EIP: � �0010:[<c01205ad>]
EFLAGS: 00010002
eax: c37a1fe0 � ebx: c37a1fe0 � ecx: 41040000 � edx: cbc689d0
esi: cffff080 � edi: cc8dd200 � ebp: 00000282 � esp: c604be94
ds: 0018 � es: 0018 � ss: 0018
Process kdeinit (pid: 8013, process nr: 202, stackpage=c604b000)
Stack: cc8dd200 c6fc2b60 c01827b3 0000001e 00000015 c604a000 c6409480 
cc8dd200 
� � � �c6fc2b60 00000015 cbc689d0 c0182d74 cc8dd200 00000001 c0182e24 
cbc689d0 
� � � �cbc689d0 c604bf14 00000015 bffff05c cc8dc440 fffffff4 bfffefec 
c01571eb 
Call Trace: [<c01827b3>] [<c0182d74>] [<c0182e24>] [<c01571eb>] [<c011ac89>] 
[<c011acef>] [<c011add5>] 
� � � �[<c0157b18>] [<c0109135>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 

>>EIP; c01205ad <kmalloc+51/15c> � <=====

Trace; c01827b3 <unix_autobind+17/16c>
Trace; c0182d74 <unix_stream_connect+e0/2a8>
Trace; c0182e24 <unix_stream_connect+190/2a8>
Trace; c01571eb <sys_connect+5b/80>
Trace; c011ac89 <do_no_page+51/c4>
Trace; c011acef <do_no_page+b7/c4>
Trace; c011add5 <handle_mm_fault+d9/154>
Trace; c0157b18 <sys_socketcall+8c/1e0>
Trace; c0109135 <error_code+35/40>
Trace; c010901c <system_call+34/38>
Code; �c01205ad <kmalloc+51/15c>
00000000 <_EIP>:
Code; �c01205ad <kmalloc+51/15c> � <=====
� �0: � 8b 01 � � � � � � � � � � movl � (%ecx),%eax � <=====
Code; �c01205af <kmalloc+53/15c>
� �2: � 89 03 � � � � � � � � � � movl � %eax,(%ebx)
Code; �c01205b1 <kmalloc+55/15c>
� �4: � 85 c0 � � � � � � � � � � testl �%eax,%eax
Code; �c01205b3 <kmalloc+57/15c>
� �6: � 74 2b � � � � � � � � � � je � � 33 <_EIP+0x33> c01205e0 
<kmalloc+84/15c>
Code; �c01205b5 <kmalloc+59/15c>
� �8: � 8b 7b 04 � � � � � � � � �movl � 0x4(%ebx),%edi
Code; �c01205b8 <kmalloc+5c/15c>
� �b: � 85 ff � � � � � � � � � � testl �%edi,%edi
Code; �c01205ba <kmalloc+5e/15c>
� �d: � 75 10 � � � � � � � � � � jne � �1f <_EIP+0x1f> c01205cc 
<kmalloc+70/15c>
Code; �c01205bc <kmalloc+60/15c>
� �f: � 89 19 � � � � � � � � � � movl � %ebx,(%ecx)
Code; �c01205be <kmalloc+62/15c>
� 11: � 89 c8 � � � � � � � � � � movl � %ecx,%eax
Code; �c01205c0 <kmalloc+64/15c>
� 13: � 2b 00 � � � � � � � � � � subl � (%eax),%eax

Unable to handle kernel paging request at virtual address 41040000
current->tss.cr3 = 01002000, %cr3 = 01002000
*pde = 00000000
Oops: 0000
CPU: � �0
EIP: � �0010:[<c01205ad>]
EFLAGS: 00010006
eax: c37a1fe0 � ebx: c37a1fe0 � ecx: 41040000 � edx: 00000018
esi: cffff080 � edi: 00000008 � ebp: 00000282 � esp: cdcc5f5c
ds: 0018 � es: 0018 � ss: 0018
Process kdeinit (pid: 7980, process nr: 71, stackpage=cdcc5000)
Stack: 00000008 0000000c c012e39a 00000018 00000015 cdcc4000 00000000 
00000000 
� � � �bffff9e4 00000008 00000000 00000004 cecfdc60 cdcc4000 00000018 
00000032 
� � � �cdcc4000 cecfdc60 7fffffff 00000009 080633d8 bffff5a8 c0156a74 
00000000 
Call Trace: [<c012e39a>] [<c0156a74>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 

>>EIP; c01205ad <kmalloc+51/15c> � <=====

Trace; c012e39a <sys_select+132/550>
Trace; c0156a74 <sock_write+0/9c>
Trace; c010901c <system_call+34/38>
Code; �c01205ad <kmalloc+51/15c>
00000000 <_EIP>:
Code; �c01205ad <kmalloc+51/15c> � <=====
� �0: � 8b 01 � � � � � � � � � � movl � (%ecx),%eax � <=====
Code; �c01205af <kmalloc+53/15c>
� �2: � 89 03 � � � � � � � � � � movl � %eax,(%ebx)
Code; �c01205b1 <kmalloc+55/15c>
� �4: � 85 c0 � � � � � � � � � � testl �%eax,%eax
Code; �c01205b3 <kmalloc+57/15c>
� �6: � 74 2b � � � � � � � � � � je � � 33 <_EIP+0x33> c01205e0 
<kmalloc+84/15c>
Code; �c01205b5 <kmalloc+59/15c>
� �8: � 8b 7b 04 � � � � � � � � �movl � 0x4(%ebx),%edi
Code; �c01205b8 <kmalloc+5c/15c>
� �b: � 85 ff � � � � � � � � � � testl �%edi,%edi
Code; �c01205ba <kmalloc+5e/15c>
� �d: � 75 10 � � � � � � � � � � jne � �1f <_EIP+0x1f> c01205cc 
<kmalloc+70/15c>
Code; �c01205bc <kmalloc+60/15c>
� �f: � 89 19 � � � � � � � � � � movl � %ebx,(%ecx)
Code; �c01205be <kmalloc+62/15c>
� 11: � 89 c8 � � � � � � � � � � movl � %ecx,%eax
Code; �c01205c0 <kmalloc+64/15c>
� 13: � 2b 00 � � � � � � � � � � subl � (%eax),%eax

Unable to handle kernel paging request at virtual address 41040000
current->tss.cr3 = 06932000, %cr3 = 06932000
*pde = 00000000
Oops: 0000
CPU: � �0
EIP: � �0010:[<c01205ad>]
EFLAGS: 00010002
eax: c37a1fe0 � ebx: c37a1fe0 � ecx: 41040000 � edx: 00000018
esi: cffff080 � edi: 00000008 � ebp: 00000282 � esp: c6465f5c
ds: 0018 � es: 0018 � ss: 0018
Process kdeinit (pid: 8345, process nr: 59, stackpage=c6465000)
Stack: 00000008 0000000c c012e39a 00000018 00000015 c6464000 00000000 
00000000 
� � � �bffff478 00000008 00000000 00000004 00000001 00000000 00000018 
00000025 
� � � �c6464000 c59d0060 7fffffff c0124b79 c59d0060 c6464000 00000000 
0805ff10 
Call Trace: [<c012e39a>] [<c0124b79>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 

>>EIP; c01205ad <kmalloc+51/15c> � <=====

Trace; c012e39a <sys_select+132/550>
Trace; c0124b79 <sys_read+b9/c4>
Trace; c010901c <system_call+34/38>
Code; �c01205ad <kmalloc+51/15c>
00000000 <_EIP>:
Code; �c01205ad <kmalloc+51/15c> � <=====
� �0: � 8b 01 � � � � � � � � � � movl � (%ecx),%eax � <=====
Code; �c01205af <kmalloc+53/15c>
� �2: � 89 03 � � � � � � � � � � movl � %eax,(%ebx)
Code; �c01205b1 <kmalloc+55/15c>
� �4: � 85 c0 � � � � � � � � � � testl �%eax,%eax
Code; �c01205b3 <kmalloc+57/15c>
� �6: � 74 2b � � � � � � � � � � je � � 33 <_EIP+0x33> c01205e0 
<kmalloc+84/15c>
Code; �c01205b5 <kmalloc+59/15c>
� �8: � 8b 7b 04 � � � � � � � � �movl � 0x4(%ebx),%edi
Code; �c01205b8 <kmalloc+5c/15c>
� �b: � 85 ff � � � � � � � � � � testl �%edi,%edi
Code; �c01205ba <kmalloc+5e/15c>
� �d: � 75 10 � � � � � � � � � � jne � �1f <_EIP+0x1f> c01205cc 
<kmalloc+70/15c>
Code; �c01205bc <kmalloc+60/15c>
� �f: � 89 19 � � � � � � � � � � movl � %ebx,(%ecx)
Code; �c01205be <kmalloc+62/15c>
� 11: � 89 c8 � � � � � � � � � � movl � %ecx,%eax
Code; �c01205c0 <kmalloc+64/15c>
� 13: � 2b 00 � � � � � � � � � � subl � (%eax),%eax

Unable to handle kernel paging request at virtual address 41040000
current->tss.cr3 = 0dce7000, %cr3 = 0dce7000
*pde = 00000000
Oops: 0000
CPU: � �0
EIP: � �0010:[<c01205ad>]
EFLAGS: 00010002
eax: c37a1fe0 � ebx: c37a1fe0 � ecx: 41040000 � edx: ffffffe0
esi: cffff080 � edi: 00000015 � ebp: 00000282 � esp: ca5e5e80
ds: 0018 � es: 0018 � ss: 0018
Process kdeinit (pid: 8314, process nr: 48, stackpage=ca5e5000)
Stack: 00000015 00000040 c0158d79 00000014 00000015 c3b1e700 00000000 
ca5e4000 
� � � �c0158523 0000000c 00000015 c3b1e700 c0158797 c3b1e700 0000000c 
00000000 
� � � �00000015 ca5e5f08 0000000c c0183558 ca5e5f0c ca5e4000 c0183642 
c3b1e700 
Call Trace: [<c0158d79>] [<c0158523>] [<c0158797>] [<c0183558>] [<c0183642>] 
[<c0183558>] [<c01568f8>] 
� � � �[<c0183558>] [<c0156b06>] [<c0124c69>] [<c0156a74>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 

>>EIP; c01205ad <kmalloc+51/15c> � <=====

Trace; c0158d79 <alloc_skb+71/dc>
Trace; c0158523 <sock_wmalloc+23/50>
Trace; c0158797 <sock_alloc_send_skb+63/a8>
Trace; c0183558 <unix_stream_sendmsg+0/260>
Trace; c0183642 <unix_stream_sendmsg+ea/260>
Trace; c0183558 <unix_stream_sendmsg+0/260>
Trace; c01568f8 <sock_sendmsg+88/ac>
Trace; c0183558 <unix_stream_sendmsg+0/260>
Trace; c0156b06 <sock_write+92/9c>
Trace; c0124c69 <sys_write+e5/118>
Trace; c0156a74 <sock_write+0/9c>
Trace; c010901c <system_call+34/38>
Code; �c01205ad <kmalloc+51/15c>
00000000 <_EIP>:
Code; �c01205ad <kmalloc+51/15c> � <=====
� �0: � 8b 01 � � � � � � � � � � movl � (%ecx),%eax � <=====
Code; �c01205af <kmalloc+53/15c>
� �2: � 89 03 � � � � � � � � � � movl � %eax,(%ebx)
Code; �c01205b1 <kmalloc+55/15c>
� �4: � 85 c0 � � � � � � � � � � testl �%eax,%eax
Code; �c01205b3 <kmalloc+57/15c>
� �6: � 74 2b � � � � � � � � � � je � � 33 <_EIP+0x33> c01205e0 
<kmalloc+84/15c>
Code; �c01205b5 <kmalloc+59/15c>
� �8: � 8b 7b 04 � � � � � � � � �movl � 0x4(%ebx),%edi
Code; �c01205b8 <kmalloc+5c/15c>
� �b: � 85 ff � � � � � � � � � � testl �%edi,%edi
Code; �c01205ba <kmalloc+5e/15c>
� �d: � 75 10 � � � � � � � � � � jne � �1f <_EIP+0x1f> c01205cc 
<kmalloc+70/15c>
Code; �c01205bc <kmalloc+60/15c>
� �f: � 89 19 � � � � � � � � � � movl � %ebx,(%ecx)
Code; �c01205be <kmalloc+62/15c>
� 11: � 89 c8 � � � � � � � � � � movl � %ecx,%eax
Code; �c01205c0 <kmalloc+64/15c>
� 13: � 2b 00 � � � � � � � � � � subl � (%eax),%eax

Unable to handle kernel paging request at virtual address 41040000
current->tss.cr3 = 08277000, %cr3 = 08277000
*pde = 00000000
Oops: 0000
CPU: � �0
EIP: � �0010:[<c01205ad>]
EFLAGS: 00010006
eax: c37a1fe0 � ebx: c37a1fe0 � ecx: 41040000 � edx: 00000018
esi: cffff080 � edi: 00000008 � ebp: 00000282 � esp: cf453f5c
ds: 0018 � es: 0018 � ss: 0018
Process kdeinit (pid: 8388, process nr: 86, stackpage=cf453000)
Stack: 00000008 0000000c c012e39a 00000018 00000015 cf452000 00000000 
00000000 
� � � �bffff9e4 00000008 00000000 00000004 c4e618a0 cf452000 00000018 
0000002f 
� � � �cf452000 c4e618a0 7fffffff 0000000c 080627c8 bffff5a8 c0156a74 
00000000 
Call Trace: [<c012e39a>] [<c0156a74>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 

>>EIP; c01205ad <kmalloc+51/15c> � <=====

Trace; c012e39a <sys_select+132/550>
Trace; c0156a74 <sock_write+0/9c>
Trace; c010901c <system_call+34/38>
Code; �c01205ad <kmalloc+51/15c>
00000000 <_EIP>:
Code; �c01205ad <kmalloc+51/15c> � <=====
� �0: � 8b 01 � � � � � � � � � � movl � (%ecx),%eax � <=====
Code; �c01205af <kmalloc+53/15c>
� �2: � 89 03 � � � � � � � � � � movl � %eax,(%ebx)
Code; �c01205b1 <kmalloc+55/15c>
� �4: � 85 c0 � � � � � � � � � � testl �%eax,%eax
Code; �c01205b3 <kmalloc+57/15c>
� �6: � 74 2b � � � � � � � � � � je � � 33 <_EIP+0x33> c01205e0 
<kmalloc+84/15c>
Code; �c01205b5 <kmalloc+59/15c>
� �8: � 8b 7b 04 � � � � � � � � �movl � 0x4(%ebx),%edi
Code; �c01205b8 <kmalloc+5c/15c>
� �b: � 85 ff � � � � � � � � � � testl �%edi,%edi
Code; �c01205ba <kmalloc+5e/15c>
� �d: � 75 10 � � � � � � � � � � jne � �1f <_EIP+0x1f> c01205cc 
<kmalloc+70/15c>
Code; �c01205bc <kmalloc+60/15c>
� �f: � 89 19 � � � � � � � � � � movl � %ebx,(%ecx)
Code; �c01205be <kmalloc+62/15c>
� 11: � 89 c8 � � � � � � � � � � movl � %ecx,%eax
Code; �c01205c0 <kmalloc+64/15c>
� 13: � 2b 00 � � � � � � � � � � subl � (%eax),%eax

Unable to handle kernel paging request at virtual address 41040000
current->tss.cr3 = 00da9000, %cr3 = 00da9000
*pde = 00000000
Oops: 0000
CPU: � �0
EIP: � �0010:[<c01205ad>]
EFLAGS: 00010006
eax: c37a1fe0 � ebx: c37a1fe0 � ecx: 41040000 � edx: 00000018
esi: cffff080 � edi: 00000008 � ebp: 00000282 � esp: cca3bf5c
ds: 0018 � es: 0018 � ss: 0018
Process kdeinit (pid: 8737, process nr: 17, stackpage=cca3b000)
Stack: 00000008 0000000c c012e39a 00000018 00000015 cca3a000 00000000 
00000000 
� � � �bffff9e4 00000008 00000000 00000004 cba26660 cca3a000 00000018 
0000002b 
� � � �cca3a000 cba26660 7fffffff 0000000e 0805f160 bffff5a8 c0156a74 
00000000 
Call Trace: [<c012e39a>] [<c0156a74>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 

>>EIP; c01205ad <kmalloc+51/15c> � <=====

Trace; c012e39a <sys_select+132/550>
Trace; c0156a74 <sock_write+0/9c>
Trace; c010901c <system_call+34/38>
Code; �c01205ad <kmalloc+51/15c>
00000000 <_EIP>:
Code; �c01205ad <kmalloc+51/15c> � <=====
� �0: � 8b 01 � � � � � � � � � � movl � (%ecx),%eax � <=====
Code; �c01205af <kmalloc+53/15c>
� �2: � 89 03 � � � � � � � � � � movl � %eax,(%ebx)
Code; �c01205b1 <kmalloc+55/15c>
� �4: � 85 c0 � � � � � � � � � � testl �%eax,%eax
Code; �c01205b3 <kmalloc+57/15c>
� �6: � 74 2b � � � � � � � � � � je � � 33 <_EIP+0x33> c01205e0 
<kmalloc+84/15c>
Code; �c01205b5 <kmalloc+59/15c>
� �8: � 8b 7b 04 � � � � � � � � �movl � 0x4(%ebx),%edi
Code; �c01205b8 <kmalloc+5c/15c>
� �b: � 85 ff � � � � � � � � � � testl �%edi,%edi
Code; �c01205ba <kmalloc+5e/15c>
� �d: � 75 10 � � � � � � � � � � jne � �1f <_EIP+0x1f> c01205cc 
<kmalloc+70/15c>
Code; �c01205bc <kmalloc+60/15c>
� �f: � 89 19 � � � � � � � � � � movl � %ebx,(%ecx)
Code; �c01205be <kmalloc+62/15c>
� 11: � 89 c8 � � � � � � � � � � movl � %ecx,%eax
Code; �c01205c0 <kmalloc+64/15c>
� 13: � 2b 00 � � � � � � � � � � subl � (%eax),%eax


2 warnings issued. �Results may not be reliable.

7. Enviroment

7.1 Software(ver_linux script):
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
�
Linux sol.alphadiz.com 2.2.19 #4 Wed Jul 11 16:18:13 EEST 2001 i686 unknown
�
Gnu C � � � � � � � � �egcs-2.91.66
Gnu make � � � � � � � 3.77
binutils � � � � � � � 2.9.1.0.24
util-linux � � � � � � 2.9u
modutils � � � � � � � 2.1.121
e2fsprogs � � � � � � �1.17
pcmcia-cs � � � � � � �3.0.14
PPP � � � � � � � � � �2.3.10
Linux C Library � � � �2.1.3
Dynamic linker (ldd) � 2.1.3
Procps � � � � � � � � 2.0.4
Net-tools � � � � � � �1.53
Console-tools � � � � �1999.03.02
Sh-utils � � � � � � � 2.0
Modules Loaded � � � � ip_masq_raudio ip_masq_ftp

7.2 Processor(/proc/cpuinfo):
processor�������: 0
vendor_id�������: GenuineIntel
cpu family������: 6
model�����������: 8
model name������: Pentium III (Coppermine)
stepping��������: 3
cpu MHz���������: 601.373
cache size������: 256 KB
fdiv_bug��������: no
hlt_bug���������: no
sep_bug���������: no
f00f_bug��������: no
coma_bug��������: no
fpu�������������: yes
fpu_exception���: yes
cpuid level�����: 2
wp��������������: yes
flags�����������: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr xmm
bogomips��������: 1199.30

7.3 Module information(/proc/modules):
ip_masq_raudio � � � � �2832 � 0 (unused)
ip_masq_ftp � � � � � � 3476 � 5

7.4 SCSI information (/proc/scsi/scsi):
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
� Vendor: FUJITSU �Model: MAE3182LP � � � �Rev: 0112
� Type: � Direct-Access � � � � � � � � � �ANSI SCSI revision: 02


-- 
Best regards,
==============================================
person: 		Eugene Onischenko 
nic-hdl:		EO1030-RIPE
