Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313016AbSD2VVi>; Mon, 29 Apr 2002 17:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313019AbSD2VVh>; Mon, 29 Apr 2002 17:21:37 -0400
Received: from heavymos.kumin.ne.jp ([61.114.158.133]:24073 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S313016AbSD2VVg>; Mon, 29 Apr 2002 17:21:36 -0400
Message-Id: <200204292121.AA00057@prism.kumin.ne.jp>
Date: Tue, 30 Apr 2002 06:21:25 +0900
To: morten.helgesen@nextframe.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.11 compile error ( without framebuffer )
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
In-Reply-To: <20020429135621.B118@sexything>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.
I sucess to boot linux-2.5.11.

>well, the P4/Xeon Thermal stuff depends on APIC support ... bluesmoke.c uses 
>ack_APIC_irq() and friends.

I change kernel configuration that is Processor type and features section.
Already I set off "Symmetric multi-processing support".
Now I add to set on "Local APIC support on uniprocessorts" and "IO-APIC support
on uniprocessors", then I compile kernel, few waring displayed , but boot up successful.

== compile error messages == 

ide.c: In function `reset_pollfunc':
ide.c:603: warning: assignment discards qualifiers from pointer target type
eepro100.c:2252: warning: `eepro100_remove_one' defined but not used
io_apic.c:221: warning: `move' defined but not used
bsetup.s: Assembler messages:
bsetup.s:979: Warning: Value 0x37ffffff truncated to 0x37ffffff.
Root device is (3, 4)
Boot sector 512 bytes.
Setup is 4768 bytes.
System is 675 kB

== my kernel configuration ( Processor type and featrures section only )

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
