Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbSJBGcs>; Wed, 2 Oct 2002 02:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262983AbSJBGcs>; Wed, 2 Oct 2002 02:32:48 -0400
Received: from [210.19.28.13] ([210.19.28.13]:51411 "HELO gateway.vault-id.com")
	by vger.kernel.org with SMTP id <S262981AbSJBGcr>;
	Wed, 2 Oct 2002 02:32:47 -0400
Message-ID: <33262.10.2.16.178.1033540702.squirrel@mail.Vault-ID.com>
Date: Wed, 2 Oct 2002 14:38:22 +0800 (MYT)
Subject: 2.5.40 compile error (missing imm.o)
From: "Corporal Pisang" <Corporal_Pisang@Counter-Strike.com.my>
To: <linux-kernel@vger.kernel.org>
X-XheaderVersion: 1.1
X-UserAgent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20020923 Phoenix/0.1
X-Priority: 3
Importance: Normal
Reply-To: Corporal_Pisang@Counter-Strike.com.my
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

2.5.40 gives me a compile error doesnt exists before.

gcc -Wp,-MD,./.imm.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -I/usr/src/linux/arch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=imm   -c -o imm.o imm.c
drivers/scsi/imm.c: In function `imm_interrupt':
drivers/scsi/imm.c:901: warning: implicit declaration of function
`queue_task'
drivers/scsi/imm.c:901: `tq_timer' undeclared (first use in this function)
drivers/scsi/imm.c:901: (Each undeclared identifier is reported only once
drivers/scsi/imm.c:901: for each function it appears in.)
drivers/scsi/imm.c: In function `imm_queuecommand':
drivers/scsi/imm.c:1108: `tq_immediate' undeclared (first use in this
function)
drivers/scsi/imm.c:1109: warning: implicit declaration of function `mark_bh'
drivers/scsi/imm.c:1109: `IMMEDIATE_BH' undeclared (first use in this
function)
  ld -m elf_i386  -r -o sd_mod.o sd.o
  ld -m elf_i386  -r -o sr_mod.o sr.o sr_ioctl.o sr_vendor.o
  gcc -Wp,-MD,./.sg.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -I/usr/src/linux/arch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=sg   -c -o sg.o sg.c
   ld -m elf_i386  -r -o built-in.o scsi_mod.o ide-scsi.o imm.o sd_mod.o
sr_mod.o sg.o
ld: cannot open imm.o: No such file or directory
make[2]: *** [built-in.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
make[1]: *** [scsi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [drivers] Error 2


Regards

-Ubaida-


