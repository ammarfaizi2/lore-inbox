Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266708AbTAZO4O>; Sun, 26 Jan 2003 09:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbTAZO4O>; Sun, 26 Jan 2003 09:56:14 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:45705 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S266708AbTAZOzq>;
	Sun, 26 Jan 2003 09:55:46 -0500
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: ATA TCQ  problems in 2.5.59
Date: Sun, 26 Jan 2003 16:05:00 +0100
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_CWTBM88NZ6FX39OTVT29"
Message-Id: <200301261605.00539.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_CWTBM88NZ6FX39OTVT29
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

hi

I'm trying to turn on TCQ on 2.5.59, but it doesn't seem be able to set i=
t to=20
anything but 0 and 1. This is with TCQ default 'off':

# cat /proc/ide/hda/settings | grep using_tcq
using_tcq               0               0               32              r=
w
# echo using_tcq:32 > /proc/ide/hda/settings
# cat /proc/ide/hda/settings | grep using_tcq
using_tcq               1               0               32              r=
w
#

rebuilding kernel set to TCQ default 'on', I get this

# cat /proc/ide/hda/settings |grep tcq
using_tcq               1               0               32              r=
w
# echo using_tcq:32 > /proc/ide/hda/settings
# cat /proc/ide/hda/settings |grep tcq
using_tcq               1               0               32              r=
w
#

=2E..so TCQ can't be set > 1. Attached is ispci, dmesg and some /proc/ide=
 stuff=20
I found interesting (or something). Disk drive is a 60gig IBM 120GXP.

Thanks


--=20
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

--------------Boundary-00=_CWTBM88NZ6FX39OTVT29
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg"

Linux version 2.5.59 (root@tonje) (gcc version 2.95.4 20011002 (Debian prerelease)) #10 Sun Jan 26 14:47:39 CET 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f7f0000 (usable)
 BIOS-e820: 000000001f7f0000 - 000000001f7f3000 (ACPI NVS)
 BIOS-e820: 000000001f7f3000 - 000000001f800000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
503MB LOWMEM available.
On node 0 totalpages: 129008
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 124912 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 VIA694                     ) @ 0x000f7840
ACPI: RSDT (v001 VIA694 MSI ACPI 16944.11825) @ 0x1f7f3000
ACPI: FADT (v001 VIA694 MSI ACPI 16944.11825) @ 0x1f7f3040
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=linux259 ro root=306 profile=2 panic=60
kernel profiling enabled
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1200.089 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2359.29 BogoMIPS
Memory: 504112k/516032k available (2380k kernel code, 11156k reserved, 949k data, 88k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU:     After generic, caps: 0383f9ff c1c3f9ff 00000000 00000000
CPU: AMD Duron(tm) processor stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030109
 tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:........................................................................
Table [DSDT] - 356 Objects with 30 Devices 72 Methods 24 Regions
ACPI Namespace successfully loaded at root c04725bc
evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode successful
   evgpe-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
Executing all Device _STA and_INI methods:..............................
30 Devices found containing: 30 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package initialization:...........................................
Initialized 20/24 Regions 0/1 Fields 14/15 Buffers 9/9 Packages (356 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 3112, rev 00): [55] f9 & 1f -> 19
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
Linux Plug and Play Support v0.94 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd10
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbd40, dseg 0xf0000
pnp: pnp: match found with the PnP device '00:07' and the driver 'system'
pnp: pnp: match found with the PnP device '00:08' and the driver 'system'
PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Capability LSM initialized
Initializing Cryptographic API

testing md5
test 1:
d41d8cd98f00b204e9800998ecf8427e
pass
test 2:
0cc175b9c0f1b6a831c399e269772661
pass
test 3:
900150983cd24fb0d6963f7d28e17f72
pass
test 4:
f96b697d7cb7938d525a2f31aaf161d0
pass
test 5:
c3fcd3d76192e4007dfb496cca67e13b
pass
test 6:
d174ab98d277d9f5a5611c2c9f419d9f
pass
test 7:
57edf4a22be3c955ac49da2e2107b67a
pass

testing md5 across pages
c3fcd3d76192e4007dfb496cca67e13b
pass

testing sha1
test 1:
a9993e364706816aba3e25717850c26c9cd0d89d
pass
test 2:
84983e441c3bd26ebaae4aa1f95129e5e54670f1
pass

testing sha1 across pages
84983e441c3bd26ebaae4aa1f95129e5e54670f1
pass

testing des encryption
test 1:
c95744256a5ed31d
pass
test 2:
f79c892a338f4a8b
pass
test 3:
690f5b0d9a26939b
pass
test 4:
c95744256a5ed31df79c892a338f4a8bb49926f71fe1d490
pass
test 5:
setkey() failed flags=100100
c95744256a5ed31d
pass

testing des ecb encryption across pages
0123456789abcdef
page 1
c95744256a5ed31d
pass
page 2
f79c892a338f4a8b
pass

testing des ecb encryption chunking scenario A
page 1
c95744256a5ed31df79c892a338f
pass
page 2
4a8bb49926f71fe1d490
pass
page 3
f79c892a338f4a8b
pass

testing des ecb encryption chunking scenario B
page 1
c957
pass
page 2
44
pass
page 3
256a5e
pass
page 4
d31df79c892a338f4a8bb49926f71fe1d490
pass

testing des ecb encryption chunking scenario C
page 1
c957
pass
page 2
4425
pass
page 3
6a5e
pass
page 4
d31d
pass
page 5
f79c892a338f4a8b
pass

testing des ecb encryption chunking scenario D
c95744256a5ed31d
pass

testing des decryption
test 1:
0123456789abcde7
pass
test 2:
01a1d6d039776742
pass

testing des ecb decryption across pages
page 1
0123456789abcde7
pass
page 2
2233445566778899
pass

testing des ecb decryption chunking scenario E
page 1
012345
pass
page 2
6789abcde7a3997bcaaf69a0
pass
page 3
f5
pass

testing des cbc encryption
test 1:
ccd173ffab2039f4acd8aefddfd8a1eb468e91157888ba68
pass
test 2:
e5c7cdde872bf27c
pass
test 3:
43e934008c389c0f
pass
test 4:
683788499a7c05f6
pass

testing des cbc encryption chunking scenario F
page 1
ccd173ffab2039f4acd8aefddf
pass
page 2
d8a1eb468e91157888ba68
pass

testing des cbc decryption
test 1:
e5c7cdde872bf27c
4e6f772069732074
pass
test 2:
43e934008c389c0f
68652074696d6520
pass
test 3:
683788499a7c05f6
666f7220616c6c20
pass

testing des cbc decryption chunking scenario G
page 1
666f7220
pass
page 2
616c6c20
pass

testing des3 ede encryption
test 1:
18d748e563620572
pass
test 2:
c07d2a0fa566fa30
pass
test 3:
e1ef62c332fe825b
pass

testing des3 ede decryption
test 1:
736f6d6564617461
pass
test 2:
7371756967676c65
pass
test 3:
0000000000000000
pass

testing md4
test 1:
31d6cfe0d16ae931b73c59d7e0c089c0
pass
test 2:
bde52cb31de33e46245e05fbdbd6fb24
pass
test 3:
a448017aaf21d8525fc10ae87aa6729d
pass
test 4:
d9130a8164549fe818874806e1c7014b
pass
test 5:
d79e1c308aa5bbcdeea8ed63df412da9
pass
test 6:
043f8582f241db351ce627e153e7f0e4
pass
test 7:
e33b4ddc9c38f2199c3e7b164fcc0536
pass

testing sha256
test 1:
ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
pass
test 2:
248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1
pass

testing sha256 across pages
248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1
pass

testing blowfish encryption
test 1 (64 bit key):
4ef997456198dd78
pass
test 2 (64 bit key):
a790795108ea3cae
pass
test 3 (64 bit key):
e87a244e2cc85e82
pass
test 4 (128 bit key):
93142887ee3be15c
pass
test 5 (168 bit key):
e6f51ed79b9db21f
pass
test 6 (448 bit key):
c04504012e4e1f53
pass

testing blowfish decryption
test 1 (64 bit key):
0000000000000000
pass
test 2 (64 bit key):
0123456789abcdef
pass
test 3 (64 bit key):
fedcba9876543210
pass
test 4 (128 bit key):
fedcba9876543210
pass
test 5 (168 bit key):
fedcba9876543210
pass
test 6 (448 bit key):
fedcba9876543210
pass

testing blowfish cbc encryption
test 1 (128 bit key):
6b77b4d63006dee605b156e27403979358deb9e7154616d959f1652bd5ff92cc
pass

testing blowfish cbc decryption
test 1 (128 bit key):
37363534333231204e6f77206973207468652074696d6520666f722000000000
pass

testing twofish encryption
test 1 (128 bit key):
9f589f5cf6122c32b6bfec2f2ae8c35a
pass
test 2 (192 bit key):
cfd1d2e5a9be9cdf501f13b892bd2248
pass
test 3 (256 bit key):
37527be0052334b89f0cfccae87cfa20
pass

testing twofish decryption
test 1 (128 bit key):
00000000000000000000000000000000
pass
test 2 (192 bit key):
00000000000000000000000000000000
pass
test 3 (256 bit key):
00000000000000000000000000000000
pass

testing twofish cbc encryption
test 1 (128 bit key):
9f589f5cf6122c32b6bfec2f2ae8c35a
pass
test 2 (128 bit key):
d491db16e7b1c39e86cb086b789f5419
pass
test 3 (128 bit key):
05ef8c61a811582634ba5cb7106aa641
pass
test 4 (128 bit key):
9f589f5cf6122c32b6bfec2f2ae8c35ad491db16e7b1c39e86cb086b789f541905ef8c61a811582634ba5cb7106aa641
pass

testing twofish cbc decryption
test 1 (128 bit key):
00000000000000000000000000000000
pass
test 2 (128 bit key):
00000000000000000000000000000000
pass
test 3 (128 bit key):
00000000000000000000000000000000
pass
test 4 (128 bit key):
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
pass

testing serpent encryption
test 1 (0 bit key):
1207fcce9bd0d6476ae98fbed143a0e2
pass
test 2 (128 bit key):
4c7d8a328072a22c823e4a1f3acda16d
pass
test 3 (256 bit key):
de269ff833e432b85b2e88d2701ce75c
pass
test 4 (128 bit key):
ddd26b98a5ffd82c05345a9dadbfaf49
pass

testing serpent decryption
test 1 (0 bit key):
000102030405060708090a0b0c0d0e0f
pass
test 2 (128 bit key):
000102030405060708090a0b0c0d0e0f
pass
test 3 (256 bit key):
000102030405060708090a0b0c0d0e0f
pass
test 4 (128 bit key):
00000000000000000000000000000000
pass

testing aes encryption
test 1 (128 bit key):
69c4e0d86a7b0430d8cdb78070b4c55a
pass
test 2 (192 bit key):
dda97ca4864cdfe06eaf70a0ec0d7191
pass
test 3 (256 bit key):
8ea2b7ca516745bfeafc49904b496089
pass

testing aes decryption
test 1 (128 bit key):
00112233445566778899aabbccddeeff
pass
test 2 (192 bit key):
00112233445566778899aabbccddeeff
pass
test 3 (256 bit key):
00112233445566778899aabbccddeeff
pass

testing sha384
test 1:
cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7
pass
test 2:
3391fdddfc8dc7393707a65b1b4709397cf8b1d162af05abfe8f450de5f36bc6b0455a8520bc4e6f5fe95b1fe3c8452b
pass
test 3:
09330c33f71147e83d192fc782cd1b4753111b173b3b05d22fa08086e3b0f712fcc7c71a557e2db966c3e9fa91746039
pass
test 4:
3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
pass

testing sha512
test 1:
ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f
pass
test 2:
204a8fc6dda82f0a0ced7beb8e08a41657c16ef468b228a8279be331a703c33596fd15c13b1b07f9aa1d3bea57789ca031ad85c7a71dd70354ec631238ca3445
pass
test 3:
8e959b75dae313da8cf4f72814fc143f8f7779c6eb9f7fa17299aeadb6889018501d289e4900f7e4331b99dec4b5433ac7d329eeb6dd26545e96e55b874be909
pass
test 4:
930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
pass

testing hmac_md5
test 1:
9294727a3638bb1c13f48ef8158bfc9d
pass
test 2:
750c783e6ab0b503eaa86e310a5db738
pass
test 3:
56be34521d144c88dbb8c733f0e8b3f6
pass
test 4:
697eaf0aca3a3aea3a75164746ffaa79
pass
test 5:
56461ef2342edc00f9bab995690efd4c
pass
test 6:
6b1ab7fe4bd7bf8f0b62e6ce61b9d0cd
pass
test 7:
6f630fad67cda0ee1fb1f562db3aa53e
pass

testing hmac_md5 across pages
750c783e6ab0b503eaa86e310a5db738
pass

testing hmac_sha1
test 1:
b617318655057264e28bc0b6fb378c8ef146be00
pass
test 2:
effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
pass
test 3:
125d7342b9ac11cd91a39af48aa17b4f63f175d3
pass
test 4:
4c9007f4026250c6bc8414f9bf50c86c2d7235da
pass
test 5:
4c1a03424b55e07fe7f27be1d58bb9324a9a5a04
pass
test 6:
aa4ae5e15272d00e95705637ce8a3b55ed402112
pass
test 7:
e8e99d0f45237d786d6bbaa7965c7808bbff1a91
pass

testing hmac_sha1 across pages
effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
pass

testing hmac_sha256
test 1:
0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f20
a21b1f5d4cf4f73a4dd939750f7a066a7f98cc131cb16a6692759021cfab8181
pass
test 2:
0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f20
104fdc1257328f08184ba73131c53caee698e36119421149ea8c712456697d30
pass
test 3:
0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f20
470305fc7e40fe34d3eeb3e773d95aab73acf0fd060447a5eb4595bf33a9d1a3
pass
test 4:
0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b
198a607eb44bfbc69903a0f1cf2bbdc5ba0aa3f3d9ae3c1c7a3b1696a0b68cf7
pass
test 5:
4a656665
5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843
pass
test 6:
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cdcb1220d1ecccea91e53aba3092f962e549fe6ce9ed7fdc43191fbde45c30b0
pass
test 7:
0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f202122232425
d4633c17f6fb8d744c66dee0f8f074556ec4af55ef07998541468eb49bd2e917
pass
test 8:
0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c
7546af01841fc09b1ab9c3749a5f1c17d4f589668a587b2700a9c97c1193cf42
pass
test 9:
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
6953025ed96f0c09f80a96f78e6538dbe2e7b820e3dd970e7ddd39091b32352f
pass
test 10:
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
6355ac22e890d0a3c8481a5ca4825bc884d3e7a1ff98a2fc2ac7d8e064c3b2e6
pass
Applying VIA southbridge workaround.
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: the driver 'serial' has been registered
pnp: pnp: match found with the PnP device '00:0d' and the driver 'serial'
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 1
Intel(R) PRO/1000 Network Driver - version 4.4.19-k1
Copyright (c) 1999-2002 Intel Corporation.
pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
8139cp: 10/100 PCI Ethernet driver v0.3.0 (Sep 29, 2002)
8139cp: pci dev 00:09.0 (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
8139cp: Try the "8139too" driver instead.
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xe0006000, 00:50:22:c8:03:23, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
Linux Tulip driver version 1.1.13 (May 11, 2002)
eth1: ADMtek Comet rev 17 at 0xe0008000, 00:10:DC:5B:D1:DC, IRQ 12.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L060AVVA07-0, ATA DISK drive
hda: DMA disabled
hda: bad special flag: 0x03
hda: tagged command queueing enabled, command queue depth 32
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 >
drivers/usb/host/ehci-hcd.c: block sizes: qh 128 qtd 96 itd 128 sitd 64
drivers/usb/host/ohci-pci.c: 2002-Sep-17 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
drivers/usb/host/ohci-pci.c: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
uhci-hcd 00:07.2: VIA Technologies, In USB
uhci-hcd 00:07.2: irq 12, io base 0000c400
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 00:07.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/usb.c: usb_hotplug
usb usb1: usb_new_device - registering interface 1-0:0
hub 1-0:0: usb_device_probe
hub 1-0:0: usb_device_probe - got id
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
hub 1-0:0: standalone hub
hub 1-0:0: ganged power switching
hub 1-0:0: global over-current protection
hub 1-0:0: Port indicators are not supported
hub 1-0:0: power on to power good time: 2ms
hub 1-0:0: hub controller current requirement: 0mA
hub 1-0:0: local power source is good
hub 1-0:0: no over-current condition exists
hub 1-0:0: enabling power on all ports
drivers/usb/core/usb.c: usb_hotplug
uhci-hcd 00:07.3: VIA Technologies, In USB (#2)
uhci-hcd 00:07.3: irq 12, io base 0000c800
uhci-hcd 00:07.3: new USB bus registered, assigned bus number 2
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 00:07.3: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/usb.c: usb_hotplug
usb usb2: usb_new_device - registering interface 2-0:0
hub 2-0:0: usb_device_probe
hub 2-0:0: usb_device_probe - got id
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
hub 2-0:0: standalone hub
hub 2-0:0: ganged power switching
hub 2-0:0: global over-current protection
hub 2-0:0: Port indicators are not supported
hub 2-0:0: power on to power good time: 2ms
hub 2-0:0: hub controller current requirement: 0mA
hub 2-0:0: local power source is good
hub 2-0:0: no over-current condition exists
hub 2-0:0: enabling power on all ports
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
drivers/usb/host/uhci-hcd.c: c400: suspend_hc
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
i2c-proc.o version 2.6.4 (20020719)
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
sctp_init_sock(sk: df5133c0)
found reiserfs format "3.6" with standard journal
hub 1-0:0: port 1, status 100, change 3, 12 Mb/s
hub 1-0:0: port 2, status 100, change 3, 12 Mb/s
hub 2-0:0: port 1, status 301, change 3, 1.5 Mb/s
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
drivers/usb/host/uhci-hcd.c: c800: suspend_hc
drivers/usb/host/uhci-hcd.c: c800: wakeup_hc
hub 2-0:0: new USB device on port 1, assigned address 2
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: Product: USB MINI-Keyboard
usb 2-1: Manufacturer:
drivers/usb/core/usb.c: usb_hotplug
usb 2-1: usb_new_device - registering interface 2-1:0
hid 2-1:0: usb_device_probe
hid 2-1:0: usb_device_probe - got id
drivers/usb/input/hid-core.c: ctrl urb status -32 received
evbug.c: Connected device: "           USB MINI-Keyboard", usb-00:07.3-1/input0
input: USB HID v1.00 Keyboard [           USB MINI-Keyboard] on usb-00:07.3-1
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:0: port 2, status 100, change 3, 12 Mb/s
hub 2-0:0: port 2 enable change, status 100
hub 1-0:0: port 1 enable change, status 100
hub 1-0:0: port 2 enable change, status 100
evbug.c: Event. Dev: usb-00:07.3-1/input0, Type: 0, Code: 0, Value: 0
Reiserfs journal params: device ide0(3,6), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,6)) for (ide0(3,6))
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 88k freed
Adding 995988k swap on /dev/hda5.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
tonje:~#


--------------Boundary-00=_CWTBM88NZ6FX39OTVT29
Content-Type: text/plain;
  charset="us-ascii";
  name="dotconfig"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dotconfig"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_SWAP=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_PROCESSOR_PERF is not set
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=y
CONFIG_CPU_FREQ_24_API=y
CONFIG_X86_POWERNOW_K6=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_SPEEDSTEP is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_GX_SUSPMOD is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_SCx200 is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_CARD is not set
CONFIG_PNP_DEBUG=y

#
# Protocols
#
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDE_TCQ=y
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=32
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_IDEDMA_FORCED=y
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
# CONFIG_I2O_LAN is not set
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_XFRM_USER=m

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
# CONFIG_IP_NF_ARPFILTER is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
CONFIG_IP_SCTP=y
# CONFIG_SCTP_ADLER32 is not set
CONFIG_SCTP_DBG_MSG=y
CONFIG_SCTP_DBG_OBJCNT=y
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=y
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_DE4X5=y
CONFIG_WINBOND_840=y
CONFIG_DM9102=y
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
CONFIG_VIA_RHINE=y
# CONFIG_VIA_RHINE_MMIO is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=y
# CONFIG_E1000_NAPI is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=m
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y

#
# I2C Hardware Sensors Mainboard support
#
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set

#
# I2C Hardware Sensors Chip support
#
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_LM75 is not set

#
# Mice
#
CONFIG_BUSMOUSE=y
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_SOFT_WATCHDOG=y
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_RNG is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
CONFIG_XFS_FS=m
CONFIG_XFS_RT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_CIFS=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="iso8859-15"
# CONFIG_NCP_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_ZISOFS_FS=m
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-15"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB=y
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# SCSI support is needed for USB Storage
#

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
# CONFIG_USB_SERIAL_EMPEG is not set
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
CONFIG_USB_SERIAL_KEYSPAN=m
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
CONFIG_USB_SERIAL_KLSI=m
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_KALLSYMS is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set

#
# Security options
#
CONFIG_SECURITY=y
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_TEST=y

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--------------Boundary-00=_CWTBM88NZ6FX39OTVT29
Content-Type: text/plain;
  charset="us-ascii";
  name="proc.ide.hda.identify"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="proc.ide.hda.identify"

tonje:/usr/src/linux# cat /proc/ide/hda/identify
045a 3fff 37c8 0010 0000 0000 003f 0000
0000 0000 2020 2020 2020 564e 4333 3032
4133 4c38 3435 4541 0003 0e8f 0034 5641
334f 4135 3241 4943 3335 4c30 3630 4156
5641 3037 2d30 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0200 0007 3fff 0010
003f fc10 00fb 0100 a120 0728 0000 0007
0003 0078 0078 00f0 0078 0000 0000 0000
0000 0000 0000 001f 0000 0000 0000 0000
003c 0015 74eb 5bea 4000 7469 1802 4003
203f 0012 0000 0000 fffe 600b 80fe 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 000b 0000 0000 0000 001b 0000 0000
4000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 8000 0000
334f 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 71a5


--------------Boundary-00=_CWTBM88NZ6FX39OTVT29
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci-vvv"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci-vvv"

tonje:~# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3112
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b112 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d4000000-d6ffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at c000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 12
        Region 4: I/O ports at c400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 12
        Region 4: I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 3
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
        Subsystem: VIA Technologies, Inc. AC97 Audio Controller
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at cc00 [size=256]
        Region 1: I/O ports at d000 [size=4]
        Region 2: I/O ports at d400 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at dc00 [size=256]
        Region 1: Memory at d8000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 10/100 model NC100 (rev 11)
        Subsystem: Accton Technology Corporation: Unknown device 1216
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (16000ns min, 32000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at e000 [size=256]
        Region 1: Memory at d8001000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 (prog-if 00 [VGA])
        Subsystem: Trident Microsystems CyberBlade/i1
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d5800000 (32-bit, non-prefetchable) [size=8M]
        Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=128K]
        Region 2: Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [80] AGP version 1.0
                Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [90] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------Boundary-00=_CWTBM88NZ6FX39OTVT29
Content-Type: text/plain;
  charset="us-ascii";
  name="proc.ide.hda.model"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="proc.ide.hda.model"

tonje:/usr/src/linux# cat /proc/ide/hda/model
IC35L060AVVA07-0


--------------Boundary-00=_CWTBM88NZ6FX39OTVT29
Content-Type: text/plain;
  charset="us-ascii";
  name="proc.ide.via"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="proc.ide.via"

A BusMastering IDE Configuration----------------
Driver Version:                     3.35-ac
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xc000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO      UDMA       PIO
Address Setup:       30ns     120ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          20ns     600ns      30ns     600ns
Transfer Rate:   99.9MB/s   3.3MB/s  66.6MB/s   3.3MB/s


--------------Boundary-00=_CWTBM88NZ6FX39OTVT29
Content-Type: text/x-diff;
  charset="us-ascii";
  name="proc.ide.hda.settings"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="proc.ide.hda.settings"

tonje:/usr/src/linux# cat /proc/ide/hda/settings
name                    value           min             max             mode
----                    -----           ---             ---             ----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                119150          0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw
bswap                   0               0               1               r
current_speed           69              0               70              rw
failures                0               0               65535           rw
init_speed              12              0               70              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
multcount               0               0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw
using_tcq               1               0               32              rw
wcache                  0               0               1               rw


--------------Boundary-00=_CWTBM88NZ6FX39OTVT29--

