Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312076AbSDXNVg>; Wed, 24 Apr 2002 09:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312134AbSDXNVf>; Wed, 24 Apr 2002 09:21:35 -0400
Received: from smokey.blackcatnetworks.co.uk ([212.135.138.139]:58579 "EHLO
	smokey.blackcatnetworks.co.uk") by vger.kernel.org with ESMTP
	id <S312076AbSDXNVd>; Wed, 24 Apr 2002 09:21:33 -0400
Date: Wed, 24 Apr 2002 14:21:32 +0100
From: Alex Walker <alex@x3ja.co.uk>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.10: 2 OOPs - "BUG at usb.c" and "unable to handle kernel paging request"
Message-ID: <20020424142132.K23497@x3ja.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, I'm not subscribed - please CC me in any replies.

Two OOps when running 2.5.10, as attached. With attatched config.

First occurs on boot, but doesn't stop the whole system.  The second
occurs as I was rebooting - see the attached log to see where they
happen.

Any more info required?  Just ask.

Alex.

-- 
\\\\\\    You know it's Monday when you wake up and it's Tuesday.     //////
\\\\                             -- Garfield                            ////
\\                                                                        //

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksym-2.5.10-1"

ksymoops 2.4.5 on i686 2.4.18.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.10/ (specified)
     -m /boot/System.map-2.5.10 (specified)

No modules in ksyms, skipping objects
cpu: 0, clocks: 1328904, slice: 664452
kernel BUG at usb.c:856!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0202ace>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: d3da1600   ecx: ffffe21a   edx: 00000002
esi: d3da1600   edi: 00000001   ebp: d3da1200   esp: d3e6df64
ds: 0018   es: 0018   ss: 0018
Stack: d3da173c c0205c5d d3da1600 00000001 00000002 d3da1200 d3d9b860 c02d0264 
       d3da13b8 00000004 d3da13b8 000000c8 c0205e09 d3d9b860 00000001 00000301 
       00000001 d3e6c000 d3e6c000 d3e6dfe0 0008e000 d3d9b888 d3e6dfc8 d3d9b888 
Call Trace: [<c0205c5d>] [<c0205e09>] [<c0205fd5>] [<c010560c>] 
Code: 0f 0b 58 03 f4 f9 29 c0 8b 83 cc 00 00 00 8b 40 1c 53 8b 40 


>>EIP; c0202ace <usb_free_dev+26/5c>   <=====

>>ebx; d3da1600 <END_OF_CODE+13a5a584/????>
>>ecx; ffffe21a <END_OF_CODE+3fcb719e/????>
>>esi; d3da1600 <END_OF_CODE+13a5a584/????>
>>ebp; d3da1200 <END_OF_CODE+13a5a184/????>
>>esp; d3e6df64 <END_OF_CODE+13b26ee8/????>

Trace; c0205c5d <usb_hub_port_connect_change+229/2bc>
Trace; c0205e09 <usb_hub_events+119/2a0>
Trace; c0205fd5 <usb_hub_thread+45/10c>
Trace; c010560c <kernel_thread+28/38>

Code;  c0202ace <usb_free_dev+26/5c>
00000000 <_EIP>:
Code;  c0202ace <usb_free_dev+26/5c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0202ad0 <usb_free_dev+28/5c>
   2:   58                        pop    %eax
Code;  c0202ad1 <usb_free_dev+29/5c>
   3:   03 f4                     add    %esp,%esi
Code;  c0202ad3 <usb_free_dev+2b/5c>
   5:   f9                        stc    
Code;  c0202ad4 <usb_free_dev+2c/5c>
   6:   29 c0                     sub    %eax,%eax
Code;  c0202ad6 <usb_free_dev+2e/5c>
   8:   8b 83 cc 00 00 00         mov    0xcc(%ebx),%eax
Code;  c0202adc <usb_free_dev+34/5c>
   e:   8b 40 1c                  mov    0x1c(%eax),%eax
Code;  c0202adf <usb_free_dev+37/5c>
  11:   53                        push   %ebx
Code;  c0202ae0 <usb_free_dev+38/5c>
  12:   8b 40 00                  mov    0x0(%eax),%eax

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksym-2.5.10-2"

ksymoops 2.4.5 on i686 2.4.18.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.10/ (specified)
     -m /boot/System.map-2.5.10 (specified)

Unable to handle kernel paging request at virtual address d4bedecc
d4bedecc
*pde = 13eb4067
Oops: 0000
CPU:    0
EIP:    0010:[<d4bedecc>]    Tainted: P  
EFLAGS: 00010286
eax: d4bedecc   ebx: d29de580   ecx: d4be2bd8   edx: d4be2bc4
esi: d29de660   edi: d29de580   ebp: d29de658   esp: d1c09f5c
ds: 0018   es: 0018   ss: 0018
Stack: d4be0d34 d29de580 d29db898 d4be0f3a d29de580 d29db898 fffffff0 d1caf000 
       d4be0000 d4be2bd8 d4be224c d29de580 d4be0000 c0118627 d4be0000 fffffff0 
       d1caf000 bfffed9c c01178a9 d4be0000 00000000 d1c08000 00000001 bfffed9c 
Call Trace: [<d4be0d34>] [<d4be0f3a>] [<d4be2bd8>] [<d4be224c>] [<c0118627>] 
   [<c01178a9>] [<c0106f1f>] 
Code:  Bad EIP value.


>>EIP; d4bedecc <END_OF_CODE+148a6e50/????>   <=====

>>eax; d4bedecc <END_OF_CODE+148a6e50/????>
>>ebx; d29de580 <END_OF_CODE+12697504/????>
>>ecx; d4be2bd8 <END_OF_CODE+1489bb5c/????>
>>edx; d4be2bc4 <END_OF_CODE+1489bb48/????>
>>esi; d29de660 <END_OF_CODE+126975e4/????>
>>edi; d29de580 <END_OF_CODE+12697504/????>
>>ebp; d29de658 <END_OF_CODE+126975dc/????>
>>esp; d1c09f5c <END_OF_CODE+118c2ee0/????>

Trace; d4be0d34 <END_OF_CODE+14899cb8/????>
Trace; d4be0f3a <END_OF_CODE+14899ebe/????>
Trace; d4be2bd8 <END_OF_CODE+1489bb5c/????>
Trace; d4be224c <END_OF_CODE+1489b1d0/????>
Trace; c0118627 <free_module+17/c0>
Trace; c01178a9 <sys_delete_module+12d/27c>
Trace; c0106f1f <syscall_call+7/b>


--ReaqsoxgOBHFXBhH
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="log-2.5.10.gz"
Content-Transfer-Encoding: base64

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

--ReaqsoxgOBHFXBhH
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config-2.5.10.gz"
Content-Transfer-Encoding: base64

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
So3w/9kgbJcPWQAA

--ReaqsoxgOBHFXBhH--
