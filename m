Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317275AbSFCFUr>; Mon, 3 Jun 2002 01:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317276AbSFCFUq>; Mon, 3 Jun 2002 01:20:46 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:39186 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S317275AbSFCFUp>; Mon, 3 Jun 2002 01:20:45 -0400
Subject: 2.5.20 -- mpparse.c:1123: `mp_ioapic_routing' undeclared
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 02 Jun 2002 22:18:53 -0700
Message-Id: <1023081534.1684.26.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon    
-DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
mpparse.c: In function `mp_parse_prt':
mpparse.c:1120: warning: implicit declaration of function
`mp_find_ioapic'
mpparse.c:1123: `mp_ioapic_routing' undeclared (first use in this
function)
mpparse.c:1123: (Each undeclared identifier is reported only once
mpparse.c:1123: for each function it appears in.)
mpparse.c:1147: warning: implicit declaration of function
`io_apic_set_pci_routing'
make[1]: *** [mpparse.o] Error 1
make[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'

I think this snippet of .config is enough.  Please let
me know if you need more.

CONFIG_X86=y
CONFIG_MODULES=y
CONFIG_MK7=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_HAVE_DEC_LOCK=y

Linux turbulence.megapathdsl.net 2.4.7-10 #1 Thu Sep 6 16:46:36 EDT 2001
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
Modules Loaded         emu10k1 soundcore sr_mod binfmt_misc ds
yenta_socket pcmcia_core autofs 3c59x appletalk ipx ipchains ide-scsi
ide-cd cdrom reiserfs nls_iso8859-1 nls_cp437 vfat fat mousedev hid
input usb-ohci usbcore ext3 jbd raid0 aic7xxx sd_mod scsi_mod


