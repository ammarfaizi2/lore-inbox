Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317550AbSHHNvp>; Thu, 8 Aug 2002 09:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317559AbSHHNvp>; Thu, 8 Aug 2002 09:51:45 -0400
Received: from msr91.hinet.net ([168.95.4.191]:10669 "EHLO msr.hinet.net")
	by vger.kernel.org with ESMTP id <S317550AbSHHNvo>;
	Thu, 8 Aug 2002 09:51:44 -0400
Date: Thu, 08 Aug 2002 21:54:53 +0800
From: Tommy Wu <tommy@teatime.com.tw>
To: linux-kernel@vger.kernel.org
Subject: Oops on 2.4.19-rc5aa1 SMP kernel with Tyan K7X + Dual Althon MP 2000+
Reply-To: tommy@teatime.com.tw
Organization: TeaTime Development
Message-Id: <20020808214146.EC51.TOMMY@teatime.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

    MB: Tyan 2468,  AMD 762/768
    CPU: AMD Althon MP 2000+
    RAM: 4G
    SCSI: on-board aic-7899
    HDD: 18G U160
    Kernel: 2.4.19-rc5aa1
    
    I meet a following oops during booting with a SMP enabled kernel, the same kernel work 
    fine with a boot prompt 'nosmp' to disable SMP.
    
    But I've the same environment with the same kernel don't meet suck oops during booting.
    I've tried to change the hdd/ram between the two box, but the one have such problem still
    in there. So, is this a hardware problem of the MB or CPU ? or a bug in kernel ?

ksymoops 2.4.5 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (specified)

Unable to handle kernel paging request at virtual address c3c0ee44
e010a813
*pde = 00000000
Oops: 0002 2.4.19 #1 SMP Thu Aug 8 09:08:29 CST 2002
CPU:    1
EIP:    0010:[<e010a813>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: e0114f70   ebx: e03a3fc0   ecx: 00000040   edx: 00000040
esi: e0366800   edi: 00000001   ebp: e3af9eec   esp: e3af9ed8
ds: 0018   es: 0018   ss: 0018
       00002e94 00000292 00000000 00000000 0028b0c9 00002e00 00000018 00000018
       ffffff00 e032eee2 00000010 00000292 e032eeff e3af8000 e0113ef0 e02b4de0
Call Trace:    [<e010cec8>] [<e0113ef0>] [<e01139da>] [<e010d7fa>] [<e011b10f>]
 [<e011b00e>]
Code: 00 74 05 e8 85 4f 01 00 b8 01 00 00 00 8d 65 ec 5b 5e 5f 89


>>EIP; e010a813 <do_IRQ+103/120>   <=====

>>eax; e0114f70 <end_edge_ioapic_irq+0/10>
>>ebx; e03a3fc0 <irq_stat+0/800>
>>esi; e0366800 <irq_desc+0/3800>
>>ebp; e3af9eec <_end+3706778/440c88c>
>>esp; e3af9ed8 <_end+3706764/440c88c>

Trace; e010cec8 <call_do_IRQ+5/d>
Trace; e0113ef0 <setup_APIC_timer+40/d0>
Trace; e01139da <smp_call_function_interrupt+2a/42>
Trace; e010d7fa <call_call_function_interrupt+5/b>
Trace; e011b10f <release_console_sem+8f/a0>
Trace; e011b00e <printk+11e/140>

Code;  e010a813 <do_IRQ+103/120>
00000000 <_EIP>:
Code;  e010a813 <do_IRQ+103/120>   <=====
   0:   00 74 05 e8               add    %dh,0xffffffe8(%ebp,%eax,1)   <=====
Code;  e010a817 <do_IRQ+107/120>
   4:   85 4f 01                  test   %ecx,0x1(%edi)
Code;  e010a81a <do_IRQ+10a/120>
   7:   00 b8 01 00 00 00         add    %bh,0x1(%eax)
Code;  e010a820 <do_IRQ+110/120>
   d:   8d 65 ec                  lea    0xffffffec(%ebp),%esp
Code;  e010a823 <do_IRQ+113/120>
  10:   5b                        pop    %ebx
Code;  e010a824 <do_IRQ+114/120>
  11:   5e                        pop    %esi
Code;  e010a825 <do_IRQ+115/120>
  12:   5f                        pop    %edi
Code;  e010a826 <do_IRQ+116/120>
  13:   89 00                     mov    %eax,(%eax)

 <0>Kernel panic: Attempted to kill the idle task!



-- 

    Tommy Wu
    mailto:tommy@teatime.com.tw
    http://www.teatime.com.tw/~tommy
    ICQ: 22766091
    Mobile Phone: +886 936 909490
    TeaTime BBS +886 2 31515964 24Hrs V.Everything


