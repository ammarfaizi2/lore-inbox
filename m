Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264214AbRF1UWq>; Thu, 28 Jun 2001 16:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264260AbRF1UWf>; Thu, 28 Jun 2001 16:22:35 -0400
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:25596 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S264214AbRF1UWQ>; Thu, 28 Jun 2001 16:22:16 -0400
Posted-Date: Thu, 28 Jun 2001 22:18:25 +0100 (WEST)
Date: Thu, 28 Jun 2001 22:22:13 +0200
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200106282022.WAA10248@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac20, make menuconfig problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan and others,

I'm trying to build 2.4.5-ac20, I get the following error when entering the
submenu  "Ethernet (10 or 100Mbit)  --->"  of "[*] Network device support"


Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: MCmenu31: command not found

 Please report this to the maintainer <mec@shout.net>.  You may also
 send a problem report to <linux-kernel@vger.kernel.org>.

 Please indicate the kernel version you are trying to configure and
 which menu you were trying to enter when this error occurred.

 make: *** [menuconfig] Erreur 1



If I try to compile this kernel with the .config from -ac19, I get the
following errors :

make[4]: Entre dans le répertoire
`/usr/src/kernel-sources-2.4.5-ac20/drivers/pnp'
gcc -D__KERNEL__ -I/usr/src/kernel-sources-2.4.5-ac20/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-DEXPORT_SYMTAB -c pnp_bios.c
pnp_bios.c:252: warning: static declaration for `pnp_bios_dock_station_info'
follows non-static
pnp_bios.c:432: warning: no semicolon at end of struct or union
pnp_bios.c:432: parse error before `u16'
pnp_bios.c: In function `pnp_dock_thread':
pnp_bios.c:442: warning: function declaration isn't a prototype
pnp_bios.c:442: warning: extern declaration of `daemonize' doesn't match global
one
pnp_bios.c:445: parse error before `struct'
pnp_bios.c:445: warning: unused variable `err'
pnp_bios.c: At top level:
pnp_bios.c:435: storage size of `dock' isn't known
pnp_bios.c:435: warning: `dock' defined but not used
pnp_bios.c:440: warning: `pnp_dock_thread' defined but not used
{standard input}: Assembler messages:
{standard input}:63: Warning: indirect lcall without `*'
{standard input}:144: Warning: indirect lcall without `*'
{standard input}:202: Warning: indirect lcall without `*'
{standard input}:240: Warning: indirect lcall without `*'
make[4]: *** [pnp_bios.o] Erreur 1
make[4]: Quitte le répertoire `/usr/src/kernel-sources-2.4.5-ac20/drivers/pnp'
make[3]: *** [first_rule] Erreur 2
make[3]: Quitte le répertoire `/usr/src/kernel-sources-2.4.5-ac20/drivers/pnp'
make[2]: *** [_subdir_pnp] Erreur 2
make[2]: Quitte le répertoire `/usr/src/kernel-sources-2.4.5-ac20/drivers'
make[1]: *** [_dir_drivers] Erreur 2
make[1]: Quitte le répertoire `/usr/src/kernel-sources-2.4.5-ac20'
make: *** [stamp-build] Erreur 2

------
Regards
		Jean-Luc
