Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271289AbRIDNLi>; Tue, 4 Sep 2001 09:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271643AbRIDNL2>; Tue, 4 Sep 2001 09:11:28 -0400
Received: from prfdec.natur.cuni.cz ([195.113.56.1]:21520 "EHLO
	prfdec.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S271289AbRIDNLV>; Tue, 4 Sep 2001 09:11:21 -0400
X-Envelope-From: mmokrejs
Posted-Date: Tue, 4 Sep 2001 15:11:40 +0200 (MET DST)
Date: Tue, 4 Sep 2001 15:11:40 +0200 (MET DST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: __alloc_pages: 0-order allocation failed.
Message-ID: <Pine.OSF.4.21.0109041500460.8354-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm getting the above error on 2.4.9 kernel with kernel HIGHMEM option
enabled to 2GB, 2x Intel PentiumIII. The machine has 1GB RAM
physically. Althougj I've found many report to linux-kernel list during
past months, not a real solution. Maybe only:
http://www.alsa-project.org/archive/alsa-devel/msg08629.html

  I hope it's not related to memory chunks allocated twice, so I think
it's another problem in 2.4.9, right?

Linux version 2.4.9 (user@host) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #4 SMP Thu Aug 30 15:10:26 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 000000000009f800 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
128MB HIGHMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 262144
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32768 pages.

shell$ free
             total       used       free     shared    buffers     cached
Mem:       1028480     992840      35640          0      20832     821524
-/+ buffers/cache:     150484     877996
Swap:      2097136     100868    1996268


  The machine is running apache 1.3.20 and mysql-3.23.41 only, and is
not loaded yet. :( Any ideas? Thanks.
-- 
Martin Mokrejs - PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany


