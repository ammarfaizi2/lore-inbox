Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277431AbRJEQCC>; Fri, 5 Oct 2001 12:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277432AbRJEQBw>; Fri, 5 Oct 2001 12:01:52 -0400
Received: from smtp.mediascape.net ([212.105.192.20]:42759 "EHLO
	smtp.mediascape.net") by vger.kernel.org with ESMTP
	id <S277431AbRJEQBq>; Fri, 5 Oct 2001 12:01:46 -0400
Message-ID: <3BBDD922.7F3EAA3D@mediascape.de>
Date: Fri, 05 Oct 2001 18:00:34 +0200
From: Olaf Zaplinski <o.zaplinski@mediascape.de>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.11pre4 does not compile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

2.4.11pre4 does not compile on my two (rather different) machines:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.11-pre4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o mpparse.o mpparse.c
mpparse.c: In function `MP_processor_info':
mpparse.c:195: `clustered_apic_mode' undeclared (first use in this function)
mpparse.c:195: (Each undeclared identifier is reported only once
mpparse.c:195: for each function it appears in.)
mpparse.c: In function `smp_read_mpc':
mpparse.c:386: `clustered_apic_mode' undeclared (first use in this function)
make[1]: *** [mpparse.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.11-pre4/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

.config says:
CONFIG_MPENTIUMIII=y
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

On the other one I get the same error. .config:

CONFIG_MK6=y
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y


Olaf
