Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSHNLvF>; Wed, 14 Aug 2002 07:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316933AbSHNLvF>; Wed, 14 Aug 2002 07:51:05 -0400
Received: from wasala.fi ([212.50.129.162]:13068 "EHLO wasala.fi")
	by vger.kernel.org with ESMTP id <S316615AbSHNLvE>;
	Wed, 14 Aug 2002 07:51:04 -0400
Date: Wed, 14 Aug 2002 14:54:55 +0300
From: Antti Salmela <asalmela@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.4.20-pre1-ac3, SMP (Dual PIII)
Message-ID: <20020814145454.A21254@wasala.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oopsed soon after boot up. Stable with vanilla 2.4.19. The board is Intel
SDS2. dnetc was running.

ksymoops 2.4.5 on i686 2.4.19-rc5.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre1-ac3 (specified)
     -m /boot/System.map-2.4.20-pre1-ac3 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 0000002a
c0115d4c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0115d4c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010003
eax: 0000008c   ebx: ffffffd6   ecx: c03268a4   edx: f721c000
esi: c0326880   edi: f721c02c   ebp: f721dfa4   esp: f721df88
ds: 0018   es: 0018   ss: 0018
Process distributed-net (pid: 521, stackpage=f721d000)
Stack: f721c000 00000000 f721c02c c0112f5f 00000000 f721c000 f721c000 f721dfbc 
       c0116cff f721c000 00000043 0003f7a0 c0326880 bffff944 c0106f4b 00000000 
       00000000 40026004 00000043 0003f7a0 bffff944 0000009e 0000002b 0000002b 
Call Trace:    [<c0112f5f>] [<c0116cff>] [<c0106f4b>]
Code: 8b 4b 54 89 4d f4 8b 72 58 85 c9 75 37 89 73 58 f0 ff 46 14 


>>EIP; c0115d4c <schedule+198/384>   <=====

>>ebx; ffffffd6 <END_OF_CODE+3fc5a89a/????>
>>ecx; c03268a4 <runqueues+24/14000>
>>edx; f721c000 <END_OF_CODE+36e768c4/????>
>>esi; c0326880 <runqueues+0/14000>
>>edi; f721c02c <END_OF_CODE+36e768f0/????>
>>ebp; f721dfa4 <END_OF_CODE+36e78868/????>
>>esp; f721df88 <END_OF_CODE+36e7884c/????>

Trace; c0112f5f <smp_apic_timer_interrupt+f3/114>
Trace; c0116cff <sys_sched_yield+113/11c>
Trace; c0106f4b <system_call+33/38>

Code;  c0115d4c <schedule+198/384>
00000000 <_EIP>:
Code;  c0115d4c <schedule+198/384>   <=====
   0:   8b 4b 54                  mov    0x54(%ebx),%ecx   <=====
Code;  c0115d4f <schedule+19b/384>
   3:   89 4d f4                  mov    %ecx,0xfffffff4(%ebp)
Code;  c0115d52 <schedule+19e/384>
   6:   8b 72 58                  mov    0x58(%edx),%esi
Code;  c0115d55 <schedule+1a1/384>
   9:   85 c9                     test   %ecx,%ecx
Code;  c0115d57 <schedule+1a3/384>
   b:   75 37                     jne    44 <_EIP+0x44> c0115d90 <schedule+1dc/384>
Code;  c0115d59 <schedule+1a5/384>
   d:   89 73 58                  mov    %esi,0x58(%ebx)
Code;  c0115d5c <schedule+1a8/384>
  10:   f0 ff 46 14               lock incl 0x14(%esi)

00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:03.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0d)
00:04.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0d)
00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 92)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 92)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05)
00:0f.3 Host bridge: ServerWorks: Unknown device 0230
02:04.0 SCSI storage controller: Adaptec 7899P (rev 01)
02:04.1 SCSI storage controller: Adaptec 7899P (rev 01)

-- 
Antti Salmela
