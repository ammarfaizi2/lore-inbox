Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTLVVA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbTLVVA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:00:26 -0500
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:62900 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S264455AbTLVVAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:00:22 -0500
Subject: Ooops with kernel 2.4.22 and reiserfs
From: Carlo <devel@integra-sc.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1072126808.21200.3.camel@atena>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Dec 2003 22:01:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
i receive the follow message error when i delete file from a large
partition (100GB) of an IDE drive (120GB) with reiserfs filesystem and
kernel 2.4.22. Other partitions are EXT3.
 
I received this message several time in my test that erase jpeg files in
nested directories.
May i increase the verbose of this error?


hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
DataRequest }
ide0: Drive 0 didn't accept speed setting. Oh, well.
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
 
hda: CHECK for good STATUS
Unable to handle kernel paging request at virtual address ffffffe0
 printing eip:
c0146553
*pde = 00002063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0146553>]    Not tainted
EFLAGS: 00010213
eax: cded5f68   ebx: ffffffe0   ecx: cded5000   edx: 00000010
esi: 00000000   edi: cded5e40   ebp: cded5e68   esp: cb18bf24
ds: 0018   es: 0018   ss: 0018
Process rmdir (pid: 21907, stackpage=cb18b000)
Stack: 00000000 cded5e40 cded5e40 c2dfc340 cded5e40 bffffae8 c01465dd
cded5e40
       cded5e40 c013fa0f cded5e40 000001fe cb7d9040 c2dfc340 cded5e40
c018d840
       c013fb69 cded5e40 cded5d40 cb18bf9c 00000000 fffffff0 cded5e40
cded5e40
Call Trace:    [<c01465dd>] [<c013fa0f>] [<c018d840>] [<c013fb69>]
[<c013fc84>]
  [<c0114d00>] [<c01088a3>]
 
Code: 8b 03 8b 36 85 c0 75 32 8d 4b 18 8b 51 04 8b 43 18 89 50 04

[]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2700+
stepping        : 1
cpu MHz         : 2158.060
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4299.16

