Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbRAWS3j>; Tue, 23 Jan 2001 13:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129763AbRAWS3a>; Tue, 23 Jan 2001 13:29:30 -0500
Received: from think.faceprint.com ([166.90.149.11]:29715 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S130748AbRAWS26>; Tue, 23 Jan 2001 13:28:58 -0500
Message-ID: <3A6DCD67.36611F52@faceprint.com>
Date: Tue, 23 Jan 2001 13:28:55 -0500
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS in 2.4.0-ac10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A whole bunch of oopses.  Was able to alt-sysrq with all of them.  The
second one of the 4 i'm posting here happened about a dozen times in a
row in about a 45 min period while I was away from my machine.  I opted
not to post a dozen duplicate oopses, so I sipped those out.  For the
most part, I think these all occured w/ some combination of netscape,
gaim, xmms, and possibly gnapster running, plus a couple Eterms.  

The system is an Athlon Tbird 1.1GHz, Asus A7V motherboard, blah, blah. 
I can give more detailed info if anyone wants it.

I'm gonna hurry up and hit send now before it oopses again ;-)

Nathan

patience:~# uname -a
Linux patience 2.4.0-ac10 #50 Sat Jan 20 17:13:29 EST 2001 i686 unknown

ksymoops 2.3.7 on i686 2.4.0-ac10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-ac10/ (default)
     -m /boot/System.map-2.4.0-ac10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jan 22 23:23:29 patience kernel: c01436c2
Jan 22 23:23:29 patience kernel: Oops: 0002
Jan 22 23:23:29 patience kernel: CPU:    0
Jan 22 23:23:29 patience kernel: EIP:    0010:[d_alloc+146/400]
Jan 22 23:23:29 patience kernel: EFLAGS: 00010216
Jan 22 23:23:29 patience kernel: eax: cbd21f24   ebx: 6e4c4040   ecx:
00000003   edx: 0000000c
Jan 22 23:23:29 patience kernel: esi: cbd21f5c   edi: 6e4c40a0   ebp:
c1449140   esp: cbd21ef4
Jan 22 23:23:29 patience kernel: ds: 0018   es: 0018   ss: 0018
Jan 22 23:23:29 patience kernel: Process enlightenment (pid: 297,
stackpage=cbd21000)
Jan 22 23:23:29 patience kernel: Stack: cbd21f5c c5abe640 c1449140
fffffff4 6e4c40a0 c013029f c1449140 cbd21f24
Jan 22 23:23:29 patience kernel:        cbd21f5c c5abe640 000003b6
00000001 cbd21f5c 0000000c 00000000 c01a8872
Jan 22 23:23:29 patience kernel:        cbd21f5c 00000270 00000000
cbd21f5c c02d6e16 00000000 00000270 00000000
Jan 22 23:23:29 patience kernel: Call Trace: [shmem_file_setup+95/256]
[newseg+146/352] [sys_shmget+104/304] [sys_ipc+476/512]
[system_call+51/56]
Jan 22 23:23:29 patience kernel: Code: f3 a5 f6 c2 02 74 02 66 a5 f6 c2
01 74 01 a4 eb 0f 52 56 8b
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)
Code;  00000002 Before first symbol
   2:   f6 c2 02                  test   $0x2,%dl
Code;  00000005 Before first symbol
   5:   74 02                     je     9 <_EIP+0x9> 00000009 Before
first symbol
Code;  00000007 Before first symbol
   7:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  00000009 Before first symbol
   9:   f6 c2 01                  test   $0x1,%dl
Code;  0000000c Before first symbol
   c:   74 01                     je     f <_EIP+0xf> 0000000f Before
first symbol
Code;  0000000e Before first symbol
   e:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  0000000f Before first symbol
   f:   eb 0f                     jmp    20 <_EIP+0x20> 00000020 Before
first symbol
Code;  00000011 Before first symbol
  11:   52                        push   %edx
Code;  00000012 Before first symbol
  12:   56                        push   %esi
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

Jan 22 23:23:29 patience kernel: c0129bd4
Jan 22 23:23:29 patience kernel: Oops: 0000
Jan 22 23:23:29 patience kernel: CPU:    0
Jan 22 23:23:29 patience kernel: EIP:    0010:[kmem_cache_alloc+36/96]
Jan 22 23:23:29 patience kernel: EFLAGS: 00010803
Jan 22 23:23:29 patience kernel: eax: 291f110b   ebx: c1447e08   ecx:
5df4c640   edx: ce6c4000
Jan 22 23:23:29 patience kernel: esi: 00000282   edi: 00000007   ebp:
c14490c0   esp: c75bbf10
Jan 22 23:23:29 patience kernel: ds: 0018   es: 0018   ss: 0018
Jan 22 23:23:29 patience kernel: Process xmms (pid: 1089,
stackpage=c75bb000)
Jan 22 23:23:29 patience kernel: Stack: 00000000 cc89aac0 c75bbf62
c0143648 c1447e08 00000007 00000000 cc89aac0
Jan 22 23:23:29 patience kernel:        c75bbf62 0000000c c02559a0
c02559db c14490c0 c75bbf78 00000000 080572d4
Jan 22 23:23:29 patience kernel:        08144d20 bffffae4 3631395b
36343532 c75b005d c1044010 00000282 00000000
Jan 22 23:23:29 patience kernel: Call Trace: [d_alloc+24/400]
[sock_map_fd+96/384] [sock_map_fd+155/384] [sys_socket+48/96]
[sys_socketcall+99/512] [system_call+51/56]
Jan 22 23:23:29 patience kernel: Code: 8b 44 82 18 89 42 14 83 f8 ff 75
05 8b 02 89 43 08 56 9d 89

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax
Code;  00000004 Before first symbol
   4:   89 42 14                  mov    %eax,0x14(%edx)
Code;  00000007 Before first symbol
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  0000000a Before first symbol
   a:   75 05                     jne    11 <_EIP+0x11> 00000011 Before
first symbol
Code;  0000000c Before first symbol
   c:   8b 02                     mov    (%edx),%eax
Code;  0000000e Before first symbol
   e:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  00000011 Before first symbol
  11:   56                        push   %esi
Code;  00000012 Before first symbol
  12:   9d                        popf
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)

<snip about a dozen duplicates>

Jan 23 13:02:23 patience kernel: c02a84bd
Jan 23 13:02:23 patience kernel: Oops: 0002
Jan 23 13:02:23 patience kernel: CPU:    0
Jan 23 13:02:23 patience kernel: EIP:    0010:[memparse+3165/10164]
Jan 23 13:02:23 patience kernel: EFLAGS: 00010246
Jan 23 13:02:23 patience kernel: eax: 00000000   ebx: 00000000   ecx:
00000004   edx: 00000000
Jan 23 13:02:23 patience kernel: esi: bffffaf4   edi: 971f4100   ebp:
fffffff2   esp: cbe29f7c
Jan 23 13:02:23 patience kernel: ds: 0018   es: 0018   ss: 0018
Jan 23 13:02:23 patience kernel: Process E-NetGraph.eppl (pid: 310,
stackpage=cbe29000)
Jan 23 13:02:23 patience kernel: Stack: 00000000 00000004 cbe28000
00000000 bffffae4 bffffb74 00000003 00000023
Jan 23 13:02:23 patience kernel:        00000004 971f4100 0000000a
971f4100 971f4104 971f4108 971f410c 971f4110
Jan 23 13:02:23 patience kernel:        971f4114 c0108ed3 00000004
bffffaf4 00000000 00000000 bffffae4 bffffb74
Jan 23 13:02:23 patience kernel: Call Trace: [system_call+51/56]
Jan 23 13:02:23 patience kernel: Code: f3 aa 58 59 e9 61 7c e9 ff 8d 4c
8b 00 51 50 31 c0 f3 aa 58

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f3 aa                     repz stos %al,%es:(%edi)
Code;  00000002 Before first symbol
   2:   58                        pop    %eax
Code;  00000003 Before first symbol
   3:   59                        pop    %ecx
Code;  00000004 Before first symbol
   4:   e9 61 7c e9 ff            jmp    ffe97c6a <_EIP+0xffe97c6a>
ffe97c6a <END_OF_CODE+2d5b722f/????>
Code;  00000009 Before first symbol
   9:   8d 4c 8b 00               lea    0x0(%ebx,%ecx,4),%ecx
Code;  0000000d Before first symbol
   d:   51                        push   %ecx
Code;  0000000e Before first symbol
   e:   50                        push   %eax
Code;  0000000f Before first symbol
   f:   31 c0                     xor    %eax,%eax
Code;  00000011 Before first symbol
  11:   f3 aa                     repz stos %al,%es:(%edi)
Code;  00000013 Before first symbol
  13:   58                        pop    %eax

Jan 23 13:03:29 patience kernel: c0140430
Jan 23 13:03:29 patience kernel: Oops: 0000
Jan 23 13:03:29 patience kernel: CPU:    0
Jan 23 13:03:29 patience kernel: EIP:    0010:[do_pollfd+16/144]
Jan 23 13:03:29 patience kernel: EFLAGS: 00010297
Jan 23 13:03:29 patience kernel: eax: 5f726162   ebx: 00000000   ecx:
00000006   edx: c72f4e00
Jan 23 13:03:29 patience kernel: esi: cd1c7fb4   edi: 5f726162   ebp:
00000000   esp: cd1c7f28
Jan 23 13:03:29 patience kernel: ds: 0018   es: 0018   ss: 0018
Jan 23 13:03:29 patience kernel: Process panel (pid: 294,
stackpage=cd1c7000)
Jan 23 13:03:29 patience kernel: Stack: 00000000 cd1c7fb4 08130c08
0000000b c0140537 00000006 5f726162 cd1c7f60
Jan 23 13:03:29 patience kernel:        cd1c7f64 00000006 cd1c7fb4
08130c08 cd1c7fbc cd1c6000 00000000 00000000
Jan 23 13:03:29 patience kernel:        c0140763 00000006 00000000
00000006 c72f4e00 cd1c7fb4 0000000b cd1c6000
Jan 23 13:03:29 patience kernel: Call Trace: [do_poll+135/224]
[sys_poll+467/736] [system_call+51/56]
Jan 23 13:03:29 patience kernel: Code: 8b 07 31 f6 85 c0 7c 56 e8 03 23
ff ff 89 c3 be 20 00 00 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 07                     mov    (%edi),%eax
Code;  00000002 Before first symbol
   2:   31 f6                     xor    %esi,%esi
Code;  00000004 Before first symbol
   4:   85 c0                     test   %eax,%eax
Code;  00000006 Before first symbol
   6:   7c 56                     jl     5e <_EIP+0x5e> 0000005e Before
first symbol
Code;  00000008 Before first symbol
   8:   e8 03 23 ff ff            call   ffff2310 <_EIP+0xffff2310>
ffff2310 <END_OF_CODE+2d7118d5/????>
Code;  0000000d Before first symbol
   d:   89 c3                     mov    %eax,%ebx
Code;  0000000f Before first symbol
   f:   be 20 00 00 00            mov    $0x20,%esi


1 warning issued.  Results may not be reliable.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
