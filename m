Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281549AbRKMG6M>; Tue, 13 Nov 2001 01:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281550AbRKMG6F>; Tue, 13 Nov 2001 01:58:05 -0500
Received: from zok.SGI.COM ([204.94.215.101]:12249 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S281549AbRKMG5w>;
	Tue, 13 Nov 2001 01:57:52 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15-pre4 full build for i386, warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Nov 2001 17:57:41 +1100
Message-ID: <13136.1005634661@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.15-pre4 full build for i386 (using kbuild 2.5), all options set to
Y where possible, some options only allow M, some sources excluded due
to errors, .config at end.  Still lots of warnings.

# Force to N to avoid errors.
# Broken code, SCSI_ABORT_PENDING undefined
CONFIG_USB_HPUSBSCSI=n
# Broken code, includes <limits.h>
CONFIG_BONDING=n
# Broken code, undefined symbol setup_serial_acpi
CONFIG_SERIAL_ACPI=n
# Broken code, duplicate zlib symbols
CONFIG_JFFS2_FS=n

arch/i386/kernel/dmi_scan.c:195: warning: `disable_ide_dma' defined but not used

fs/ncpfs/ncplib_kernel.c:56: warning: `ncp_add_mem_fromfs' defined but not used

fs/affs/super.c:273: warning: #warning

drivers/parport/parport_cs.c:109: warning: `parport_cs_ops' defined but not used

drivers/char/ip2.c:36: warning: `poll_only' defined but not used
drivers/char/ip2/i2cmd.c:142: warning: `ct89' defined but not used
drivers/char/ip2/i2ellis.c:107: warning: `iiEllisCleanup' defined but not used
drivers/char/applicom.c:268: warning: #warning "LEAK"
drivers/char/applicom.c:532: warning: #warning "Je suis stupide. DW. - copy*user in cli"
drivers/char/agp/agpgart_be.c:1533: warning: `intel_820_cleanup' defined but not used

drivers/net/tulip/tulip_core.c: In function `tulip_mwi_config':
drivers/net/tulip/tulip_core.c:1331: warning: label `early_out' defined but not used
drivers/net/wan/comx-hw-mixcom.c: In function `MIXCOM_open':
drivers/net/wan/comx-hw-mixcom.c:569: warning: label `err_restore_flags' defined but not used
drivers/net/sk98lin/skvpd.c:245: warning: `VpdWriteDWord' defined but not used
drivers/net/winbond-840.c:146: warning: `version' defined but not used
drivers/net/arlan.c:26: warning: `probe' defined but not used
drivers/net/arlan.c:1128: warning: `arlan_find_devices' defined but not used
drivers/net/hamradio/6pack.c:703: warning: `msg_invparm' defined but not used
drivers/net/fc/iph5526.c:227: warning: `driver_template' defined but not used
drivers/net/irda/w83977af_ir.c:276: warning: `w83977af_close' defined but not used
drivers/net/irda/ali-ircc.c:467: warning: `ali_ircc_probe_43' defined but not used
drivers/net/pcmcia/axnet_cs.c:1119: warning: `ei_close' defined but not used
drivers/net/tokenring/tmsisa.c:44: warning: `portlist' defined but not used

drivers/media/video/w9966.c:634: warning: `w9966_rReg_i2c' defined but not used

drivers/atm/idt77252.c: In function `idt77252_proc_read':
drivers/atm/idt77252.c:2708: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/atm/idt77252.c:2710: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/atm/idt77252.c:2712: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/atm/idt77252.c:2714: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/atm/idt77252.c:2716: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/atm/idt77252.c:2718: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/atm/idt77252.c:2720: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/atm/idt77252.c:2722: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/atm/idt77252.c:2724: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/atm/idt77252.c:2726: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/atm/idt77252.c:2728: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/atm/idt77252.c:2730: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/atm/idt77252.c:2732: warning: unsigned int format, long unsigned int arg (arg 3)

drivers/ide/pdc202xx.c: In function `config_chipset_for_dma':
drivers/ide/pdc202xx.c:529: warning: `drive_pci' might be used uninitialized in this function
drivers/ide/pdcraid.c: In function `pdcraid_ioctl':
drivers/ide/pdcraid.c:103: warning: unused variable `larg'
drivers/ide/pdcraid.c: In function `pdcraid0_make_request':
drivers/ide/pdcraid.c:287: warning: label `outerr' defined but not used
drivers/ide/pdcraid.c: In function `pdcraid_init_one':
drivers/ide/pdcraid.c:554: warning: unused variable `q'
drivers/ide/pdcraid.c: In function `pdcraid_init':
drivers/ide/pdcraid.c:586: warning: unused variable `i'

drivers/scsi/dpt_i2o.c:115: warning: `DebugFlags' defined but not used

In file included from drivers/scsi/sym53c8xx_2/sym_glue.h:80,
		 from drivers/scsi/sym53c8xx_2/sym_fw.c:56:
include/linux/malloc.h:4: warning: #warning linux/malloc.h is deprecated, use linux/slab.h instead.
In file included from drivers/scsi/sym53c8xx_2/sym_glue.h:80,
		 from drivers/scsi/sym53c8xx_2/sym_glue.c:55:
include/linux/malloc.h:4: warning: #warning linux/malloc.h is deprecated, use linux/slab.h instead.
drivers/scsi/NCR5380.c:795: warning: `NCR5380_print_options' defined but not used
drivers/scsi/qla1280.c:1615: warning: `qla1280_do_dpc' defined but not used
In file included from drivers/scsi/sym53c8xx_2/sym_glue.h:80,
		 from drivers/scsi/sym53c8xx_2/sym_malloc.c:56:
include/linux/malloc.h:4: warning: #warning linux/malloc.h is deprecated, use linux/slab.h instead.
In file included from drivers/scsi/sym53c8xx_2/sym_glue.h:80,
		 from drivers/scsi/sym53c8xx_2/sym_hipd.c:58:
include/linux/malloc.h:4: warning: #warning linux/malloc.h is deprecated, use linux/slab.h instead.
In file included from drivers/scsi/sym53c8xx_2/sym_glue.h:80,
		 from drivers/scsi/sym53c8xx_2/sym_misc.c:56:
include/linux/malloc.h:4: warning: #warning linux/malloc.h is deprecated, use linux/slab.h instead.
In file included from drivers/scsi/sym53c8xx_2/sym_glue.h:80,
		 from drivers/scsi/sym53c8xx_2/sym_nvram.c:56:
include/linux/malloc.h:4: warning: #warning linux/malloc.h is deprecated, use linux/slab.h instead.

drivers/scsi/i60uscsi.c: In function `__orc_alloc_scb':
drivers/scsi/i60uscsi.c:643: warning: unused variable `flags'
drivers/scsi/scsi_debug.c: In function `scsi_debug_biosparam':
drivers/scsi/scsi_debug.c:656: warning: unused variable `size'
drivers/scsi/osst.c: In function `osst_reposition_and_retry':
drivers/scsi/osst.c:1385: warning: `expected' might be used uninitialized in this function

drivers/ieee1394/pcilynx.c:775: warning: `aux_ops' defined but not used

drivers/sound/ad1816.c:1344: warning: initialization from incompatible pointer type
drivers/sound/awe_wave.c:4794: warning: initialization from incompatible pointer type
drivers/sound/cmpci.c: In function `cm_release_mixdev':
drivers/sound/cmpci.c:1457: warning: unused variable `s'
drivers/sound/rme96xx.c: In function `rme96xx_release':
drivers/sound/rme96xx.c:1220: warning: unused variable `hwp'
drivers/sound/trident.c: In function `trident_probe':
drivers/sound/trident.c:3945: warning: unused variable `mask'
drivers/sound/cs4281/cs4281m.c:4478: warning: initialization from incompatible pointer type
drivers/sound/cs4281/cs4281m.c:4479: warning: initialization from incompatible pointer type

drivers/mtd/devices/doc1000.c:87: warning: #warning This is definitely not SMP safe. Lock the paging mechanism.

drivers/video/aty128fb.c: In function `aty128fb_setup':
drivers/video/aty128fb.c:1623: warning: suggest parentheses around assignment used as truth value
drivers/video/radeonfb.c: In function `radeonfb_setup':
drivers/video/radeonfb.c:645: warning: suggest parentheses around assignment used as truth value
drivers/video/aty128fb.c: At top level:
drivers/video/aty128fb.c:219: warning: `font' defined but not used
drivers/video/aty128fb.c:220: warning: `mode' defined but not used
drivers/video/aty128fb.c:221: warning: `nomtrr' defined but not used
drivers/video/vesafb.c: In function `vesafb_setup':
drivers/video/vesafb.c:460: warning: suggest parentheses around assignment used as truth value
drivers/video/radeonfb.c: At top level:
drivers/video/radeonfb.c:2506: warning: `fbcon_radeon8' defined but not used
drivers/video/radeonfb.c:601: warning: `radeon_read_OF' declared `static' but never defined
drivers/video/tdfxfb.c: In function `tdfxfb_setup':
drivers/video/tdfxfb.c:2089: warning: suggest parentheses around assignment used as truth value
drivers/video/vga16fb.c: In function `vga16fb_setup':
drivers/video/vga16fb.c:695: warning: suggest parentheses around assignment used as truth value
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_ioctl':
drivers/video/matrox/matroxfb_base.c:1062: warning: implicit declaration of function `matroxfb_switch'
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_setup':
drivers/video/matrox/matroxfb_base.c:2375: warning: suggest parentheses around assignment used as truth value
drivers/video/matrox/matroxfb_g450.c: In function `matroxfb_g450_connect':
drivers/video/matrox/matroxfb_g450.c:171: warning: implicit declaration of function `matroxfb_switch'
drivers/video/matrox/matroxfb_g450.c: At top level:
drivers/video/matrox/matroxfb_g450.c:19: warning: `matroxfb_g450_get_reg' defined but not used
In file included from drivers/video/sis/sis_main.c:46:
drivers/video/sis/sis_main.h:33: warning: `HW_CURSOR_AREA_SIZE' redefined
drivers/video/sis/sis_main.h:27: warning: this is the location of the previous definition
drivers/video/sis/sis_main.h:92: warning: `IND_SIS_CRT2_WRITE_ENABLE' redefined
drivers/video/sis/sis_main.h:89: warning: this is the location of the previous definition
drivers/video/riva/fbdev.c: In function `rivafb_setup':
drivers/video/riva/fbdev.c:2048: warning: suggest parentheses around assignment used as truth value
drivers/video/sis/init.c: In function `SiS_SetVCLKState':
drivers/video/sis/init.c:2772: warning: comparison is always 1 due to limited range of data type
drivers/video/vfb.c: In function `vfb_setup':
drivers/video/vfb.c:385: warning: suggest parentheses around assignment used as truth value
drivers/video/sis/init301.c: In function `GetRevisionID':
drivers/video/sis/init301.c:5704: warning: control reaches end of non-void function
drivers/video/sstfb.c: In function `sstfb_setup':
drivers/video/sstfb.c:1700: warning: suggest parentheses around assignment used as truth value

drivers/usb/serial/ftdi_sio.c: In function `ftdi_sio_write':
drivers/usb/serial/ftdi_sio.c:440: warning: unused variable `dbug_byte'
drivers/usb/storage/freecom.c:214: warning: `freecom_ide_read' defined but not used

drivers/telephony/ixj.h:41: warning: `ixj_h_rcsid' defined but not used
include/linux/ixjuser.h:45: warning: `ixjuser_h_rcsid' defined but not used

drivers/md/lvm-snap.c: In function `lvm_snapshot_release':
drivers/md/lvm-snap.c:545: warning: unused variable `nbhs'

In file included from net/8021q/vlanproc.c:24:
include/linux/malloc.h:4: warning: #warning linux/malloc.h is deprecated, use linux/slab.h instead.

drivers/sound/msndperm.c:723: warning: `msndpermLen' defined but not used
drivers/sound/msndinit.c:158: warning: `msndinitLen' defined but not used
drivers/sound/pndsperm.c:723: warning: `pndspermLen' defined but not used
drivers/sound/pndspini.c:158: warning: `pndspiniLen' defined but not used

depmod: *** Unresolved symbols in /var/tmp/lib/modules/2.4.15-pre4/kernel/drivers/char/isicom.o
depmod:		xquad_portio
depmod: *** Unresolved symbols in /var/tmp/lib/modules/2.4.15-pre4/kernel/drivers/isdn/hysdn/hysdn.o
depmod:		xquad_portio
depmod: *** Unresolved symbols in /var/tmp/lib/modules/2.4.15-pre4/kernel/drivers/net/wan/cosa.o
depmod:		xquad_portio
depmod: *** Unresolved symbols in /var/tmp/lib/modules/2.4.15-pre4/kernel/drivers/net/wan/hostess_sv11.o
depmod:		xquad_portio
depmod: *** Unresolved symbols in /var/tmp/lib/modules/2.4.15-pre4/kernel/drivers/net/wan/sealevel.o
depmod:		xquad_portio
depmod: *** Unresolved symbols in /var/tmp/lib/modules/2.4.15-pre4/kernel/drivers/scsi/pcmcia/aha152x_cs.o
depmod:		xquad_portio
depmod: *** Unresolved symbols in /var/tmp/lib/modules/2.4.15-pre4/kernel/drivers/scsi/pcmcia/fdomain_cs.o
depmod:		xquad_portio
depmod: *** Unresolved symbols in /var/tmp/lib/modules/2.4.15-pre4/kernel/drivers/scsi/pcmcia/nsp_cs.o
depmod:		xquad_portio
depmod: *** Unresolved symbols in /var/tmp/lib/modules/2.4.15-pre4/kernel/drivers/scsi/pcmcia/qlogic_cs.o
depmod:		xquad_portio
depmod: *** Unresolved symbols in /var/tmp/lib/modules/2.4.15-pre4/kernel/drivers/sound/wavefront.o
depmod:		xquad_portio

begin 644 config-2.4.15-pre4-allyes.bz2
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
7<&+/*5RU--.T3*9?^+N2*<*$@)EG4M``
`
end

