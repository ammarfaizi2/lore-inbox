Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTK1PPZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 10:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTK1PPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 10:15:25 -0500
Received: from chico.rediris.es ([130.206.1.3]:55284 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S262373AbTK1PPF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 10:15:05 -0500
From: David =?iso-8859-15?q?Mart=EDnez=20Moreno?= <ender@debian.org>
Organization: Debian
To: linux-kernel@vger.kernel.org
Subject: Current 2.4.23-rc* kernels has broken ACPI (at least for me).
Date: Fri, 28 Nov 2003 16:15:00 +0100
User-Agent: KMail/1.5.4
Cc: ender@debian.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311281615.00715.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

	Hello, l-k people. 2.4.23-rc5 doesn't boot in my laptop. I tracked
down the problem to the changes between -pre5 and -pre6, in the ACPI code.

	When I use acpi=off bootparam, my laptop boots. When not, the output is:

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ea800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013ff0000 (usable)
 BIOS-e820: 0000000013ff0000 - 0000000013fffc00 (ACPI data)
 BIOS-e820: 0000000013fffc00 - 0000000014000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
319MB LOWMEM available.
On node 0 totalpages: 81904
zone(0): 4096 pages.
zone(1): 77808 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6f20
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x13ffc2c4
ACPI: FADT (v001   MTC    7521   0x06040000 PTL  0x000f4240) @ 0x13fffb64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x13fffbd8
ACPI: DSDT (v001   MTC      7521 0x06040000 MSFT 0x0100000b) @ 0x00000000
Kernel command line: BOOT_IMAGE=linux ro root=302 video=vesa:ywrap,mtrr pci=bio0
Initializing CPU#0
Detected 1002.274 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1998.84 BogoMIPS
Memory: 320700k/327616k available (1943k kernel code, 6528k reserved, 618k data)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfd9ce, last bus=1
PCI: Using configuration type 1
Unable to handle kernel NULL pointer dereference at virtual address 000000ae
 printing eip:
c0194cd4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0194cd4>]    Not tainted
EFLAGS: 00010282
eax: 000000aa   ebx: 00000000   ecx: 04005b80   edx: 00005b80
esi: c137b520   edi: d3fd3000   ebp: 00005b80   esp: d3fdde7c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=d3fdd000)
Stack: 000000aa d3fd3000 d3fd31e8 00000000 d4802314 c01a0d34 d3fd3000 d3fddea0
       00000000 00000000 5b800030 000000ad 00000001 c02f87a0 c0191eba 00000000
       000001f0 00000246 00000030 00000009 00000030 000000ad 00000001 c02f87a0
Call Trace:    [<c01a0d34>] [<c0191eba>] [<c0191eba>] [<c01a5bf9>] [<c01a5a69>]
  [<c01a1382>] [<c019ee02>] [<c019ee1f>] [<c019e89d>] [<c0105000>] [<c019e918>]
  [<c0105000>] [<c019e9cb>] [<c01a517e>] [<c0105080>] [<c010576e>] [<c0105070>]

Code: 8b 40 04 89 46 28 8b 04 24 89 46 10 8d 87 e8 01 00 00 56 50
 <0>Kernel panic: Attempted to kill init!

Chipset SiS630, Pentium III 1Ghz.

	Please don't hesitate to ask for further data.

	Thanks in advance,


		Ender.
- -- 
You can't even be a vegetable, because even a artichoke has heart.
		-- Amélie (Le fabuleux destin d'Amélie Poulain)
- --
Servicios de red - Network services
Centro de Comunicaciones CSIC/RedIRIS
Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.49.05
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/x2Z0Ws/EhA1iABsRAkJWAJwNCuqnaW5pe0fji16YaZuBLXOPsgCgu9Xe
X0t+6pBmIjf5myh8wx1XHYg=
=/pLS
-----END PGP SIGNATURE-----

