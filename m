Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262409AbSI2HoB>; Sun, 29 Sep 2002 03:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262410AbSI2HoB>; Sun, 29 Sep 2002 03:44:01 -0400
Received: from starcraft.mweb.co.za ([196.2.45.78]:17546 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id <S262409AbSI2HoA>; Sun, 29 Sep 2002 03:44:00 -0400
Subject: Re: Kernel Panic 2.5.39
From: Bongani <bonganilinux@mweb.co.za>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1033247487.1742.19.camel@localhost.localdomain>
References: <1033247487.1742.19.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 29 Sep 2002 09:52:15 +0200
Message-Id: <1033285941.1729.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have capture most of the oops (by hand) and ran it through ksymoops
and here is the output. I hope this is helpful.
 
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0255da2>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000000   ebx: c1399c00     ecx: 00000400       edx: 00003b13
esi: 00000000   edi: fffffff6     ebp: c039ff04       esp: c039fee8
ds: 0068        es: 0068       ss: 0068
Stack:  c039e000 c039e000 c039e000 c039e000 c03fc180 c1399c00 00000000
c039ff1c
        c025150b c1399c00 c0121596 00000001 c03fc198 c039ff38 c01213c5
c03fc198
        00000046 c039e000 c039e000 00000000 c039ff60 c010b789 00000000
c039ff68
Call Trace:     [<c025150b>]scsi_softirq+0x4b/0xf0
               [<c0121596>]tasklet_hi_action+0x46/0x70
               [<c01213c5>]do_softirq+0xb5/0xc0
               [<c010b789>]do_IRQ+0x109/0x130
               [<c010a000>]common_interrupt+0x18/0x20
               [<c01ef10d>]acpi_processor_idle+0x17d/0x240
               [<c01eefdc>]acpi_processor_idle+0x4c/0x240
               [<c01eef90>]acpi_processor_idle+0x0/0x240
               [<c01072e0>]default_idle+0x0/0x40
               [<c0107399>]cpu_idle+0x3a/0x50
               [<c0105000>]stext+0x0/0x30
Code: f6 81 24 01 00 00 01 74 35 0f b6 83 32 01 00 00 8b 93 30 01


>>EIP; c0255da2 <scsi_decide_disposition+12/160>   <=====

>>ebx; c1399c00 <_end+e991c1/10321621>
>>edx; 00003b13 Before first symbol
>>edi; fffffff6 <END_OF_CODE+2f773497/????>
>>ebp; c039ff04 <init_thread_union+1f04/2000>
>>esp; c039fee8 <init_thread_union+1ee8/2000>

Trace; c025150b <scsi_softirq+4b/f0>
Trace; c0121596 <tasklet_hi_action+46/70>
Trace; c01213c5 <do_softirq+b5/c0>
Trace; c010b789 <do_IRQ+109/130>
Trace; c010a000 <common_interrupt+18/20>
Trace; c01ef10d <acpi_processor_idle+17d/240>
Trace; c01eefdc <acpi_processor_idle+4c/240>
Trace; c01eef90 <acpi_processor_idle+0/240>
Trace; c01072e0 <default_idle+0/40>
Trace; c0107399 <cpu_idle+39/50>
Trace; c0105000 <_stext+0/0>

Code;  c0255da2 <scsi_decide_disposition+12/160>
00000000 <_EIP>:
Code;  c0255da2 <scsi_decide_disposition+12/160>   <=====
   0:   f6 81 24 01 00 00 01      testb  $0x1,0x124(%ecx)   <=====
Code;  c0255da9 <scsi_decide_disposition+19/160>
   7:   74 35                     je     3e <_EIP+0x3e> c0255de0
<scsi_decide_disposition+50/160>
Code;  c0255dab <scsi_decide_disposition+1b/160>
   9:   0f b6 83 32 01 00 00      movzbl 0x132(%ebx),%eax
Code;  c0255db2 <scsi_decide_disposition+22/160>
  10:   8b 93 30 01 00 00         mov    0x130(%ebx),%edx

 <0>Kernel painc: Aiee, killing interrupt handler!



