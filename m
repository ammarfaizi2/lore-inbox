Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313140AbSC2CHq>; Thu, 28 Mar 2002 21:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313158AbSC2CHh>; Thu, 28 Mar 2002 21:07:37 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:57591 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S313140AbSC2CHZ>; Thu, 28 Mar 2002 21:07:25 -0500
Message-ID: <00ba01c1d6c6$780f1e90$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Dave Jones" <davej@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.5.7-dj2 ide/piix
Date: Thu, 28 Mar 2002 21:07:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 29 Mar 2002 02:07:24.0965 (UTC) FILETIME=[7815D550:01C1D6C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am consistently getting the following oops during boot on 2.5.7-dj2.

Hardware is SMP ppro, 440FX chipset, PIIX ide. Compiler was gcc 2.96.
.config is the same as posted with the acct.c compile issue earlier.

Let me know if you need more information. This machine is

--Adam

ksymoops 2.4.1 on i686 2.4.19-pre4-ac2.  Options used
     -v /usr/src/linux-2.5.7-dj2+acct-fix2/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux-2.5.7-dj2+acct-fix2/System.map (specified)

CPU:    1
EIP:    0010:[<c0243ba9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00007530   ebx: 00007530   ecx: 00000001   edx: 00000000
esi: 00000000   edi: c03cfa60   ebp: c03cfaa4   esp: c9fc3eec
ds: 0018   es: 0018   ss: 0018
Stack: 00030958 c03cfcc4 0c000000 c03cfcc4 000000a1 c03cfa60 25c4946d c0230018
       c03c0018 ffffffef c01faef4 00000010 00000287 ffffffff c023eb6b 00030958
       000000ff c03cfaa4 c0243ca3 c03cfaa4 c03d001c 00000000 c03cfa60 c024069f
Call Trace: [<c0230018>] [<c01faef4>] [<c023eb6b>] [<c0243ca3>] [<c024069f>]
   [<c0240fbd>] [<c0242260>] [<c0105000>] [<c010507a>] [<c0105000>] [<c0105716>]
   [<c0105050>]
Code: f7 fe 89 04 24 50 53 8d 7c 24 34 57 0f b6 44 24 17 50 55 e8

>>EIP; c0243ba9 <piix_set_drive+a9/170>   <=====
Trace; c0230018 <speedo_found1+48/670>
Trace; c01faef4 <__rdtsc_delay+14/20>
Trace; c023eb6b <ide_delay_50ms+1b/30>
Trace; c0243ca3 <piix_tune_drive+33/80>
Trace; c024069f <probe_hwif+25f/280>
Trace; c0240fbd <ideprobe_init+5d/a3>
Trace; c0242260 <get_cmd640_reg_pci2+40/50>
Trace; c0105000 <_stext+0/0>
Trace; c010507a <init+2a/190>
Trace; c0105000 <_stext+0/0>
Trace; c0105716 <kernel_thread+26/30>
Trace; c0105050 <init+0/190>
Code;  c0243ba9 <piix_set_drive+a9/170>
00000000 <_EIP>:
Code;  c0243ba9 <piix_set_drive+a9/170>   <=====
   0:   f7 fe                     idiv   %esi,%eax   <=====
Code;  c0243bab <piix_set_drive+ab/170>
   2:   89 04 24                  mov    %eax,(%esp,1)
Code;  c0243bae <piix_set_drive+ae/170>
   5:   50                        push   %eax
Code;  c0243baf <piix_set_drive+af/170>
   6:   53                        push   %ebx
Code;  c0243bb0 <piix_set_drive+b0/170>
   7:   8d 7c 24 34               lea    0x34(%esp,1),%edi
Code;  c0243bb4 <piix_set_drive+b4/170>
   b:   57                        push   %edi
Code;  c0243bb5 <piix_set_drive+b5/170>
   c:   0f b6 44 24 17            movzbl 0x17(%esp,1),%eax
Code;  c0243bba <piix_set_drive+ba/170>
  11:   50                        push   %eax
Code;  c0243bbb <piix_set_drive+bb/170>
  12:   55                        push   %ebp
Code;  c0243bbc <piix_set_drive+bc/170>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c0243bc1
<piix_set_drive+c1/170>

 <0>Kernel panic: Attempted to kill init!


