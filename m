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
ksymoops 2.4.1 on i686 2.2.19. šOptions used
š š š-V (default)
š š š-k /proc/ksyms (default)
š š š-l /proc/modules (default)
š š š-o /lib/modules/2.2.19/ (default)
š š š-m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information. šI will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc. šksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not 
found in System.map. šIgnoring ksyms_base entry
156a74>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 
Using defaults from ksymoops -t elf32-i386 -a i386

Code; š00000000 Before first symbol
00000000 <_EIP>:
Code; š00000000 Before first symbol
š š0: š 8b 01 š š š š š š š š š š movl š (%ecx),%eax
Code; š00000002 Before first symbol
š š2: š 89 03 š š š š š š š š š š movl š %eax,(%ebx)
Code; š00000004 Before first symbol
š š4: š 85 c0 š š š š š š š š š š testl š%eax,%eax
Code; š00000006 Before first symbol
š š6: š 74 2b š š š š š š š š š š je š š 33 <_EIP+0x33> 00000033 Before first 
symbol
Code; š00000008 Before first symbol
š š8: š 8b 7b 04 š š š š š š š š šmovl š 0x4(%ebx),%edi
Code; š0000000b Before first symbol
š šb: š 85 ff š š š š š š š š š š testl š%edi,%edi
Code; š0000000d Before first symbol
š šd: š 75 10 š š š š š š š š š š jne š š1f <_EIP+0x1f> 0000001f Before first 
symbol
Code; š0000000f Before first symbol
š šf: š 89 19 š š š š š š š š š š movl š %ebx,(%ecx)
Code; š00000011 Before first symbol
š 11: š 89 c8 š š š š š š š š š š movl š %ecx,%eax
Code; š00000013 Before first symbol
š 13: š 2b 00 š š š š š š š š š š subl š (%eax),%eax

Unable to handle kernel paging request at virtual address 41040000
current->tss.cr3 = 06178000, %cr3 = 06178000
*pde = 00000000
Oops: 0000
CPU: š š0
EIP: š š0010:[<c01205ad>]
EFLAGS: 00010002
eax: c37a1fe0 š ebx: c37a1fe0 š ecx: 41040000 š edx: cbc689d0
esi: cffff080 š edi: cc8dd200 š ebp: 00000282 š esp: c604be94
ds: 0018 š es: 0018 š ss: 0018
Process kdeinit (pid: 8013, process nr: 202, stackpage=c604b000)
Stack: cc8dd200 c6fc2b60 c01827b3 0000001e 00000015 c604a000 c6409480 
cc8dd200 
š š š šc6fc2b60 00000015 cbc689d0 c0182d74 cc8dd200 00000001 c0182e24 
cbc689d0 
š š š šcbc689d0 c604bf14 00000015 bffff05c cc8dc440 fffffff4 bfffefec 
c01571eb 
Call Trace: [<c01827b3>] [<c0182d74>] [<c0182e24>] [<c01571eb>] [<c011ac89>] 
[<c011acef>] [<c011add5>] 
š š š š[<c0157b18>] [<c0109135>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 

>>EIP; c01205ad <kmalloc+51/15c> š <=====

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
Code; šc01205ad <kmalloc+51/15c>
00000000 <_EIP>:
Code; šc01205ad <kmalloc+51/15c> š <=====
š š0: š 8b 01 š š š š š š š š š š movl š (%ecx),%eax š <=====
Code; šc01205af <kmalloc+53/15c>
š š2: š 89 03 š š š š š š š š š š movl š %eax,(%ebx)
Code; šc01205b1 <kmalloc+55/15c>
š š4: š 85 c0 š š š š š š š š š š testl š%eax,%eax
Code; šc01205b3 <kmalloc+57/15c>
š š6: š 74 2b š š š š š š š š š š je š š 33 <_EIP+0x33> c01205e0 
<kmalloc+84/15c>
Code; šc01205b5 <kmalloc+59/15c>
š š8: š 8b 7b 04 š š š š š š š š šmovl š 0x4(%ebx),%edi
Code; šc01205b8 <kmalloc+5c/15c>
š šb: š 85 ff š š š š š š š š š š testl š%edi,%edi
Code; šc01205ba <kmalloc+5e/15c>
š šd: š 75 10 š š š š š š š š š š jne š š1f <_EIP+0x1f> c01205cc 
<kmalloc+70/15c>
Code; šc01205bc <kmalloc+60/15c>
š šf: š 89 19 š š š š š š š š š š movl š %ebx,(%ecx)
Code; šc01205be <kmalloc+62/15c>
š 11: š 89 c8 š š š š š š š š š š movl š %ecx,%eax
Code; šc01205c0 <kmalloc+64/15c>
š 13: š 2b 00 š š š š š š š š š š subl š (%eax),%eax

Unable to handle kernel paging request at virtual address 41040000
current->tss.cr3 = 01002000, %cr3 = 01002000
*pde = 00000000
Oops: 0000
CPU: š š0
EIP: š š0010:[<c01205ad>]
EFLAGS: 00010006
eax: c37a1fe0 š ebx: c37a1fe0 š ecx: 41040000 š edx: 00000018
esi: cffff080 š edi: 00000008 š ebp: 00000282 š esp: cdcc5f5c
ds: 0018 š es: 0018 š ss: 0018
Process kdeinit (pid: 7980, process nr: 71, stackpage=cdcc5000)
Stack: 00000008 0000000c c012e39a 00000018 00000015 cdcc4000 00000000 
00000000 
š š š šbffff9e4 00000008 00000000 00000004 cecfdc60 cdcc4000 00000018 
00000032 
š š š šcdcc4000 cecfdc60 7fffffff 00000009 080633d8 bffff5a8 c0156a74 
00000000 
Call Trace: [<c012e39a>] [<c0156a74>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 

>>EIP; c01205ad <kmalloc+51/15c> š <=====

Trace; c012e39a <sys_select+132/550>
Trace; c0156a74 <sock_write+0/9c>
Trace; c010901c <system_call+34/38>
Code; šc01205ad <kmalloc+51/15c>
00000000 <_EIP>:
Code; šc01205ad <kmalloc+51/15c> š <=====
š š0: š 8b 01 š š š š š š š š š š movl š (%ecx),%eax š <=====
Code; šc01205af <kmalloc+53/15c>
š š2: š 89 03 š š š š š š š š š š movl š %eax,(%ebx)
Code; šc01205b1 <kmalloc+55/15c>
š š4: š 85 c0 š š š š š š š š š š testl š%eax,%eax
Code; šc01205b3 <kmalloc+57/15c>
š š6: š 74 2b š š š š š š š š š š je š š 33 <_EIP+0x33> c01205e0 
<kmalloc+84/15c>
Code; šc01205b5 <kmalloc+59/15c>
š š8: š 8b 7b 04 š š š š š š š š šmovl š 0x4(%ebx),%edi
Code; šc01205b8 <kmalloc+5c/15c>
š šb: š 85 ff š š š š š š š š š š testl š%edi,%edi
Code; šc01205ba <kmalloc+5e/15c>
š šd: š 75 10 š š š š š š š š š š jne š š1f <_EIP+0x1f> c01205cc 
<kmalloc+70/15c>
Code; šc01205bc <kmalloc+60/15c>
š šf: š 89 19 š š š š š š š š š š movl š %ebx,(%ecx)
Code; šc01205be <kmalloc+62/15c>
š 11: š 89 c8 š š š š š š š š š š movl š %ecx,%eax
Code; šc01205c0 <kmalloc+64/15c>
š 13: š 2b 00 š š š š š š š š š š subl š (%eax),%eax

Unable to handle kernel paging request at virtual address 41040000
current->tss.cr3 = 06932000, %cr3 = 06932000
*pde = 00000000
Oops: 0000
CPU: š š0
EIP: š š0010:[<c01205ad>]
EFLAGS: 00010002
eax: c37a1fe0 š ebx: c37a1fe0 š ecx: 41040000 š edx: 00000018
esi: cffff080 š edi: 00000008 š ebp: 00000282 š esp: c6465f5c
ds: 0018 š es: 0018 š ss: 0018
Process kdeinit (pid: 8345, process nr: 59, stackpage=c6465000)
Stack: 00000008 0000000c c012e39a 00000018 00000015 c6464000 00000000 
00000000 
š š š šbffff478 00000008 00000000 00000004 00000001 00000000 00000018 
00000025 
š š š šc6464000 c59d0060 7fffffff c0124b79 c59d0060 c6464000 00000000 
0805ff10 
Call Trace: [<c012e39a>] [<c0124b79>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 

>>EIP; c01205ad <kmalloc+51/15c> š <=====

Trace; c012e39a <sys_select+132/550>
Trace; c0124b79 <sys_read+b9/c4>
Trace; c010901c <system_call+34/38>
Code; šc01205ad <kmalloc+51/15c>
00000000 <_EIP>:
Code; šc01205ad <kmalloc+51/15c> š <=====
š š0: š 8b 01 š š š š š š š š š š movl š (%ecx),%eax š <=====
Code; šc01205af <kmalloc+53/15c>
š š2: š 89 03 š š š š š š š š š š movl š %eax,(%ebx)
Code; šc01205b1 <kmalloc+55/15c>
š š4: š 85 c0 š š š š š š š š š š testl š%eax,%eax
Code; šc01205b3 <kmalloc+57/15c>
š š6: š 74 2b š š š š š š š š š š je š š 33 <_EIP+0x33> c01205e0 
<kmalloc+84/15c>
Code; šc01205b5 <kmalloc+59/15c>
š š8: š 8b 7b 04 š š š š š š š š šmovl š 0x4(%ebx),%edi
Code; šc01205b8 <kmalloc+5c/15c>
š šb: š 85 ff š š š š š š š š š š testl š%edi,%edi
Code; šc01205ba <kmalloc+5e/15c>
š šd: š 75 10 š š š š š š š š š š jne š š1f <_EIP+0x1f> c01205cc 
<kmalloc+70/15c>
Code; šc01205bc <kmalloc+60/15c>
š šf: š 89 19 š š š š š š š š š š movl š %ebx,(%ecx)
Code; šc01205be <kmalloc+62/15c>
š 11: š 89 c8 š š š š š š š š š š movl š %ecx,%eax
Code; šc01205c0 <kmalloc+64/15c>
š 13: š 2b 00 š š š š š š š š š š subl š (%eax),%eax

Unable to handle kernel paging request at virtual address 41040000
current->tss.cr3 = 0dce7000, %cr3 = 0dce7000
*pde = 00000000
Oops: 0000
CPU: š š0
EIP: š š0010:[<c01205ad>]
EFLAGS: 00010002
eax: c37a1fe0 š ebx: c37a1fe0 š ecx: 41040000 š edx: ffffffe0
esi: cffff080 š edi: 00000015 š ebp: 00000282 š esp: ca5e5e80
ds: 0018 š es: 0018 š ss: 0018
Process kdeinit (pid: 8314, process nr: 48, stackpage=ca5e5000)
Stack: 00000015 00000040 c0158d79 00000014 00000015 c3b1e700 00000000 
ca5e4000 
š š š šc0158523 0000000c 00000015 c3b1e700 c0158797 c3b1e700 0000000c 
00000000 
š š š š00000015 ca5e5f08 0000000c c0183558 ca5e5f0c ca5e4000 c0183642 
c3b1e700 
Call Trace: [<c0158d79>] [<c0158523>] [<c0158797>] [<c0183558>] [<c0183642>] 
[<c0183558>] [<c01568f8>] 
š š š š[<c0183558>] [<c0156b06>] [<c0124c69>] [<c0156a74>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 

>>EIP; c01205ad <kmalloc+51/15c> š <=====

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
Code; šc01205ad <kmalloc+51/15c>
00000000 <_EIP>:
Code; šc01205ad <kmalloc+51/15c> š <=====
š š0: š 8b 01 š š š š š š š š š š movl š (%ecx),%eax š <=====
Code; šc01205af <kmalloc+53/15c>
š š2: š 89 03 š š š š š š š š š š movl š %eax,(%ebx)
Code; šc01205b1 <kmalloc+55/15c>
š š4: š 85 c0 š š š š š š š š š š testl š%eax,%eax
Code; šc01205b3 <kmalloc+57/15c>
š š6: š 74 2b š š š š š š š š š š je š š 33 <_EIP+0x33> c01205e0 
<kmalloc+84/15c>
Code; šc01205b5 <kmalloc+59/15c>
š š8: š 8b 7b 04 š š š š š š š š šmovl š 0x4(%ebx),%edi
Code; šc01205b8 <kmalloc+5c/15c>
š šb: š 85 ff š š š š š š š š š š testl š%edi,%edi
Code; šc01205ba <kmalloc+5e/15c>
š šd: š 75 10 š š š š š š š š š š jne š š1f <_EIP+0x1f> c01205cc 
<kmalloc+70/15c>
Code; šc01205bc <kmalloc+60/15c>
š šf: š 89 19 š š š š š š š š š š movl š %ebx,(%ecx)
Code; šc01205be <kmalloc+62/15c>
š 11: š 89 c8 š š š š š š š š š š movl š %ecx,%eax
Code; šc01205c0 <kmalloc+64/15c>
š 13: š 2b 00 š š š š š š š š š š subl š (%eax),%eax

Unable to handle kernel paging request at virtual address 41040000
current->tss.cr3 = 08277000, %cr3 = 08277000
*pde = 00000000
Oops: 0000
CPU: š š0
EIP: š š0010:[<c01205ad>]
EFLAGS: 00010006
eax: c37a1fe0 š ebx: c37a1fe0 š ecx: 41040000 š edx: 00000018
esi: cffff080 š edi: 00000008 š ebp: 00000282 š esp: cf453f5c
ds: 0018 š es: 0018 š ss: 0018
Process kdeinit (pid: 8388, process nr: 86, stackpage=cf453000)
Stack: 00000008 0000000c c012e39a 00000018 00000015 cf452000 00000000 
00000000 
š š š šbffff9e4 00000008 00000000 00000004 c4e618a0 cf452000 00000018 
0000002f 
š š š šcf452000 c4e618a0 7fffffff 0000000c 080627c8 bffff5a8 c0156a74 
00000000 
Call Trace: [<c012e39a>] [<c0156a74>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 

>>EIP; c01205ad <kmalloc+51/15c> š <=====

Trace; c012e39a <sys_select+132/550>
Trace; c0156a74 <sock_write+0/9c>
Trace; c010901c <system_call+34/38>
Code; šc01205ad <kmalloc+51/15c>
00000000 <_EIP>:
Code; šc01205ad <kmalloc+51/15c> š <=====
š š0: š 8b 01 š š š š š š š š š š movl š (%ecx),%eax š <=====
Code; šc01205af <kmalloc+53/15c>
š š2: š 89 03 š š š š š š š š š š movl š %eax,(%ebx)
Code; šc01205b1 <kmalloc+55/15c>
š š4: š 85 c0 š š š š š š š š š š testl š%eax,%eax
Code; šc01205b3 <kmalloc+57/15c>
š š6: š 74 2b š š š š š š š š š š je š š 33 <_EIP+0x33> c01205e0 
<kmalloc+84/15c>
Code; šc01205b5 <kmalloc+59/15c>
š š8: š 8b 7b 04 š š š š š š š š šmovl š 0x4(%ebx),%edi
Code; šc01205b8 <kmalloc+5c/15c>
š šb: š 85 ff š š š š š š š š š š testl š%edi,%edi
Code; šc01205ba <kmalloc+5e/15c>
š šd: š 75 10 š š š š š š š š š š jne š š1f <_EIP+0x1f> c01205cc 
<kmalloc+70/15c>
Code; šc01205bc <kmalloc+60/15c>
š šf: š 89 19 š š š š š š š š š š movl š %ebx,(%ecx)
Code; šc01205be <kmalloc+62/15c>
š 11: š 89 c8 š š š š š š š š š š movl š %ecx,%eax
Code; šc01205c0 <kmalloc+64/15c>
š 13: š 2b 00 š š š š š š š š š š subl š (%eax),%eax

Unable to handle kernel paging request at virtual address 41040000
current->tss.cr3 = 00da9000, %cr3 = 00da9000
*pde = 00000000
Oops: 0000
CPU: š š0
EIP: š š0010:[<c01205ad>]
EFLAGS: 00010006
eax: c37a1fe0 š ebx: c37a1fe0 š ecx: 41040000 š edx: 00000018
esi: cffff080 š edi: 00000008 š ebp: 00000282 š esp: cca3bf5c
ds: 0018 š es: 0018 š ss: 0018
Process kdeinit (pid: 8737, process nr: 17, stackpage=cca3b000)
Stack: 00000008 0000000c c012e39a 00000018 00000015 cca3a000 00000000 
00000000 
š š š šbffff9e4 00000008 00000000 00000004 cba26660 cca3a000 00000018 
0000002b 
š š š šcca3a000 cba26660 7fffffff 0000000e 0805f160 bffff5a8 c0156a74 
00000000 
Call Trace: [<c012e39a>] [<c0156a74>] [<c010901c>] 
Code: 8b 01 89 03 85 c0 74 2b 8b 7b 04 85 ff 75 10 89 19 89 c8 2b 

>>EIP; c01205ad <kmalloc+51/15c> š <=====

Trace; c012e39a <sys_select+132/550>
Trace; c0156a74 <sock_write+0/9c>
Trace; c010901c <system_call+34/38>
Code; šc01205ad <kmalloc+51/15c>
00000000 <_EIP>:
Code; šc01205ad <kmalloc+51/15c> š <=====
š š0: š 8b 01 š š š š š š š š š š movl š (%ecx),%eax š <=====
Code; šc01205af <kmalloc+53/15c>
š š2: š 89 03 š š š š š š š š š š movl š %eax,(%ebx)
Code; šc01205b1 <kmalloc+55/15c>
š š4: š 85 c0 š š š š š š š š š š testl š%eax,%eax
Code; šc01205b3 <kmalloc+57/15c>
š š6: š 74 2b š š š š š š š š š š je š š 33 <_EIP+0x33> c01205e0 
<kmalloc+84/15c>
Code; šc01205b5 <kmalloc+59/15c>
š š8: š 8b 7b 04 š š š š š š š š šmovl š 0x4(%ebx),%edi
Code; šc01205b8 <kmalloc+5c/15c>
š šb: š 85 ff š š š š š š š š š š testl š%edi,%edi
Code; šc01205ba <kmalloc+5e/15c>
š šd: š 75 10 š š š š š š š š š š jne š š1f <_EIP+0x1f> c01205cc 
<kmalloc+70/15c>
Code; šc01205bc <kmalloc+60/15c>
š šf: š 89 19 š š š š š š š š š š movl š %ebx,(%ecx)
Code; šc01205be <kmalloc+62/15c>
š 11: š 89 c8 š š š š š š š š š š movl š %ecx,%eax
Code; šc01205c0 <kmalloc+64/15c>
š 13: š 2b 00 š š š š š š š š š š subl š (%eax),%eax


2 warnings issued. šResults may not be reliable.

7. Enviroment

7.1 Software(ver_linux script):
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
š
Linux sol.alphadiz.com 2.2.19 #4 Wed Jul 11 16:18:13 EEST 2001 i686 unknown
š
Gnu C š š š š š š š š šegcs-2.91.66
Gnu make š š š š š š š 3.77
binutils š š š š š š š 2.9.1.0.24
util-linux š š š š š š 2.9u
modutils š š š š š š š 2.1.121
e2fsprogs š š š š š š š1.17
pcmcia-cs š š š š š š š3.0.14
PPP š š š š š š š š š š2.3.10
Linux C Library š š š š2.1.3
Dynamic linker (ldd) š 2.1.3
Procps š š š š š š š š 2.0.4
Net-tools š š š š š š š1.53
Console-tools š š š š š1999.03.02
Sh-utils š š š š š š š 2.0
Modules Loaded š š š š ip_masq_raudio ip_masq_ftp

7.2 Processor(/proc/cpuinfo):
processorššššššš: 0
vendor_idššššššš: GenuineIntel
cpu familyšššššš: 6
modelššššššššššš: 8
model namešššššš: Pentium III (Coppermine)
steppingšššššššš: 3
cpu MHzššššššššš: 601.373
cache sizešššššš: 256 KB
fdiv_bugšššššššš: no
hlt_bugššššššššš: no
sep_bugššššššššš: no
f00f_bugšššššššš: no
coma_bugšššššššš: no
fpuššššššššššššš: yes
fpu_exceptionššš: yes
cpuid levelššššš: 2
wpšššššššššššššš: yes
flagsššššššššššš: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr xmm
bogomipsšššššššš: 1199.30

7.3 Module information(/proc/modules):
ip_masq_raudio š š š š š2832 š 0 (unused)
ip_masq_ftp š š š š š š 3476 š 5

7.4 SCSI information (/proc/scsi/scsi):
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
š Vendor: FUJITSU šModel: MAE3182LP š š š šRev: 0112
š Type: š Direct-Access š š š š š š š š š šANSI SCSI revision: 02


-- 
Best regards,
==============================================
person: 		Eugene Onischenko 
nic-hdl:		EO1030-RIPE
