Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318107AbSHQSGU>; Sat, 17 Aug 2002 14:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318113AbSHQSGU>; Sat, 17 Aug 2002 14:06:20 -0400
Received: from ausadmmsps307.aus.amer.dell.com ([143.166.224.102]:18951 "HELO
	AUSADMMSPS307.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S318107AbSHQSGT>; Sat, 17 Aug 2002 14:06:19 -0400
X-Server-Uuid: 82a6c0aa-b49f-4ad3-8d2c-07dae6b04e32
Message-ID: <20BF5713E14D5B48AA289F72BD372D6821CB74@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: torvalds@transmeta.com, davej@suse.de
cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH 2.5.x] move asm-ia64/efi.h to linux/efi.h
Date: Sat, 17 Aug 2002 13:10:06 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11404E0C1476875-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply
http://domsch.com/linux/patches/ia64/linux-2.5-efihmove.cset
a BK patch against Linus' current BK tree, which also applies cleanly
against the IA64 port 2.5.30 test patch posted last Monday.  This moves all
instances of #include <asm{"",-ia64}/efi.h> to <linux/efi.h>.

ChangeSet@1.504, 2002-08-13 22:24:31-05:00, Matt_Domsch@dell.com
  Move include/asm-ia64/efi.h to include/linux/efi.h
  This is required now that non-ia64 architectures are using EFI code,
  particularly the EFI GUID Partition Table (GPT) scheme for large disks.


 b/arch/ia64/hp/common/sba_iommu.c |    2 
 b/arch/ia64/hp/zx1/hpzx1_misc.c   |    2 
 b/arch/ia64/kernel/acpi.c         |    2 
 b/arch/ia64/kernel/efi.c          |    2 
 b/arch/ia64/kernel/efivars.c      |    2 
 b/arch/ia64/kernel/fw-emu.c       |    2 
 b/arch/ia64/kernel/palinfo.c      |    2 
 b/arch/ia64/kernel/process.c      |    2 
 b/arch/ia64/kernel/setup.c        |    2 
 b/arch/ia64/kernel/smp.c          |    2 
 b/arch/ia64/kernel/smpboot.c      |    2 
 b/arch/ia64/kernel/time.c         |    2 
 b/arch/ia64/mm/init.c             |    2 
 b/arch/ia64/sn/fakeprom/fpmem.c   |    2 
 b/arch/ia64/sn/fakeprom/fw-emu.c  |    2 
 b/arch/ia64/sn/io/efi-rtc.c       |    2 
 b/arch/ia64/sn/kernel/llsc4.c     |    2 
 b/drivers/acpi/osl.c              |    2 
 b/drivers/char/efirtc.c           |    2 
 b/fs/partitions/efi.h             |    6 
 b/include/asm-ia64/sal.h          |    2 
 b/include/linux/efi.h             |  284
++++++++++++++++++++++++++++++++++++++
 include/asm-ia64/efi.h            |  284
--------------------------------------
 23 files changed, 305 insertions, 309 deletions


And please apply
http://domsch.com/linux/patches/ia64/linux-2.5-efihmove2.cset
which changes the #ifdef _ASM_IA64_EFI_H to _LINUX_EFI_H test.

 efi.h |    6 +++---
 1 files changed, 3 insertions, 3 deletions



Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

