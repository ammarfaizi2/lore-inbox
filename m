Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSFCDuz>; Sun, 2 Jun 2002 23:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317262AbSFCDuy>; Sun, 2 Jun 2002 23:50:54 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:31616 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S314077AbSFCDuw>; Sun, 2 Jun 2002 23:50:52 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.20 - compile error, mp_ioapic_routing on a uniprocessor machine
Date: Sat, 1 Jun 2002 21:51:18 -0600
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200206012151.18394.ivangurdiev@linuxfreemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Entering directory `/usr/src/linux-2.5.20/arch/i386/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.20/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon     
-DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
mpparse.c: In function `mp_parse_prt':
mpparse.c:1120: warning: implicit declaration of function `mp_find_ioapic'
mpparse.c:1123: `mp_ioapic_routing' undeclared (first use in this function)
mpparse.c:1123: (Each undeclared identifier is reported only once
mpparse.c:1123: for each function it appears in.)
mpparse.c:1147: warning: implicit declaration of function 
`io_apic_set_pci_routing'
make[1]: *** [mpparse.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.20/arch/i386/kernel'
make: *** [arch/i386/kernel] Error 2

========================
Relevant CONFIG.H:

#define CONFIG_MK7 1
#undef  CONFIG_SMP
#define CONFIG_X86_UP_APIC 1
#undef  CONFIG_X86_UP_IOAPIC
#define CONFIG_X86_LOCAL_APIC 1
#define CONFIG_ACPI 1
#undef  CONFIG_ACPI_HT_ONLY
#define CONFIG_ACPI_BOOT 1
#define CONFIG_ACPI_BUS 1
#define CONFIG_ACPI_INTERPRETER 1
#define CONFIG_ACPI_EC 1
#define CONFIG_ACPI_POWER 1
#define CONFIG_ACPI_PCI 1
#define CONFIG_ACPI_SLEEP 1
#define CONFIG_ACPI_SYSTEM 1
#undef  CONFIG_ACPI_AC
#undef  CONFIG_ACPI_BATTERY
#undef  CONFIG_ACPI_BUTTON
#define CONFIG_ACPI_FAN 1
#define CONFIG_ACPI_PROCESSOR 1
#define CONFIG_ACPI_THERMAL 1
#undef  CONFIG_ACPI_DEBUG

if-def trouble again?

i apologize if you have problems cc-ing...
linuxfreemail is not working correctly, it appears.
I read the LKML archives so I'll get any replies by HTML if not otherwise :)






