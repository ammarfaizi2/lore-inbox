Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbTDNTYR (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbTDNTYR (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:24:17 -0400
Received: from smtp5.wanadoo.es ([62.37.236.237]:31217 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S263941AbTDNTXR (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 15:23:17 -0400
Message-ID: <3E9B0B66.7080806@wanadoo.es>
Date: Mon, 14 Apr 2003 21:26:30 +0200
From: =?ISO-8859-1?Q?xos=E9_v=E1zquez_p=E9rez?= <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Compile Regression on i386]-2.4.21-pre7 _critical_ compile errors
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel compilation output summary:

--[fs/devpts]--
gcc -D__KERNEL__ -I/datos/kernel/linux.new/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=inode  -c -o inode.o inode.c
inode.c: In function `init_devpts_fs':
inode.c:233: `devpts_upcall_new' undeclared (first use in this function)
inode.c:233: (Each undeclared identifier is reported only once
inode.c:233: for each function it appears in.)
inode.c:234: `devpts_upcall_kill' undeclared (first use in this function)
inode.c: In function `exit_devpts_fs':
inode.c:244: `devpts_upcall_new' undeclared (first use in this function)
inode.c:245: `devpts_upcall_kill' undeclared (first use in this function)
make[1]: [inode.o] Error 1 (ignored)
rm -f devpts.o
ld -m elf_i386  -r -o devpts.o root.o inode.o
ld: cannot open inode.o: No such file or directory
make[1]: [devpts.o] Error 1 (ignored)
make[1]: Leaving directory `/datos/kernel/linux.new/fs/devpts'
--end--

--[drivers/sound/i810]--
gcc -D__KERNEL__ -I/datos/kernel/linux.new/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=i810_dma  -c -o i810_dma.o i810_dma.c
i810_dma.c: In function `i810_unmap_buffer':
i810_dma.c:231: too few arguments to function `do_munmap'
make[3]: [i810_dma.o] Error 1 (ignored)
gcc -D__KERNEL__ -I/datos/kernel/linux.new/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=i810_context  -c -o i810_context.o i810_context.c
gcc -D__KERNEL__ -I/datos/kernel/linux.new/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=i810_bufs  -c -o i810_bufs.o i810_bufs.c
ld -m elf_i386 -r -o i810.o i810_drv.o   i810_dma.o    i810_context.o i810_bufs.o
ld: cannot open i810_dma.o: No such file or directory
make[3]: [i810.o] Error 1 (ignored)
--end--

--{fs/openpromfs]--
gcc -D__KERNEL__ -I/datos/kernel/linux.new/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=inode  -c -o inode.o inode.c
inode.c:18:26: asm/openprom.h: No such file or directory
inode.c:19:23: asm/oplib.h: No such file or directory
inode.c: In function `property_read':
inode.c:108: warning: implicit declaration of function `prom_firstprop'
inode.c:108: warning: assignment makes pointer from integer without a cast
inode.c:110: warning: implicit declaration of function `prom_nextprop'
inode.c:110: warning: assignment makes pointer from integer without a cast
inode.c:114: warning: implicit declaration of function `prom_getproplen'
inode.c:134: warning: implicit declaration of function `prom_getproperty'
inode.c: In function `property_release':
inode.c:525: warning: implicit declaration of function `prom_feval'
inode.c:531: warning: implicit declaration of function `prom_setprop'
inode.c: In function `lookup_children':
inode.c:595: warning: implicit declaration of function `prom_getname'
inode.c: In function `openpromfs_lookup':
inode.c:666: warning: assignment makes pointer from integer without a cast
inode.c:668: warning: assignment makes pointer from integer without a cast
inode.c: In function `openpromfs_readdir':
inode.c:806: warning: assignment makes pointer from integer without a cast
inode.c:808: warning: assignment makes pointer from integer without a cast
inode.c: In function `get_nodes':
inode.c:934: warning: assignment makes pointer from integer without a cast
inode.c:936: warning: assignment makes pointer from integer without a cast
inode.c:940: warning: assignment makes pointer from integer without a cast
inode.c:942: warning: assignment makes pointer from integer without a cast
inode.c:958: warning: implicit declaration of function `prom_getchild'
inode.c:964: warning: implicit declaration of function `prom_getsibling'
inode.c: In function `init_openprom_fs':
inode.c:1033: `prom_root_node' undeclared (first use in this function)
inode.c:1033: (Each undeclared identifier is reported only once
inode.c:1033: for each function it appears in.)
make[1]: [inode.o] Error 1 (ignored)
rm -f openpromfs.o
ld -m elf_i386  -r -o openpromfs.o inode.o
ld: cannot open inode.o: No such file or directory
make[1]: [openpromfs.o] Error 1 (ignored)
--end--

--drivers/macintosh--
gcc -D__KERNEL__ -I/datos/kernel/linux.new/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=nvram  -c -o nvram.o nvram.c
nvram.c:17:23: asm/nvram.h: No such file or directory
nvram.c: In function `nvram_ioctl':
nvram.c:78: `PMAC_NVRAM_GET_OFFSET' undeclared (first use in this function)
nvram.c:78: (Each undeclared identifier is reported only once
nvram.c:78: for each function it appears in.)
nvram.c:83: `pmac_nvram_OF' undeclared (first use in this function)
nvram.c:83: `pmac_nvram_NR' undeclared (first use in this function)
nvram.c:85: warning: implicit declaration of function `pmac_get_partition'
nvram.c:81: warning: unreachable code at beginning of switch statement
make[1]: [nvram.o] Error 1 (ignored)
--end--

-- 
Galiza nin perdoa nin esquence. Governo demision!


