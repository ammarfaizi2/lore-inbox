Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbRAIX21>; Tue, 9 Jan 2001 18:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129903AbRAIX2S>; Tue, 9 Jan 2001 18:28:18 -0500
Received: from DKBH-T-002-p-251-143.tmns.net.au ([203.54.251.143]:5642 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S129884AbRAIX2L>;
	Tue, 9 Jan 2001 18:28:11 -0500
Message-ID: <3A5B9E70.DF89B978@eyal.emu.id.au>
Date: Wed, 10 Jan 2001 10:27:44 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] linux-kernel v2.0.39
In-Reply-To: <20010109234804.E18733@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My 'make dep' fails in the following way. This is on Debian 2.2, I
commented
out the warnings/errors in linux/include/linux/types.h re the compiler
version.


gcc -I/usr/local/src/linux/include -O2 -fomit-frame-pointer -o
scripts/mkdep scripts/mkdep.c
make[1]: Entering directory
`/data2/usr/local/src/linux-2.0/arch/i386/boot'
make[1]: Nothing to be done for `dep'.
make[1]: Leaving directory
`/data2/usr/local/src/linux-2.0/arch/i386/boot'
scripts/mkdep init/*.c > .tmpdepend
scripts/mkdep `find /usr/local/src/linux/include/asm
/usr/local/src/linux/include/linux /usr/local/src/linux/include/scsi
/usr/local/src/linux/include/net -follow -name \*.h ! -name
modversions.h -print` > .hdepend
/usr/local/src/linux/include/asm/mtrr.h needs config but has not
included config file
/usr/local/src/linux/include/linux/if_frad.h doesn't need config
set -e; for i in kernel drivers mm fs net ipc lib arch/i386/kernel
arch/i386/mm arch/i386/lib; do make -j1 -l -C $i fastdep; done
make[1]: Entering directory `/data2/usr/local/src/linux-2.0/kernel'
gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe
-m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=586 -E
-D__GENKSYMS__ ksyms.c | /sbin/genksyms
/usr/local/src/linux/include/linux/modules
updating /usr/local/src/linux/include/linux/modversions.h
if [ -n "dma.c exec_domain.c exit.c fork.c info.c itimer.c ksyms.c
module.c panic.c printk.c resource.c sched.c signal.c softirq.c sys.c
sysctl.c time.c" ]; then \
/usr/local/src/linux/scripts/mkdep *.[chS] > .depend; fi
make[1]: Leaving directory `/data2/usr/local/src/linux-2.0/kernel'
make[1]: Entering directory `/data2/usr/local/src/linux-2.0/drivers'
if [ -n "" ]; then \
/usr/local/src/linux/scripts/mkdep *.[chS] > .depend; fi
set -e; for i in block char net  pci sbus scsi sound cdrom isdn; do make
-j1 -l -C $i fastdep; done
make[2]: Entering directory
`/data2/usr/local/src/linux-2.0/drivers/block'
gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe
-m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=586 -E
-D__GENKSYMS__ md.c | /sbin/genksyms
/usr/local/src/linux/include/linux/modules
updating /usr/local/src/linux/include/linux/modversions.h
if [ -n "DAC960.c DAC960.h ali14xx.c amiflop.c ataflop.c cmd640.c
cpqarray.c cpqarray.h dtc2278.c floppy.c genhd.c hd.c ht6560b.c
ida_cmd.h ida_ioctl.h ide-cd.c ide-floppy.c ide-tape.c ide-tape.h ide.c
ide.h ide_modes.h linear.c ll_rw_blk.c loop.c md.c proc_array.c
promise.c promise.h qd6580.c raid0.c raid1.c raid5.c rd.c rz1000.c
triton.c umc8672.c xd.c" ]; then \
/usr/local/src/linux/scripts/mkdep *.[chS] > .depend; fi
cpqarray.h doesn't need config
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.0/drivers/block'
make[2]: Entering directory
`/data2/usr/local/src/linux-2.0/drivers/char'
gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe
-m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=586 -E
-D__GENKSYMS__ misc.c | /sbin/genksyms
/usr/local/src/linux/include/linux/modules
gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce -pipe
-m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=586 -E
-D__GENKSYMS__ serial.c | /sbin/genksyms
/usr/local/src/linux/include/linux/modules
updating /usr/local/src/linux/include/linux/modversions.h
gcc -I/usr/local/src/linux/include -o conmakehash conmakehash.c
./conmakehash cp437.uni > uni_hash.tbl
if [ -n "amigamouse.c atarimouse.c atixlmouse.c baycom.c busmouse.c
cd1865.h conmakehash.c console.c console_struct.h consolemap.c
consolemap.h cyclades.c defkeymap.c diacr.h digi.h digi_bios.h
digi_fep.h fbmem.c fep.h h8.c h8.h isicom.c istallion.c kbd_kern.h
keyb_m68k.c keyboard.c lp.c lp_intern.c lp_m68k.c mem.c misc.c
msbusmouse.c n_tty.c pcwd.c pcxx.c pcxx.h psaux.c pty.c random.c
riscom8.c riscom8.h riscom8_reg.h rtc.c scc.c selection.c selection.h
serial.c softdog.c specialix.c specialix_io8.h stallion.c tga.c
tpqic02.c tty_io.c tty_ioctl.c vc_screen.c vesa_blank.c vga.c vt.c
vt_kern.h wd501p.h wdt.c" ]; then \
/usr/local/src/linux/scripts/mkdep *.[chS] > .depend; fi
make[2]: *** [fastdep] Error 135
make[2]: Leaving directory `/data2/usr/local/src/linux-2.0/drivers/char'
make[1]: *** [fastdep] Error 2
make[1]: Leaving directory `/data2/usr/local/src/linux-2.0/drivers'
make: *** [dep-files] Error 2

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
