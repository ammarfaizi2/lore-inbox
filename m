Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSHXXnK>; Sat, 24 Aug 2002 19:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSHXXnJ>; Sat, 24 Aug 2002 19:43:09 -0400
Received: from ppp-217-133-222-183.dialup.tiscali.it ([217.133.222.183]:44680
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S316878AbSHXXnI>; Sat, 24 Aug 2002 19:43:08 -0400
Subject: Broken inlines all over the source tree
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Kernel Janitors ML 
	<kernel-janitor-discuss@lists.sourceforge.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-oZlM65vj/c7Lfo9y5aTE"
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 Aug 2002 01:47:18 +0200
Message-Id: <1030232838.1451.99.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oZlM65vj/c7Lfo9y5aTE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

GCC can only inline functions when the function definition comes before
its use.
Unfortunately a lot of code hasn't been written with this in mind.

Here is a list of files containing forward declarations for inline
functions (that are either broken or redundant).
The list was made with grep -E '(inline|inline__)[ '$'\t''][^{]*;' so
it's not very accurate.

gcc -Winline would provide better results.
How about adding it to the build CFLAGS?

Here is the list (excluding mm/rmap.c that I already fixed).

./drivers/hotplug/ibmphp_res.c
./drivers/net/hamradio/dmascc.c
./drivers/net/tulip/dmfe.c
./drivers/net/au1000_eth.c
./drivers/net/wan/lmc/lmc_debug.h
./drivers/net/wan/lmc/lmc_media.c
./drivers/net/wan/dscc4.c
./drivers/net/e1000/e1000_main.c
./drivers/net/sb1000.c
./drivers/net/ioc3-eth.c
./drivers/net/seeq8005.c
./drivers/net/mace.c
./drivers/net/eql.c
./drivers/net/bonding.c
./drivers/net/via-rhine.c
./drivers/net/hamachi.c
./drivers/net/smc9194.c
./drivers/isdn/hisax/isar.c
./drivers/isdn/hisax/ipacx.c
./drivers/isdn/sc/command.c
./drivers/video/riva/fbdev.c
./drivers/video/fbcon.c
./drivers/video/cyberfb.h
./drivers/video/virgefb.c
./drivers/video/platinumfb.c
./drivers/video/valkyriefb.c
./drivers/media/video/w9966.c
./drivers/media/video/planb.c
./drivers/media/radio/radio-maestro.c
./drivers/char/ftape/zftape/zftape-vtbl.h
./drivers/char/istallion.c
./drivers/char/stallion.c
./drivers/char/dz.h
./drivers/char/ser_a2232.c
./drivers/char/qtronix.c
./drivers/char/rtc.c
./drivers/char/epca.c
./drivers/char/pcxx.c
./drivers/char/mxser.c
./drivers/char/ip2main.c
./drivers/acorn/block/fd1772.c
./drivers/scsi/aic7xxx/aic7xxx_osm.h
./drivers/scsi/aic7xxx/aic7xxx_linux.c
./drivers/scsi/aic7xxx/aic7xxx_inline.h
./drivers/scsi/ips.c
./drivers/scsi/sun3_scsi.c
./drivers/scsi/sim710.c
./drivers/scsi/advansys.c
./drivers/scsi/fastlane.c
./drivers/scsi/sg.c
./drivers/scsi/AM53C974.c
./drivers/scsi/mac_esp.c
./drivers/scsi/tmscsim.c
./drivers/scsi/ultrastor.c
./drivers/scsi/megaraid.h
./drivers/scsi/qla1280.c
./drivers/s390/char/tape.c
./drivers/s390/char/tape.h
./drivers/mtd/devices/doc1000.c
./drivers/usb/media/se401.h
./drivers/usb/serial/whiteheat.c
./drivers/usb/net/rtl8150.c
./drivers/usb/host/hc_simple.h
./drivers/block/cpqarray.c
./drivers/block/ataflop.c
./drivers/block/xd.h
./drivers/block/cciss.c
./drivers/sgi/char/ds1286.c
./drivers/cdrom/sonycd535.c
./arch/mips/au1000/common/irq.c
./arch/ia64/sn/io/l1.c
./include/net/irda/timer.h
./include/net/ip.h
./include/linux/fsfilter.h
./include/linux/elevator.h
./include/linux/sched.h
./include/linux/coda_linux.h
./include/linux/blkdev.h
./include/linux/intermezzo_fs.h
./include/linux/bio.h
./include/linux/reiserfs_fs.h
./include/asm-ppc64/tlb.h
./include/asm-ia64/unistd.h
./include/asm-x86_64/apic.h
./include/asm-s390x/processor.h
./include/asm-arm/thread_info.h
./include/asm-arm/current.h
./include/asm-arm/unistd.h
./include/asm-i386/apic.h
./net/core/sock.c
./net/irda/wrapper.c
./net/bluetooth/sco.c
./net/bluetooth/l2cap.c
./net/atm/lec.c
./net/wanrouter/af_wanpipe.c
./net/appletalk/ddp.c
./fs/jfs/resize.c
./fs/ntfs/ntfs.h
./fs/intermezzo/super.c
./fs/freevxfs/vxfs_extern.h
./fs/affs/file.c


--=-oZlM65vj/c7Lfo9y5aTE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9aBsGdjkty3ft5+cRAukZAJ9oQD6qz3IdHWCcLeBXZTEjadbawwCg2+j1
GTmc3VtwnlMfTa1lTlU5cvs=
=Jk3e
-----END PGP SIGNATURE-----

--=-oZlM65vj/c7Lfo9y5aTE--
