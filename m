Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRCPARQ>; Thu, 15 Mar 2001 19:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRCPAQ5>; Thu, 15 Mar 2001 19:16:57 -0500
Received: from [64.41.138.173] ([64.41.138.173]:5342 "EHLO
	simon.digitalimpact.com") by vger.kernel.org with ESMTP
	id <S129156AbRCPAQp>; Thu, 15 Mar 2001 19:16:45 -0500
Message-ID: <3AB13120.AE7187B@digitalimpact.com>
Date: Thu, 15 Mar 2001 16:16:16 -0500
From: "Shane Y. Gibson" <sgibson@digitalimpact.com>
Organization: Digital Impact
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops 0000 and 0002 on dual PIII 750 2.4.2 SMP platform
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All,

I just compiled 2.4.2 and installed it on a otherwise stock
Redhat 7.0 platform.  The system is a SuperMicro PIIISME, 
running dual PIII 750s, with 256 cache.  It appears that about
every 10 to 18 hours, the system is panicing, and freezing
up.  The first time, I got an oops 0000, the second time an
oops 0002.  Both crashes have occured only when the systems is
at 100% cpu utlization; processing several hundred MRTG 
indexmaker operations.

I ran ksymoops on both outputs, and the results are pasted
below.  Note, I compiled the kernel without loadable module
support.  Please let me know if there is anything else I can
do/provide to help.  Unfortunately, the second didn't output
enough for ksymoops to extract anything usefull.

v/r
Shane

------------------- first ksymoops output ------------------- 

ksymoops 2.3.4 on i686 2.4.2.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Mar 14 22:05:12 walker kernel: invalid operand: 0000
Mar 14 22:05:12 walker kernel: CPU:    0
Mar 14 22:05:12 walker kernel: EIP:    0010:[rmqueue+581/640]
Mar 14 22:05:12 walker kernel: EFLAGS: 00010286
Mar 14 22:05:12 walker kernel: eax: 00000020   ebx: c1537448   ecx:
00000002   edx: 02000000
Mar 14 22:05:12 walker kernel: esi: 0001efe0   edi: c1000010   ebp:
0001efe0   esp: c28e3e2c
Mar 14 22:05:12 walker kernel: ds: 0018   es: 0018   ss: 0018
Mar 14 22:05:12 walker kernel: Process indexmaker (pid: 24392,
stackpage=c28e3000)
Mar 14 22:05:12 walker kernel: Stack: c024deeb c024e099 000000cb
00012a2e 00000282 00000000 c029dff8 c029dff8 
Mar 14 22:05:12 walker kernel:        c029e1d0 00000000 c029e1cc
c012e664 00000005 00000001 cc187220 c19cde40 
Mar 14 22:05:12 walker kernel:        00000025 c7c85bac c0123a32
cc187220 c19cde40 00000001 c0123ab0 c19cde40 
Mar 14 22:05:12 walker kernel: Call Trace: [__alloc_pages+228/720]
[do_anonymous_page+50/128] [do_no_page+48/160] [handle_mm_fault+276/400]
[do_page_fault+349/1088] [file_read_actor+0/96] [do_brk+186/368] 
Mar 14 22:05:12 walker kernel: Code: 0f 0b 83 c4 0c 89 d8 eb 1d 89 f6 47
83 c6 0c 83 ff 09 0f 86 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   89 d8                     mov    %ebx,%eax
Code;  00000007 Before first symbol
   7:   eb 1d                     jmp    26 <_EIP+0x26> 00000026 Before
first symbol
Code;  00000009 Before first symbol
   9:   89 f6                     mov    %esi,%esi
Code;  0000000b Before first symbol
   b:   47                        inc    %edi
Code;  0000000c Before first symbol
   c:   83 c6 0c                  add    $0xc,%esi
Code;  0000000f Before first symbol
   f:   83 ff 09                  cmp    $0x9,%edi
Code;  00000012 Before first symbol
  12:   0f 86 00 00 00 00         jbe    18 <_EIP+0x18> 00000018 Before
first symbol

Mar 14 22:05:25 walker kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000051
Mar 14 22:05:25 walker kernel: c013f010
Mar 14 22:05:25 walker kernel: *pde = 00000000
Mar 14 22:05:25 walker kernel: Oops: 0000
Mar 14 22:05:25 walker kernel: CPU:    1
Mar 14 22:05:25 walker kernel: EIP:    0010:[path_walk+2032/2400]
Mar 14 22:05:25 walker kernel: EFLAGS: 00010202
Mar 14 22:05:25 walker kernel: eax: 00000029   ebx: d6474240   ecx:
d9080ee0   edx: c1c8bf10
Mar 14 22:05:25 walker kernel: esi: c1c8bf10   edi: d3a2f060   ebp:
c54e3013   esp: c1c8bef4
Mar 14 22:05:25 walker kernel: ds: 0018   es: 0018   ss: 0018
Mar 14 22:05:25 walker kernel: Process rateup (pid: 24715,
stackpage=c1c8b000)
Mar 14 22:05:25 walker kernel: Stack: dff005a0 00000001 d6474240
40174700 dbda2ea0 c011481d dbda2ea0 c54e3000 
Mar 14 22:05:25 walker kernel:        00000013 d45ced21 c1c8bf50
c54e3000 00000000 c1c8bf7c 00000001 c013f832 
Mar 14 22:05:25 walker kernel:        c54e3000 c1c8bf7c 00000000
00000004 c0146b1c db1123a0 c1c8a000 d05596e0 
Mar 14 22:05:25 walker kernel: Call Trace: [do_page_fault+349/1088]
[open_namei+130/1472] [dput+28/368] [filp_open+54/96] [getname+91/160]
[sys_open+58/224] [system_call+51/56] 
Mar 14 22:05:25 walker kernel: Code: 8b 40 28 85 c0 74 79 be 00 e0 ff ff
21 e6 8b 86 3c 03 00 00 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 28                  mov    0x28(%eax),%eax
Code;  00000003 Before first symbol
   3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
   5:   74 79                     je     80 <_EIP+0x80> 00000080 Before
first symbol
Code;  00000007 Before first symbol
   7:   be 00 e0 ff ff            mov    $0xffffe000,%esi
Code;  0000000c Before first symbol
   c:   21 e6                     and    %esp,%esi
Code;  0000000e Before first symbol
   e:   8b 86 3c 03 00 00         mov    0x33c(%esi),%eax

Mar 14 22:05:29 walker kernel: invalid operand: 0000
Mar 14 22:05:29 walker kernel: CPU:    1
Mar 14 22:05:29 walker kernel: EIP:    0010:[rmqueue+581/640]
Mar 14 22:05:29 walker kernel: EFLAGS: 00013286
Mar 14 22:05:29 walker kernel: eax: 00000020   ebx: c154ec24   ecx:
00000000   edx: 00000002
Mar 14 22:05:29 walker kernel: esi: 0001efe0   edi: c1000010   ebp:
0001efe0   esp: d886be8c
Mar 14 22:05:29 walker kernel: ds: 0018   es: 0018   ss: 0018
Mar 14 22:05:29 walker kernel: Process X (pid: 13530,
stackpage=d886b000)
Mar 14 22:05:29 walker kernel: Stack: c024deeb c024e099 000000cb
00012fb5 00003282 00000000 c029dff8 c029dff8 
Mar 14 22:05:29 walker kernel:        c029e1f8 00000000 c029e1f4
c012e664 00000007 00000001 00000000 d886bf5c 
Mar 14 22:05:29 walker kernel:        cc23a1a0 d4f6aca0 c012e868
c0143123 cfbc5cc0 cc23a1a0 cfbc5d90 00000000 
Mar 14 22:05:29 walker kernel: Call Trace: [__alloc_pages+228/720]
[__get_free_pages+24/48] [__pollwait+51/144] [tcp_poll+46/352]
[do_readv_writev+396/608] [sock_poll+33/48] [do_select+295/576] 
Mar 14 22:05:29 walker kernel: Code: 0f 0b 83 c4 0c 89 d8 eb 1d 89 f6 47
83 c6 0c 83 ff 09 0f 86 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   89 d8                     mov    %ebx,%eax
Code;  00000007 Before first symbol
   7:   eb 1d                     jmp    26 <_EIP+0x26> 00000026 Before
first symbol
Code;  00000009 Before first symbol
   9:   89 f6                     mov    %esi,%esi
Code;  0000000b Before first symbol
   b:   47                        inc    %edi
Code;  0000000c Before first symbol
   c:   83 c6 0c                  add    $0xc,%esi
Code;  0000000f Before first symbol
   f:   83 ff 09                  cmp    $0x9,%edi
Code;  00000012 Before first symbol
  12:   0f 86 00 00 00 00         jbe    18 <_EIP+0x18> 00000018 Before
first symbol

Mar 14 22:05:32 walker kernel: invalid operand: 0000
Mar 14 22:05:32 walker kernel: CPU:    1
Mar 14 22:05:32 walker kernel: EIP:    0010:[rmqueue+581/640]
Mar 14 22:05:32 walker kernel: EFLAGS: 00010286
Mar 14 22:05:32 walker kernel: eax: 00000020   ebx: c165e1c8   ecx:
cffc8000   edx: 00000002
Mar 14 22:05:32 walker kernel: esi: 0001efe0   edi: c1000010   ebp:
0001efe0   esp: cffc9e2c
Mar 14 22:05:32 walker kernel: ds: 0018   es: 0018   ss: 0018


------------------- second ksymoops output ------------------- 


ksymoops 2.3.4 on i686 2.4.2.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Mar 15 15:40:34 walker kernel: Unable to handle kernel paging request at
virtual address 548ac520
Mar 15 15:40:34 walker kernel: c0116698
Mar 15 15:40:34 walker kernel: *pde = 00000000
Mar 15 15:40:34 walker kernel: Oops: 0002
Mar 15 15:40:34 walker kernel: CPU:    0
Mar 15 15:40:34 walker kernel: EIP:    0010:[remove_wait_queue+8/48]
Mar 15 15:40:34 walker kernel: EFLAGS: 00010092
Mar 15 15:40:34 walker kernel: eax: cc6ba00c   ebx: 548ac520   ecx:
00000292   edx: cc6ba00c
Mar 15 15:40:34 walker kernel: esi: cc6ba000   edi: cc6ba008   ebp:
00000000   esp: c1897f28
Mar 15 15:40:34 walker kernel: ds: 0018   es: 0018   ss: 0018


--
Shane Y. Gibson                     sgibson@digitalimpact.com
Network Architect                        (408) 447-8253  work
IT Data Center Operations                (650) 302-0193  cell
Digital Impact, Inc.                     (408) 447-8298   fax

     "The whole problem with the world is that fools and
      fanatics are always so certain of themselves,  and
      wiser people so full of doubts."  Bertrand Russell
