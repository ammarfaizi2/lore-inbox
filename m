Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266433AbSKZR3t>; Tue, 26 Nov 2002 12:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbSKZR3t>; Tue, 26 Nov 2002 12:29:49 -0500
Received: from tao.natur.cuni.cz ([195.113.56.1]:19472 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id <S266433AbSKZR3r>;
	Tue, 26 Nov 2002 12:29:47 -0500
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Tue, 26 Nov 2002 18:37:02 +0100 (CET)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic with 2.4.20-rc3
In-Reply-To: <Pine.OSF.4.44.0211261616490.71135-100000@tao.natur.cuni.cz>
Message-ID: <Pine.OSF.4.44.0211261818310.84542-100000@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Martin MOKREJ© wrote:

Hi,
  I should say the kernel panic I got during bootup process, and here I've
tried to resolve some addresses. Home this makes sense to you:

ksymoops 2.4.6 on i686 2.4.19.  Options used
     -v /usr/src/linux-2.4.19/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.20-rc3/kernel/drivers/ide/ide-cd.o -o /lib/modules/2.4.20-rc3/kernel/drivers/block/nbd.o -o /lib/modules/
2.4.20-rc3/kernel/fs/binfmt_misc.o -o /lib/modules/2.4.20-rc3/kernel/fs/nls/nls_cp1250.o -o /lib/modules/2.4.20-rc3/kernel/arch/i3
86/kernel/cpuid.o (specified)
     -m /boot/System.map-2.4.20-rc3 (specified)

No modules in ksyms, skipping objects
Error (regular_file): Oops_next_file /lib/modules/2.4.20-rc3/kernel/fs/nls is not a regular file, ignored
Unable to handle kernel NULL pointer dereference at virtual address 00000026
c01cd7fd
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c01cd7fd>]          Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000 ebx: 00000000 ecx: c031a070 edx: 00001022
esi: c034ffc4 edi: 00000000 ebp: 0008e000 esp: c1c17fc8
ds: 0018 es: 0018 ss:0018
Stack: c036922c c035cf24 c02c5c12 c02c5c09 c035075a 00010f00 c035079f c0105037
       00010f00 c034ffc4 c01055b8 00000000 00000078 0009fe00
Call trace: [<c0105037>][<c0155b8>]
Code: 0f b7 40 26 3d 13 74 00 00 74 09 3d 43 74 00 00 74 11 eb 1f


>>EIP; c01cd7fd <amd76x_pm_main+7d/130>   <=====

>>ecx; c031a070 <amd_sb_tbl+38/68>
>>esi; c034ffc4 <init_task_union+1fc4/2000>

Trace; c0105037 <init+7/110>
Trace; 0c0155b8 Before first symbol

Code;  c01cd7fd <amd76x_pm_main+7d/130>
00000000 <_EIP>:
Code;  c01cd7fd <amd76x_pm_main+7d/130>   <=====
   0:   0f b7 40 26               movzwl 0x26(%eax),%eax   <=====
Code;  c01cd801 <amd76x_pm_main+81/130>
   4:   3d 13 74 00 00            cmp    $0x7413,%eax
Code;  c01cd806 <amd76x_pm_main+86/130>
   9:   74 09                     je     14 <_EIP+0x14> c01cd811 <amd76x_pm_main+91/130>
Code;  c01cd808 <amd76x_pm_main+88/130>
   b:   3d 43 74 00 00            cmp    $0x7443,%eax
Code;  c01cd80d <amd76x_pm_main+8d/130>
  10:   74 11                     je     23 <_EIP+0x23> c01cd820 <amd76x_pm_main+a0/130>
Code;  c01cd80f <amd76x_pm_main+8f/130>
  12:   eb 1f                     jmp    33 <_EIP+0x33> c01cd830 <amd76x_pm_main+b0/130>

<0> Kernel panic: Attempted to kill init!

1 error issued.  Results may not be reliable.


> Hi,
>   I have a kernel panic on ASUS A7V333 ACPI BIOS Rev 1014 Beta 002 system,
> no SMP kernel, HIGMEM enabled with Athlon 2000+:
>
> BTW: Would someone tell me how to save the stack trace, so I do not have
> to write it down manually? Thanks. ;)
>
> On the console is left:
>
> Real Time Clock Driver: v1.10e
> amd76x_pm: version 20020730
> Unable to handle kernel NULL pointer dereference at virtual address 00000026
> printing eip:
> c01cd7fd
> *pde = 00000000
> Oops: 0000
> CPU: 0
> EIP: 0010:[<c01cd7fd>]		Not tainted
> EFLAGS: 00010246
> eax: 00000000 ebx: 00000000 ecx: c031a070 edx: 00001022
> esi: c034ffc4 edi: 00000000 ebp: 0008e000 esp: c1c17fc8
> ds: 0018 es: 0018 ss:0018
> Process swapper (pid: 1, stackpage = c1c17000)
> Stack: c036922c c035cf24 c02c5c12 c02c5c09 c035075a 00010f00 c035079f c0105037
> 	00010f00 c034ffc4 c01055b8 00000000 00000078 0009fe00
> Call trace: [<c0105037>][<c0155b8>]
> Code: 0f b7 40 26 3d 13 74 00 00 74 09 3d 43 74 00 00 74 11 eb 1f
> <0> Kernel panic: Attempted to kill init!
>
> after a while appeared
>
> spurious 8259A interrupt: IRQ7
>
> Needless to say this surious interrupt I've seen also on this machine running 2.4.19 kernel.
>
> Any ideas what should I do? I'm a bit new to debugging kernel. ;)
> Please Cc: me in replies. Thanks!
>

-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585


