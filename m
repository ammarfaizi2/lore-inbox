Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317682AbSGUOjo>; Sun, 21 Jul 2002 10:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317683AbSGUOjo>; Sun, 21 Jul 2002 10:39:44 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:5853 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317682AbSGUOjn>; Sun, 21 Jul 2002 10:39:43 -0400
Date: Sun, 21 Jul 2002 16:42:12 +0200
From: axel@hh59.org
To: linux-kernel@vger.kernel.org
Cc: jfs-discussion@www-124.southbury.usf.ibm.com, shaggy@austin.ibm.com
Subject: Re: 2.5.27: Software Suspend failure / JFS errors
Message-ID: <20020721144212.GA23767@neon.hh59.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	jfs-discussion@oss.software.ibm.com, shaggy@austin.ibm.com
References: <20020721122932.GA23552@neon.hh59.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020721122932.GA23552@neon.hh59.org>
User-Agent: Mutt/1.4i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This oops occurred during build of gcc..
Kernel 2.4.19-rc2-ac2.
About the same happens with 2.5.27. I will post an oops of jfsCommit of
2.5.27 as soon as I get one.

ksymoops 2.4.5 on i686 2.4.19-rc2-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc2-ac2/ (default)
     -m /boot/System.map-2.4.19-rc2-ac2 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000018
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c018b565>]       Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c7e5c000 ebx: c8802490 ecx: 00000000 edx: 00000000
esi: c8802490 edi: c880cf58 ebp: c7dbd980 esp: c7e5df58
ds: 0018 es: 0018 ss: 0018
Process jfsCommit (pid: 8, stackpage=c7e5d000)
Stack: 000000b1 c0190800 00000000 00000000 00000000 00000286 00000000
00000040
       c7e5e000 c0118486 c7e5dfa8 c7e5c000 c8802490 c8802490 c7e5c000
00000001
       c0190fb3 c8802490 c7e5c000 00000246 c8802490 c01911db c8802490
c7e5c000
Call Trace: [<c0190800>] [<c0118486>] [<c0190fb3>] [<c01911db>] [<c0105000>]
            [<c010739e>] [<c0191080>]
Code: ff 41 18 85 d2 74 34 31 c0 0f ab 41 14 19 c0 85 c0 74 09 b8


>>EIP; c018b565 <hold_metapage+15/70>   <=====

>>eax; c7e5c000 <_end+7b3e314/85ff314>
>>ebx; c8802490 <_end+84e47a4/85ff314>
>>esi; c8802490 <_end+84e47a4/85ff314>
>>edi; c880cf58 <_end+84ef26c/85ff314>
>>ebp; c7dbd980 <_end+7a9fc94/85ff314>
>>esp; c7e5df58 <_end+7b4026c/85ff314>

Trace; c0190800 <txUpdateMap+2c0/2d0>
Trace; c0118486 <schedule+1a6/310>
Trace; c0190fb3 <txLazyCommit+23/f0>
Trace; c01911db <jfs_lazycommit+15b/250>
Trace; c0105000 <_stext+0/0>
Trace; c010739e <kernel_thread+2e/40>
Trace; c0191080 <jfs_lazycommit+0/250>

Code;  c018b565 <hold_metapage+15/70>
00000000 <_EIP>:
Code;  c018b565 <hold_metapage+15/70>   <=====
   0:   ff 41 18                  incl   0x18(%ecx)   <=====
Code;  c018b568 <hold_metapage+18/70>
   3:   85 d2                     test   %edx,%edx
Code;  c018b56a <hold_metapage+1a/70>
   5:   74 34                     je     3b <_EIP+0x3b> c018b5a0
<hold_metapage+50/70>
Code;  c018b56c <hold_metapage+1c/70>
   7:   31 c0                     xor    %eax,%eax
Code;  c018b56e <hold_metapage+1e/70>
   9:   0f ab 41 14               bts    %eax,0x14(%ecx)
Code;  c018b572 <hold_metapage+22/70>
   d:   19 c0                     sbb    %eax,%eax
Code;  c018b574 <hold_metapage+24/70>
   f:   85 c0                     test   %eax,%eax
Code;  c018b576 <hold_metapage+26/70>
  11:   74 09                     je     1c <_EIP+0x1c> c018b581
<hold_metapage+31/70>
Code;  c018b578 <hold_metapage+28/70>
  13:   b8 00 00 00 00            mov    $0x0,%eax


Regards,
Axel Siebenwirth
