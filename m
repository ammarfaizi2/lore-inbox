Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUAYNuY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 08:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbUAYNuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 08:50:24 -0500
Received: from mail.g-housing.de ([62.75.136.201]:5033 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264238AbUAYNuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 08:50:15 -0500
Message-ID: <4013C992.3070609@g-house.de>
Date: Sun, 25 Jan 2004 14:50:10 +0100
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031203 Thunderbird/0.4RC2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.2-rc1-mm3 compile error (kgdb)
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020702020708090107040908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020702020708090107040908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,

i was about to compile 2.6.2-rc1-mm3 with kgdb and stuff enabled
(.config attached), but this error occured:

evil@sheep:/data/MP3/scratch/kernel/linux-2.6-mm$ make bzImage modules
make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
~  CHK     include/linux/compile.h
~  UPD     include/linux/compile.h
~  CC      init/version.o
~  LD      init/built-in.o
~  GEN     .version
~  CHK     include/linux/compile.h
~  UPD     include/linux/compile.h
~  CC      init/version.o
~  LD      init/built-in.o
~  LD      .tmp_vmlinux1
arch/ppc/kernel/built-in.o(.text+0x947c): In function `getpacket':
arch/ppc/kernel/ppc-stub.c:350: undefined reference to `getDebugChar'
arch/ppc/kernel/built-in.o(.text+0x9494):arch/ppc/kernel/ppc-stub.c:359:
undefined reference to `getDebugChar'
arch/ppc/kernel/built-in.o(.text+0x9504):arch/ppc/kernel/ppc-stub.c:373:
undefined reference to `getDebugChar'
arch/ppc/kernel/built-in.o(.text+0x9514):arch/ppc/kernel/ppc-stub.c:374:
undefined reference to `getDebugChar'
arch/ppc/kernel/built-in.o(.text+0x9538):arch/ppc/kernel/ppc-stub.c:376:
undefined reference to `putDebugChar'
arch/ppc/kernel/built-in.o(.text+0x9544):arch/ppc/kernel/ppc-stub.c:378:
undefined reference to `putDebugChar'
arch/ppc/kernel/built-in.o(.text+0x9558):arch/ppc/kernel/ppc-stub.c:381:
undefined reference to `putDebugChar'
arch/ppc/kernel/built-in.o(.text+0x9560):arch/ppc/kernel/ppc-stub.c:382:
undefined reference to `putDebugChar'
arch/ppc/kernel/built-in.o(.text+0x95bc): In function `putpacket':
arch/ppc/kernel/ppc-stub.c:402: undefined reference to `putDebugChar'
arch/ppc/kernel/built-in.o(.text+0x95d4):arch/ppc/kernel/ppc-stub.c:412:
more undefined references to `putDebugChar' follow
arch/ppc/kernel/built-in.o(.text+0x95f0): In function `putpacket':
arch/ppc/kernel/ppc-stub.c:415: undefined reference to `getDebugChar'
arch/ppc/kernel/built-in.o(.text+0x961c):arch/ppc/kernel/ppc-stub.c:407:
undefined reference to `putDebugChar'
arch/ppc/kernel/built-in.o(.text+0x9810): In function `handle_exception':
arch/ppc/kernel/ppc-stub.c:589: undefined reference to `kgdb_interruptible'
arch/ppc/kernel/built-in.o(.text+0x9c78):arch/ppc/kernel/ppc-stub.c:781:
undefined reference to `kgdb_interruptible'
arch/ppc/kernel/built-in.o(.init.text+0x82c): In function `setup_arch':
arch/ppc/kernel/setup.c:651: undefined reference to `kgdb_map_scc'
arch/ppc/platforms/built-in.o(.init.text+0x9ac): In function
`pmac_setup_arch':
arch/ppc/platforms/pmac_setup.c:301: undefined reference to `zs_kgdb_hook'
drivers/built-in.o(.text+0x2d200): In function `eth_getDebugChar':
drivers/net/kgdb_eth.c:55: undefined reference to `netpoll_poll'
drivers/built-in.o(.text+0x2d2a8): In function `eth_flushDebugChar':
drivers/net/kgdb_eth.c:66: undefined reference to `netpoll_send_udp'
drivers/built-in.o(.text+0x2d2fc): In function `rx_hook':
drivers/net/kgdb_eth.c:85: undefined reference to `netpoll_trap'
drivers/built-in.o(.text+0x2d3ac):drivers/net/kgdb_eth.c:90: undefined
reference to `kgdb_schedule_breakpoint'
drivers/built-in.o(.text+0x2d3d0):drivers/net/kgdb_eth.c:86: undefined
reference to `kgdb_schedule_breakpoint'
drivers/built-in.o(.text+0x2d3f0): In function `option_setup':
drivers/net/kgdb_eth.c:106: undefined reference to `netpoll_parse_options'
drivers/built-in.o(.text+0x2d440): In function `init_kgdboe':
drivers/net/kgdb_eth.c:129: undefined reference to `netpoll_setup'
make: *** [.tmp_vmlinux1] Error 1

this is on Debian/unstable (PPC32) (PReP),
gcc-Version 3.3.3 20031229 (prerelease)
GNU ld version 2.14.90.0.7 20031029 Debian GNU/Linux
~  Supported emulations:
~   elf32ppclinux
~   elf32ppc
~   elf32ppcsim
~   elf64ppc
glibc Version: 2.3.2.ds1-10

this setup happily compiles other vanilla/slightly patched 2.[4|6].x
kernels with no problems.

Thanks,
Christian.
- --
BOFH excuse #430:

Mouse has out-of-cheese-error
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAE8mS+A7rjkF8z0wRAg4tAJ4oZB4ehBcwvsKAVJynAtNUrJXrmwCeL5v4
2GhQAuSmL9WbNZTBiHgPRRU=
=N9Fs
-----END PGP SIGNATURE-----

--------------020702020708090107040908
Content-Type: text/plain;
 name="config-mm3.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config-mm3.txt"

CiAgICAgIGNhdCAuY29uZmlnIHwgZ3JlcCBeQyA+IH4vY29uZmlnLW1tMy50eHQKCkNPTkZJ
R19NTVU9eQpDT05GSUdfUldTRU1fWENIR0FERF9BTEdPUklUSE09eQpDT05GSUdfSEFWRV9E
RUNfTE9DSz15CkNPTkZJR19QUEM9eQpDT05GSUdfUFBDMzI9eQpDT05GSUdfR0VORVJJQ19O
VlJBTT15CkNPTkZJR19FWFBFUklNRU5UQUw9eQpDT05GSUdfQ0xFQU5fQ09NUElMRT15CkNP
TkZJR19CUk9LRU5fT05fU01QPXkKQ09ORklHX1NXQVA9eQpDT05GSUdfU1lTVklQQz15CkNP
TkZJR19CU0RfUFJPQ0VTU19BQ0NUPXkKQ09ORklHX1NZU0NUTD15CkNPTkZJR19MT0dfQlVG
X1NISUZUPTE0CkNPTkZJR19LQUxMU1lNUz15CkNPTkZJR19GVVRFWD15CkNPTkZJR19FUE9M
TD15CkNPTkZJR19JT1NDSEVEX05PT1A9eQpDT05GSUdfSU9TQ0hFRF9BUz15CkNPTkZJR19J
T1NDSEVEX0RFQURMSU5FPXkKQ09ORklHX0lPU0NIRURfQ0ZRPXkKQ09ORklHX01PRFVMRVM9
eQpDT05GSUdfTU9EVUxFX1VOTE9BRD15CkNPTkZJR19PQlNPTEVURV9NT0RQQVJNPXkKQ09O
RklHX0tNT0Q9eQpDT05GSUdfNnh4PXkKQ09ORklHX1BQQ19TVERfTU1VPXkKQ09ORklHX1BQ
Q19NVUxUSVBMQVRGT1JNPXkKQ09ORklHX1BQQ19DSFJQPXkKQ09ORklHX1BQQ19QTUFDPXkK
Q09ORklHX1BQQ19QUkVQPXkKQ09ORklHX1BQQ19PRj15CkNPTkZJR19QUENCVUdfTlZSQU09
eQpDT05GSUdfS0VSTkVMX0VMRj15CkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0NNRExJ
TkVfQk9PTD15CkNPTkZJR19DTURMSU5FPSJjb25zb2xlPXR0eVMwLDk2MDAgY29uc29sZT10
dHkwIHJvb3Q9L2Rldi9zZGE1IgpDT05GSUdfR0VORVJJQ19JU0FfRE1BPXkKQ09ORklHX1BD
ST15CkNPTkZJR19QQ0lfRE9NQUlOUz15CkNPTkZJR19ISUdITUVNX1NUQVJUPTB4ZmUwMDAw
MDAKQ09ORklHX0xPV01FTV9TSVpFPTB4MzAwMDAwMDAKQ09ORklHX0tFUk5FTF9TVEFSVD0w
eGMwMDAwMDAwCkNPTkZJR19UQVNLX1NJWkU9MHg4MDAwMDAwMApDT05GSUdfQk9PVF9MT0FE
PTB4MDA4MDAwMDAKQ09ORklHX1NDU0k9eQpDT05GSUdfQkxLX0RFVl9TRD15CkNPTkZJR19N
QVhfU0RfRElTS1M9MjU2CkNPTkZJR19TQ1NJX1NZTTUzQzhYWF8yPXkKQ09ORklHX1NDU0lf
U1lNNTNDOFhYX0RNQV9BRERSRVNTSU5HX01PREU9MApDT05GSUdfU0NTSV9TWU01M0M4WFhf
REVGQVVMVF9UQUdTPTE2CkNPTkZJR19TQ1NJX1NZTTUzQzhYWF9NQVhfVEFHUz02NApDT05G
SUdfU0NTSV9RTEEyWFhYX0NPTkZJRz15CkNPTkZJR19ORVQ9eQpDT05GSUdfUEFDS0VUPXkK
Q09ORklHX1BBQ0tFVF9NTUFQPXkKQ09ORklHX1VOSVg9eQpDT05GSUdfSU5FVD15CkNPTkZJ
R19JUFY2X1NDVFBfXz15CkNPTkZJR19ORVRERVZJQ0VTPXkKQ09ORklHX05FVF9FVEhFUk5F
VD15CkNPTkZJR19NSUk9eQpDT05GSUdfTkVUX1ZFTkRPUl8zQ09NPXkKQ09ORklHX1ZPUlRF
WD1tCkNPTkZJR19ORVRfVFVMSVA9eQpDT05GSUdfREUyMTA0WD1tCkNPTkZJR19UVUxJUD1t
CkNPTkZJR19JTlBVVD15CkNPTkZJR19JTlBVVF9NT1VTRURFVj15CkNPTkZJR19JTlBVVF9N
T1VTRURFVl9QU0FVWD15CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWD0xMDI0CkNP
TkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWT03NjgKQ09ORklHX1NPVU5EX0dBTUVQT1JU
PXkKQ09ORklHX1NFUklPPXkKQ09ORklHX0lOUFVUX0tFWUJPQVJEPXkKQ09ORklHX0tFWUJP
QVJEX0FUS0JEPXkKQ09ORklHX1ZUPXkKQ09ORklHX1ZUX0NPTlNPTEU9eQpDT05GSUdfSFdf
Q09OU09MRT15CkNPTkZJR19VTklYOThfUFRZUz15CkNPTkZJR19VTklYOThfUFRZX0NPVU5U
PTI1NgpDT05GSUdfVkdBX0NPTlNPTEU9eQpDT05GSUdfRFVNTVlfQ09OU09MRT15CkNPTkZJ
R19FWFQyX0ZTPXkKQ09ORklHX0VYVDNfRlM9eQpDT05GSUdfSkJEPXkKQ09ORklHX1BST0Nf
RlM9eQpDT05GSUdfUFJPQ19LQ09SRT15CkNPTkZJR19TWVNGUz15CkNPTkZJR19ERVZQVFNf
RlM9eQpDT05GSUdfUkFNRlM9eQpDT05GSUdfTVNET1NfUEFSVElUSU9OPXkKQ09ORklHX0NS
QzMyPW0KQ09ORklHX0RFQlVHX0tFUk5FTD15CkNPTkZJR19NQUdJQ19TWVNSUT15CkNPTkZJ
R19LR0RCPXkKQ09ORklHX0tHREJfVFRZUzE9eQpDT05GSUdfREVCVUdfSU5GTz15CkNPTkZJ
R19CT09UWF9URVhUPXkK
--------------020702020708090107040908--
