Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282598AbRK0TNq>; Tue, 27 Nov 2001 14:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282644AbRK0TNg>; Tue, 27 Nov 2001 14:13:36 -0500
Received: from mictlan.fb10.TU-Berlin.DE ([130.149.138.230]:17536 "EHLO
	mictlan.fb10.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S282598AbRK0TNQ>; Tue, 27 Nov 2001 14:13:16 -0500
To: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: patch-2.5.1-pre2 with CONFIG_BLK_DEV_IDESCSI can not compile ?
Message-Id: <E168ncK-0003mO-00@mictlan.fb10.tu-berlin.de>
From: erasmo perez <erasmo@mictlan.fb10.tu-berlin.de>
Date: Tue, 27 Nov 2001 20:10:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello 

i think there is a bug in the 2.5.0 kernel, patched with patch-2.5.1-pre2
the bug seems to be related with the CONFIG_BLK_DEV_IDESCSI option
this problem does not arise with the previous patch-2.5.1-pre1 patch

the problem is that with CONFIG_BLK_DEV_IDESCSI enabled, the kernel cannot
compile, while with this option not enabled, the kernel can compile

the compilation stops with the following messages:

---
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -c -o ide-scsi.o ide-scsi.c
ide-scsi.c: In function `idescsi_dma_bio':
ide-scsi.c:710: request for member `bv_page' in something not a structure or union
ide-scsi.c:711: request for member `bv_len' in something not a structure or union
ide-scsi.c:712: request for member `bv_offset' in something not a structure or union
ide-scsi.c:722: request for member `bv_page' in something not a structure or union
ide-scsi.c:723: request for member `bv_len' in something not a structure or union
ide-scsi.c:724: request for member `bv_offset' in something not a structure or union
make[3]: *** [ide-scsi.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2
---

thank you

erasmo
