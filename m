Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTETVyQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 17:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbTETVyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 17:54:16 -0400
Received: from nelson.SEDSystems.ca ([192.107.131.136]:27877 "EHLO
	nelson.sedsystems.ca") by vger.kernel.org with ESMTP
	id S261249AbTETVyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 17:54:14 -0400
Date: Tue, 20 May 2003 16:07:07 -0600 (CST)
From: Kendrick Hamilton <hamilton@sedsystems.ca>
To: linux-kernel@vger.kernel.org
cc: hamilton@sedsystems.ca
Subject: Linux crashes after installing a module. (Please CC hamilton@sedsystems.ca)
Message-ID: <Pine.LNX.4.44.0305201601040.2041-100000@sw-55.sedsystems.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	We are developping a module for a custom built card. The module 
installs fine on some computers and not on others. All computers are 
running 2.4.18 or 2.4.20 kernel. Here is a dump of installing the module 
and linux crashing. The module is tainting the kernel (I plan on GPLing 
the module and if you want code for it, I can send it to you, I just don't 
know how to flag it as GPLed).

[root@dhcp-226 modulator_device_driver]# insmod spflsmdd.o
Warning: loading spflsmdd.o will taint the kernel: no license
 Debug:pci.c:173:Card test passed
 See http://www.Debug:pci.c:63:Found 1 cards
tux.org/lkml/#exDebug:pci.c:236:PCI start address 0 is 0xf9000000
port-tainted forDebug:pci.c:239:PCI length is 0x00100000
 information aboDebug:pci.c:258:The card's memory address is 0xc88ca000
ut tainted modules
Debug:qduc_accessors.c:637:Setting qduc address 0x0000 to 0x7c9e0021
Debug:qduc_accessors.c:637:Setting qduc address 0x0004 to 0xb004b4ae
Debug:main_fileops.c:56:fops.open = c88ba470, sed_open = c88ba470
Debug:main_fileops.c:57:&fops = c88c8ee0
Debug:main_fileops.c:93:Using character device major number 254

SED PFLS modulator card installed.
Unable to handle kernel NULL pointer dereference at virtual address 
00000056
 printing eip:
c0145491
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0145491>]    Tainted: P
EFLAGS: 00010286
eax: 00000046   ebx: c2eb9f90   ecx: c2eb800i: c5c93000   edi: c2eb9f90   
eb0018
   es: 0018   ss: 0018
Process insmod (pid: 1490, stackpage=c2eb9000)
Stack: c01446a7 c5c93 c01453f7 c5c93000 c5c930c4 c2eb84c8 c2eb8000 
0805d98c bfff
cc54 c2eb9f90 fe5f20 c6d78000 c013a6b5
Call Trace:    [<c01446a7>] [<c01453f7>] [<c01456b9>] [<c01390 
[<c0109103>]

Code: 83 78 10 05 c0 74 03 ff 40
 <1>Unable to handle kernel pl address 30000004
 prin
Oops: 0002
CPU:    0
EIP:    0010:[<c0122503>]    Tai010006
eax: 00000000    30000000
esi: 00000056   edi: c2eb8000   ebp: 0000000bds: 0018   es: 0018   
ssstackpage=c
2eb9000)
Stack: c2eb9f14 c011d36b c2eb80e0 00000018 c2eb9f14 00000056 c7fe5f3c 
c2eb8000
       c0109792 0000000b c022ba3d 1165d4 c022ba3d c2eb9f1400002b1e 
c46a95c0 c012
db05 c7d662a4 00030001
Call Trac0109792>] [<c01165d4>] [<>] [<c01091f4>] [<c0145491>] 
[<c01446a7>] [<c0
1453f7>] [390c7>] [<c013a6b5>] [<c01 00 00 00 c7 01 00 00 00 00 c7 41 04 
00
 <1>Unable t request at virtual addr3
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    Tainted: P


The last thing done by the module initialization code is print 
SED PFLS modulator card installed.
If anybody has suggestions on what is going on or how to debug, please 
send to me.


-- 
Kendrick Hamilton E.I.T.
SED Systems, a division of Calian Ltd.
18 Innovation Blvd.
PO Box 1464
Saskatoon, Saskatchewan
Canada
S7N 3R1

Hamilton@sedsystems.ca
Tel: (306) 933-1453
Fax: (306) 933-1486

