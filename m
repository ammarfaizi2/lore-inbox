Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbRAAVR6>; Mon, 1 Jan 2001 16:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129573AbRAAVRs>; Mon, 1 Jan 2001 16:17:48 -0500
Received: from daVinci.scs.carleton.ca ([134.117.5.50]:29970 "EHLO
	scs.carleton.ca") by vger.kernel.org with ESMTP id <S129429AbRAAVRf>;
	Mon, 1 Jan 2001 16:17:35 -0500
Date: Mon, 1 Jan 2001 15:46:48 -0500
From: James Moody <jemoody@scs.carleton.ca>
To: linux-kernel@vger.kernel.org
Subject: Sparc32: Error linking 2.4.0-prerelease
Message-ID: <20010101154648.A27569@sigma07.scs.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following errors during the final linking of 2.4.0-prerelease
on a Sparc IPX (sun4c). .config available upon request.

ld -m elf32_sparc -r /mnt/ipx04/src/linux-2.4.0-prerelease/arch/sparc/kernel/head.o /mnt/ipx04/src/linux-2.4.0-prerelease/arch/sparc/kernel/init_task.o /mnt/ipx04/src/linux-2.4.0-prerelease/init/main.o /mnt/ipx04/src/linux-2.4.0-prerelease/init/version.o \
	--start-group \
	/mnt/ipx04/src/linux-2.4.0-prerelease/arch/sparc/kernel/kernel.o /mnt/ipx04/src/linux-2.4.0-prerelease/arch/sparc/mm/mm.o /mnt/ipx04/src/linux-2.4.0-prerelease/kernel/kernel.o /mnt/ipx04/src/linux-2.4.0-prerelease/mm/mm.o /mnt/ipx04/src/linux-2.4.0-prerelease/fs/fs.o /mnt/ipx04/src/linux-2.4.0-prerelease/ipc/ipc.o /mnt/ipx04/src/linux-2.4.0-prerelease/arch/sparc/math-emu/math-emu.o /mnt/ipx04/src/linux-2.4.0-prerelease/drivers/block/block.o /mnt/ipx04/src/linux-2.4.0-prerelease/drivers/char/char.o /mnt/ipx04/src/linux-2.4.0-prerelease/drivers/misc/misc.o /mnt/ipx04/src/linux-2.4.0-prerelease/drivers/net/net.o /mnt/ipx04/src/linux-2.4.0-prerelease/drivers/media/media.o /mnt/ipx04/src/linux-2.4.0-prerelease/drivers/scsi/scsidrv.o /mnt/ipx04/src/linux-2.4.0-prerelease/drivers/cdrom/driver.o /mnt/ipx04/src/linux-2.4.0-prerelease/drivers/sbus/sbus_all.o /mnt/ipx04/src/linux-2.4.0-prerelease/drivers/video/video.o /mnt/ipx04/src/linux-2.4.0-prerelease/net/network.o \
	/mnt/ipx04/src/linux-2.4.0-prerelease/lib/lib.a /mnt/ipx04/src/linux-2.4.0-prerelease/lib/lib.a /mnt/ipx04/src/linux-2.4.0-prerelease/arch/sparc/prom/promlib.a /mnt/ipx04/src/linux-2.4.0-prerelease/arch/sparc/lib/lib.a \
	--end-group -o vmlinux.o
objdump -x vmlinux.o | ./btfixupprep > btfix.s
gcc -c -o btfix.o btfix.s
make[1]: Leaving directory `/mnt/ipx04/src/linux-2.4.0-prerelease/arch/sparc/boot'
ld -m elf32_sparc -T arch/sparc/vmlinux.lds arch/sparc/kernel/head.o arch/sparc/kernel/init_task.o init/main.o init/version.o \
	--start-group \
	arch/sparc/kernel/kernel.o arch/sparc/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/sparc/math-emu/math-emu.o arch/sparc/boot/btfix.o \
	drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o  drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sbus/sbus_all.o drivers/video/video.o \
	net/network.o \
	/mnt/ipx04/src/linux-2.4.0-prerelease/lib/lib.a /mnt/ipx04/src/linux-2.4.0-prerelease/lib/lib.a /mnt/ipx04/src/linux-2.4.0-prerelease/arch/sparc/prom/promlib.a /mnt/ipx04/src/linux-2.4.0-prerelease/arch/sparc/lib/lib.a \
	--end-group \
	-o vmlinux
arch/sparc/kernel/kernel.o: In function `udelay':
arch/sparc/kernel/kernel.o(.text+0x110c): undefined reference to `loops_per_sec'arch/sparc/kernel/kernel.o(.text+0x1114): undefined reference to `loops_per_sec'arch/sparc/kernel/kernel.o: In function `get_cpuinfo':
arch/sparc/kernel/kernel.o(.text+0x7228): undefined reference to `loops_per_sec'arch/sparc/kernel/kernel.o(.text+0x7240): undefined reference to `loops_per_sec'arch/sparc/mm/mm.o: In function `srmmu_paging_init':
arch/sparc/mm/mm.o(.text.init+0x1aac): undefined reference to `pkmap_page_table'arch/sparc/mm/mm.o(.text.init+0x1af8): undefined reference to `pkmap_page_table'arch/sparc/mm/mm.o(.text.init+0x1d1c): undefined reference to `pkmap_page_table'kernel/kernel.o: In function `access_one_page':
kernel/kernel.o(.text+0xb040): undefined reference to `kmap_high'
kernel/kernel.o(.text+0xb0ac): undefined reference to `kunmap_high'
kernel/kernel.o(.text+0xb10c): undefined reference to `kmap_high'
kernel/kernel.o(.text+0xb178): undefined reference to `kunmap_high'
kernel/kernel.o(__ksymtab+0x228): undefined reference to `kmap_high'
kernel/kernel.o(__ksymtab+0x230): undefined reference to `kunmap_high'
kernel/kernel.o(__ksymtab+0xa00): undefined reference to `loops_per_sec'
mm/mm.o: In function `do_wp_page':
mm/mm.o(.text+0x15b0): undefined reference to `kmap_high'
mm/mm.o(.text+0x1604): undefined reference to `kunmap_high'
mm/mm.o(.text+0x1664): undefined reference to `kmap_high'
mm/mm.o(.text+0x16bc): undefined reference to `kmap_high'
mm/mm.o(.text+0x1710): undefined reference to `kunmap_high'
mm/mm.o(.text+0x1758): undefined reference to `kunmap_high'
mm/mm.o: In function `do_anonymous_page':
mm/mm.o(.text+0x1dec): undefined reference to `kmap_high'
mm/mm.o(.text+0x1e40): undefined reference to `kunmap_high'
mm/mm.o: In function `truncate_list_pages':
mm/mm.o(.text+0x3d24): undefined reference to `kmap_high'
mm/mm.o(.text+0x3d7c): undefined reference to `kunmap_high'
mm/mm.o: In function `file_read_actor':
mm/mm.o(.text+0x5688): undefined reference to `kmap_high'
mm/mm.o(.text+0x56ec): undefined reference to `kunmap_high'
mm/mm.o: In function `file_send_actor':
mm/mm.o(.text+0x5818): undefined reference to `kmap_high'
mm/mm.o(.text+0x5888): undefined reference to `kunmap_high'
mm/mm.o: In function `filemap_nopage':
mm/mm.o(.text+0x5e14): undefined reference to `kmap_high'
mm/mm.o(.text+0x5e6c): undefined reference to `kmap_high'
mm/mm.o(.text+0x5ec0): undefined reference to `kunmap_high'
mm/mm.o(.text+0x5f08): undefined reference to `kunmap_high'
mm/mm.o: In function `generic_file_write':
mm/mm.o(.text+0x7cf4): undefined reference to `kunmap_high'
mm/mm.o: In function `shmem_nopage':
mm/mm.o(.text+0x11e14): undefined reference to `kmap_high'
mm/mm.o(.text+0x11e68): undefined reference to `kunmap_high'
mm/mm.o(.text+0x11f98): undefined reference to `kmap_high'
mm/mm.o(.text+0x11ff0): undefined reference to `kmap_high'
mm/mm.o(.text+0x12044): undefined reference to `kunmap_high'
mm/mm.o(.text+0x1208c): undefined reference to `kunmap_high'
fs/fs.o: In function `__block_prepare_write':
fs/fs.o(.text+0x4b80): undefined reference to `kmap_high'
fs/fs.o: In function `block_read_full_page':
fs/fs.o(.text+0x4fd0): undefined reference to `kmap_high'
fs/fs.o(.text+0x501c): undefined reference to `kunmap_high'
fs/fs.o: In function `cont_prepare_write':
fs/fs.o(.text+0x5310): undefined reference to `kunmap_high'
fs/fs.o(.text+0x548c): undefined reference to `kunmap_high'
fs/fs.o(.text+0x54fc): undefined reference to `kunmap_high'
fs/fs.o: In function `block_prepare_write':
fs/fs.o(.text+0x55fc): undefined reference to `kunmap_high'
fs/fs.o(.text+0x569c): more undefined references to `kunmap_high' follow
fs/fs.o: In function `block_truncate_page':
fs/fs.o(.text+0x58e0): undefined reference to `kmap_high'
fs/fs.o(.text+0x5938): undefined reference to `kunmap_high'
fs/fs.o: In function `block_write_full_page':
fs/fs.o(.text+0x5b14): undefined reference to `kunmap_high'
fs/fs.o: In function `copy_strings':
fs/fs.o(.text+0xbc98): undefined reference to `kmap_high'
fs/fs.o(.text+0xbd68): undefined reference to `kunmap_high'
fs/fs.o: In function `remove_arg_zero':
fs/fs.o(.text+0xc8f8): undefined reference to `kunmap_high'
fs/fs.o(.text+0xc95c): undefined reference to `kmap_high'
fs/fs.o(.text+0xc9c8): undefined reference to `kunmap_high'
fs/fs.o: In function `page_getlink':
fs/fs.o(.text+0x122f0): undefined reference to `kmap_high'
fs/fs.o: In function `page_readlink':
fs/fs.o(.text+0x1239c): undefined reference to `kunmap_high'
fs/fs.o: In function `page_follow_link':
fs/fs.o(.text+0x12630): undefined reference to `kunmap_high'
drivers/block/block.o: In function `__make_request':
drivers/block/block.o(.text+0xb58): undefined reference to `create_bounce'
make: *** [vmlinux] Error 1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
