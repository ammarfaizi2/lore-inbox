Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbTCYQSk>; Tue, 25 Mar 2003 11:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262724AbTCYQSk>; Tue, 25 Mar 2003 11:18:40 -0500
Received: from franka.aracnet.com ([216.99.193.44]:23277 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262721AbTCYQSi>; Tue, 25 Mar 2003 11:18:38 -0500
Date: Tue, 25 Mar 2003 08:29:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 499] New: error linking kernel, cs4232_pnp_remove 
Message-ID: <124760000.1048609782@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=499

           Summary: error linking kernel, cs4232_pnp_remove
    Kernel Version: 2.5.66-bk1
            Status: NEW
          Severity: low
             Owner: bugme-janitors@lists.osdl.org
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: single x86 CPU
Software Environment: 
Linux razor 2.5.65-bk5 #13 Mon Mar 24 10:05:27 EST 2003 i686 Pentium II 
(Klamath) GenuineIntel GNU/Linux

Gnu C                  2.95.4
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
module-init-tools      implemented
e2fsprogs              1.32
reiserfsprogs          3.6.3
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2

CONFIG_SOUND_GAMEPORT=y
CONFIG_SOUND=y
CONFIG_SOUND_PRIME=y
CONFIG_SOUND_OSS=y
CONFIG_SOUND_CS4232=y


Problem Description:
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o 
init/mounts.o init/initramfs.o
        ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o 
arch/i386/kernel/init_task.o   init/built-in.o --start-group
usr/built-in.o   arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o
arch/i386/mach- default/built-in.o  kernel/built-in.o  mm/built-in.o
fs/built-in.o  ipc/built- in.o  security/built-in.o  crypto/built-in.o
lib/lib.a  arch/i386/lib/lib.a   drivers/built-in.o  sound/built-in.o
arch/i386/pci/built-in.o  net/built-in.o - -end-group  -o .tmp_vmlinux1
sound/built-in.o(.text+0xdf33): In function `cs4232_pnp_remove':
: undefined reference to `local symbols in discarded section .exit.text'
make: *** [.tmp_vmlinux1] Error 1

The last kernel I built was 2.5.56-bk5.. it built and linked fine.

There were many changes to the sound/oss/cs4232.c file in the 2.5.66 patch.


