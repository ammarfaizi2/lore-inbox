Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265372AbRF2BBP>; Thu, 28 Jun 2001 21:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265371AbRF2BAz>; Thu, 28 Jun 2001 21:00:55 -0400
Received: from [62.81.160.203] ([62.81.160.203]:39148 "EHLO smtp3.eresmas.com")
	by vger.kernel.org with ESMTP id <S265367AbRF2BAv>;
	Thu, 28 Jun 2001 21:00:51 -0400
Date: Fri, 29 Jun 2001 02:54:08 -0400
From: Ignacio Monge <ignaciomonge@navegalia.com>
To: linux-kernel@vger.kernel.org
Subject: Configure and compile errors in 2.4.5ac20 and 1.4.5ac21
Message-Id: <20010629025408.24b0374b.ignaciomonge@navegalia.com>
X-Mailer: Sylpheed version 0.5.0pre2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Output ver_linux:

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11e
mount                  2.11e
modutils               2.4.6
e2fsprogs              1.21
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ppp_async ppp_generic slhc es1371 ac97_codec
soundcore nfsd lockd sunrpc 8139too iptable_nat ip_conntrack ip_tables
reiserfs


ERRORS:
	1.- Entering in "Network Device support"-->Ethernet (10 or 100Mbit) 
--->causes an error:
	 Q> scripts/Menuconfig: MCmenu31: command not found

	2.- PnP Bios compile errors:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon     -DEXPORT_SYMTAB -c
pnp_bios.c
pnp_bios.c: In function `pnp_dock_event':
pnp_bios.c:442: `hotplug_path' undeclared (first use in this function)
pnp_bios.c:442: (Each undeclared identifier is reported only once
pnp_bios.c:442: for each function it appears in.)
pnp_bios.c: In function `pnp_dock_thread':
pnp_bios.c:496: warning: `d' might be used uninitialized in this function
pnp_bios.c: At top level:
pnp_bios.c:597: warning: `pnp_bios_exit' defined but not used
{standard input}: Assembler messages:
{standard input}:64: Warning: indirect lcall without `*'
{standard input}:135: Warning: indirect lcall without `*'
{standard input}:188: Warning: indirect lcall without `*'
{standard input}:229: Warning: indirect lcall without `*'
make[3]: *** [pnp_bios.o] Error 1
make[3]: Saliendo directorio `/usr/src/linux/drivers/pnp'
make[2]: *** [first_rule] Error 2
make[2]: Saliendo directorio `/usr/src/linux/drivers/pnp'
make[1]: *** [_subdir_pnp] Error 2
make[1]: Saliendo directorio `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

	
