Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314392AbSDRQlQ>; Thu, 18 Apr 2002 12:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSDRQlP>; Thu, 18 Apr 2002 12:41:15 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:19889 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S314392AbSDRQlO>;
	Thu, 18 Apr 2002 12:41:14 -0400
Message-ID: <007401c1e6f7$d213d430$e1de11cc@csihq.com>
Reply-To: "Mike Black" <mblack@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-pre7 oops
Date: Thu, 18 Apr 2002 12:40:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without device even mounted or exported this time:
ksymoops 2.4.5 on i686 2.4.19-pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre7/ (default)
     -m /System.map (specified)

Apr 18 12:08:32 yeti kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000006
Apr 18 12:08:32 yeti kernel: f8826437
Apr 18 12:08:32 yeti kernel: *pde = 00000000
Apr 18 12:08:32 yeti kernel: Oops: 0000
Apr 18 12:08:32 yeti kernel: CPU:    1
Apr 18 12:08:32 yeti kernel: EIP:
0010:[nfs:__insmod_nfs_O/lib/modules/2.4.19-pre7/kernel/fs/nfs/nfs.o_+-27744
9/96]    Tainted: P
Apr 18 12:08:32 yeti kernel: EFLAGS: 00010246
Apr 18 12:08:32 yeti kernel: eax: 00000000   ebx: f5870dc0   ecx: 00000002
edx: f5daed60
Apr 18 12:08:32 yeti kernel: esi: f5ab7c00   edi: f5daec00   ebp: f5daec00
esp: f59fbe88
Apr 18 12:08:32 yeti kernel: ds: 0018   es: 0018   ss: 0018
Apr 18 12:08:32 yeti kernel: Process raid5d (pid: 17544, stackpage=f59fb000)
Apr 18 12:08:32 yeti kernel: Stack: 00000000 f5daec00 f5ab7c00 f5fa1de0
00000001 00000001 000000f8 c011cf73
Apr 18 12:08:32 yeti kernel:        00000000 c009ec00 f5ab7d58 f59fbf24
f5ab7cec f5ab7c80 f5daec14 00000000
Apr 18 12:08:32 yeti kernel:        f5ab7c14 00000000 00000001 00000001
00000001 0000000c 00000001 ffffffff
Apr 18 12:08:32 yeti kernel: Call Trace: [tasklet_hi_action+103/160]
[nfs:__insmod_nfs_O/lib/modules/2.4.19-pre7/kernel/fs/nfs/nfs.o_+-275842/96]
[md_thread+341/440] [kernel_thread+40/56]
Apr 18 12:08:32 yeti kernel: Code: 8b 41 04 50 e8 d8 5a 9a c7 00 00 00 00 74
51 83 7c 24 7c 00
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; f5870dc0 <_end+3553350c/384df74c>
>>edx; f5daed60 <_end+35a714ac/384df74c>
>>esi; f5ab7c00 <_end+3577a34c/384df74c>
>>edi; f5daec00 <_end+35a7134c/384df74c>
>>ebp; f5daec00 <_end+35a7134c/384df74c>
>>esp; f59fbe88 <_end+356be5d4/384df74c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  00000003 Before first symbol
   3:   50                        push   %eax
Code;  00000004 Before first symbol
   4:   e8 d8 5a 9a c7            call   c79a5ae1 <_EIP+0xc79a5ae1> c79a5ae1
<_end+766822d/384df74c>
Code;  00000009 Before first symbol
   9:   00 00                     add    %al,(%eax)
Code;  0000000b Before first symbol
   b:   00 00                     add    %al,(%eax)
Code;  0000000d Before first symbol
   d:   74 51                     je     60 <_EIP+0x60> 00000060 Before
first symbol
Code;  0000000f Before first symbol
   f:   83 7c 24 7c 00            cmpl   $0x0,0x7c(%esp,1)

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355
----- Original Message -----
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Sent: Thursday, April 18, 2002 7:56 AM
Subject: 2.4.17-pre7 oops


I've been having problems resyncing my 2TB RAID5 Ultra160 array for every
kernel version I've tried.  Here's the latest.
The drive being resynced is mounted and exported via NFS while it's
resyncing.
I'll try it one more time while it's not exported.



