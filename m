Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269135AbUHYBpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269135AbUHYBpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 21:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269130AbUHYBnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 21:43:47 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:23737 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S269126AbUHYBmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 21:42:35 -0400
Message-ID: <021101c48a44$c8f846e0$6401a8c0@novustelecom.net>
From: "Zarakin" <zarakin@hotpop.com>
To: <linux-kernel@vger.kernel.org>
Subject: nmi_watchdog=2 - Oops with 2.6.8
Date: Tue, 24 Aug 2004 18:42:29 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My Gentoo machine will not boot with nmi_watchdog=2 parameter - I get an
oops at clear_msr_range.

Handwritten oops Info:
CPU 0
EIP:  0060: [<0xc0110d4b>] Not tainted
EIP is at clear_msr_range+0x18/0x25
eax: 0  ebx:1f  ecx: 3ba  edx: 0
esi: 3a0  edi: 1a  ebp:0 esp: d7d83f74
ds: 7b es: 7b ss: 68

Dump of assembler code for function clear_msr_range:
0xc0110d33 <clear_msr_range+0>: push   %edi
0xc0110d34 <clear_msr_range+1>: xor    %edi,%edi
0xc0110d36 <clear_msr_range+3>: push   %esi
0xc0110d37 <clear_msr_range+4>: push   %ebx
0xc0110d38 <clear_msr_range+5>: mov    0x14(%esp,1),%ebx
0xc0110d3c <clear_msr_range+9>: mov    0x10(%esp,1),%esi
0xc0110d40 <clear_msr_range+13>:        cmp    %ebx,%edi
0xc0110d42 <clear_msr_range+15>:        jae    0xc0110d54
0xc0110d44 <clear_msr_range+17>:        xor    %eax,%eax
0xc0110d46 <clear_msr_range+19>:        lea    (%edi,%esi,1),%ecx
0xc0110d49 <clear_msr_range+22>:        mov    %eax,%edx
0xc0110d4b <clear_msr_range+24>:        wrmsr
0xc0110d4d <clear_msr_range+26>:        add    $0x1,%edi
0xc0110d50 <clear_msr_range+29>:        cmp    %ebx,%edi
0xc0110d52 <clear_msr_range+31>:        jb     0xc0110d46
0xc0110d54 <clear_msr_range+33>:        pop    %ebx
0xc0110d55 <clear_msr_range+34>:        pop    %esi
0xc0110d56 <clear_msr_range+35>:        pop    %edi
0xc0110d57 <clear_msr_range+36>:        ret

HW Info:
* Shuttle ST61G4 Box -
http://www.shuttle.com/hq/product/barebone/specification.asp?B_id=28
* Chipsets: North bridge:ATI RS300 South bridge:ATI IXP150
* Intel P4 2.8E GHz (Prescott)

cat /proc/version:
Linux version 2.6.8-gentoo (root@tux) (gcc version 3.3.3 20040412 (Gentoo
Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #1 Mon Aug 23 21:09:40 PDT 2004

cat /proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 3
cpu MHz         : 2794.263
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor
ds_cpl cid
bogomips        : 5554.17

Processor section from my .config
#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y


