Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSEYGYG>; Sat, 25 May 2002 02:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313789AbSEYGYF>; Sat, 25 May 2002 02:24:05 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:11013 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S313773AbSEYGYD>; Sat, 25 May 2002 02:24:03 -0400
Message-ID: <3CEF2DAA.8030902@megapathdsl.net>
Date: Fri, 24 May 2002 23:22:34 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020518
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.18 -- build failure -- suspend.c:1052: dereferencing pointer
 to incomplete type
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have included the error, the output of ver_linux and
snippets of .config.

gcc -D__KERNEL__ -I/usr/src/linux-2.5.18/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon
  -DKBUILD_BASENAME=suspend -DEXPORT_SYMTAB -c -o suspend.o suspend.c
suspend.c: In function `freeze_processes':
suspend.c:240: warning: implicit declaration of function `signal_wake_up'
suspend.c: In function `fill_suspend_header':
suspend.c:292: warning: comparison between pointer and integer
suspend.c: In function `write_suspend_image':
suspend.c:436: warning: passing arg 3 of `get_swaphandle_info' from 
incompatible pointer type
suspend.c:435: warning: unused variable `dummy2'
suspend.c: In function `count_and_copy_data_pages':
suspend.c:541: warning: passing arg 1 of `mmx_copy_page' makes pointer 
from integer without a cast
suspend.c:541: warning: passing arg 2 of `mmx_copy_page' makes pointer 
from integer without a cast
suspend.c: In function `suspend_save_image':
suspend.c:729: warning: assignment makes integer from pointer without a cast
suspend.c: In function `bdev_read_page':
suspend.c:1051: warning: implicit declaration of function `__bread'
suspend.c:1051: warning: assignment makes pointer from integer without a 
cast
suspend.c:1052: dereferencing pointer to incomplete type
suspend.c:1055: dereferencing pointer to incomplete type
suspend.c:1055: dereferencing pointer to incomplete type
suspend.c:1056: warning: implicit declaration of function `buffer_uptodate'
suspend.c:1057: warning: implicit declaration of function `brelse'
suspend.c: In function `resume_try_to_read':
suspend.c:1071: warning: passing arg 1 of `name_to_kdev_t' discards 
qualifiers from pointer target type
suspend.c:1079: warning: unsigned int format, kdev_t arg (arg 2)
suspend.c:1069: warning: unused variable `blksize'
suspend.c: At top level:
suspend.c:1232: warning: static declaration for `resume_setup' follows 
non-static
make[1]: *** [suspend.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.18/kernel'

I don't know what options might be involved in causing this build
failure, so I will only include some of the higher level ones:

Linux turbulence.megapathdsl.net 2.5.17 #2 Tue May 21 16:06:13 PDT 2002 
i686 unknown

Gnu C                  3.0.4
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.14
e2fsprogs              1.26
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm 
snd-timer snd-hwdep snd-util-mem snd-rawmidi snd-seq-device 
snd-ac97-codec floppy mousedev hid input ohci-hcd ehci-hcd ide-scsi 
ide-cd vfat fat usbcore rtc

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y


