Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKHUKB>; Wed, 8 Nov 2000 15:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129476AbQKHUJw>; Wed, 8 Nov 2000 15:09:52 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:12790 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129150AbQKHUJq>; Wed, 8 Nov 2000 15:09:46 -0500
Date: Wed, 08 Nov 2000 14:09:43 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: multiple definition of `__module_kernel_version'
X-Mailer: The Polarbar Mailer (pbm 1.17b)
Message-Id: <20001108200949Z129150-31179+2040@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to port my driver from 2.4 to 2.2.  When I try to compile it, I get
several "multiple definition of `__module_kernel_version'" errors:

ver is 2.2.14-6.0
ld -r --print-map --cref -Map tdmcddk.map global.o init.o tiermap.o support.o
cccomp.o ccmp_sft.o lz77.o ccmp_s32.o gcmp_sft.o gencomp.o infoapi.o thread.o
callback.o -o tdmcddk.sys
init.o: In function `WaitStandardUnit':
/home/ttabi/src/tdimm/tdmcddk.sys/init.c:181: multiple definition of
`__module_kernel_version'
global.o(.modinfo+0x0):/home/ttabi/src/tdimm/tdmcddk.sys/global.c: first
defined here
tiermap.o: In function `FsbToDimmSlot':
/home/ttabi/src/tdimm/tdmcddk.sys/tiermap.c:10: multiple definition of
`__module_kernel_version'
global.o(.modinfo+0x0):/home/ttabi/src/tdimm/tdmcddk.sys/global.c: first
defined here
support.o: In function `IsGoodCpu':
/home/ttabi/src/tdimm/tdmcddk.sys/../support/common/cpuid.c:5: multiple
definition of `__module_kernel_version'
global.o(.modinfo+0x0):/home/ttabi/src/tdimm/tdmcddk.sys/global.c: first
defined here
cccomp.o: In function `CompressIntoCCache':
/home/ttabi/src/tdimm/tdmcddk.sys/cccomp.c:11: multiple definition of
`__module_kernel_version'
global.o(.modinfo+0x0):/home/ttabi/src/tdimm/tdmcddk.sys/global.c: first
defined here
ccmp_sft.o: In function `CompressIntoCCacheSoft':
/home/ttabi/src/tdimm/tdmcddk.sys/ccmp_sft.c:12: multiple definition of
`__module_kernel_version'
global.o(.modinfo+0x0):/home/ttabi/src/tdimm/tdmcddk.sys/global.c: first
defined here
lz77.o: In function `PackLZ77Triplette':
/home/ttabi/src/tdimm/tdmcddk.sys/lz77.c:95: multiple definition of
`__module_kernel_version'
global.o(.modinfo+0x0):/home/ttabi/src/tdimm/tdmcddk.sys/global.c: first
defined here
ccmp_s32.o: In function `CompressIntoCCacheS32':
/home/ttabi/src/tdimm/tdmcddk.sys/ccmp_s32.c:12: multiple definition of
`__module_kernel_version'
global.o(.modinfo+0x0):/home/ttabi/src/tdimm/tdmcddk.sys/global.c: first
defined here
gcmp_sft.o: In function `GenericCompressSoft':
/home/ttabi/src/tdimm/tdmcddk.sys/gcmp_sft.c:12: multiple definition of
`__module_kernel_version'
global.o(.modinfo+0x0):/home/ttabi/src/tdimm/tdmcddk.sys/global.c: first
defined here
gencomp.o: In function `GenericCompress':
/home/ttabi/src/tdimm/tdmcddk.sys/gencomp.c:11: multiple definition of
`__module_kernel_version'
global.o(.modinfo+0x0):/home/ttabi/src/tdimm/tdmcddk.sys/global.c: first
defined here
infoapi.o: In function `tdmGetDriverConfig':
/home/ttabi/src/tdimm/tdmcddk.sys/infoapi.c:12: multiple definition of
`__module_kernel_version'
global.o(.modinfo+0x0):/home/ttabi/src/tdimm/tdmcddk.sys/global.c: first
defined here
thread.o: In function `SetAnvilRestartTimer':
/home/ttabi/src/tdimm/tdmcddk.sys/thread.c:10: multiple definition of
`__module_kernel_version'
global.o(.modinfo+0x0):/home/ttabi/src/tdimm/tdmcddk.sys/global.c: first
defined here
callback.o: In function `InitializeCallbackQueue':
/home/ttabi/src/tdimm/tdmcddk.sys/callback.c:84: multiple definition of
`__module_kernel_version'
global.o(.modinfo+0x0):/home/ttabi/src/tdimm/tdmcddk.sys/global.c: first
defined here
make: *** [tdmcddk.sys] Error 1
[ttabi@one tdmcddk.sys]$ 

I've searched through the mailing list archives, but none of the "fixes"
suggested earlier seem to work.  Why does this happen?  And why doesn't it
happen with 2.4?



-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
