Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318045AbSHZLHN>; Mon, 26 Aug 2002 07:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSHZLHN>; Mon, 26 Aug 2002 07:07:13 -0400
Received: from relay.muni.cz ([147.251.4.35]:11724 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S318045AbSHZLHN>;
	Mon, 26 Aug 2002 07:07:13 -0400
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Compilation error in 2.4.20-pre4-ac2
X-URL: http://www.fi.muni.cz/~pekon/
From: Petr Konecny <pekon@informatics.muni.cz>
Date: 26 Aug 2002 13:11:26 +0200
Message-ID: <qwwr8glzxgh.fsf@decibel.fi.muni.cz>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I got an error when compiling 2.4.20-pre4-ac2. Compiled on debian
unstable with gcc-3.2.

                                                Petr

gcc-3.2 -D__KERNEL__ -I/home/pekon/linux/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=setup_pci  -DEXPORT_SYMTAB -c setup-pci.c
rm -f idedriver.o
ld -m elf_i386  -r -o idedriver.o ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-disk.o ide-cd.o ide-dma.o ide-proc.o setup-pci.o pci/idedriver-pci.o legacy/idedriver-legacy.o ppc/idedriver-ppc.o arm/idedriver-arm.o raid/idedriver-raid.o
ld: cannot open pci/idedriver-pci.o: No such file or directory
make[4]: *** [idedriver.o] Error 1
make[4]: Leaving directory `/home/pekon/linux/linux-2.4.19/drivers/ide'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/home/pekon/linux/linux-2.4.19/drivers/ide'
make[2]: *** [_subdir_ide] Error 2
make[2]: Leaving directory `/home/pekon/linux/linux-2.4.19/drivers'
make[1]: *** [_dir_drivers] Error 2
make[1]: Leaving directory `/home/pekon/linux/linux-2.4.19'
make: *** [stamp-build] Error 2


