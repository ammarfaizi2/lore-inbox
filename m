Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311839AbSDNIyS>; Sun, 14 Apr 2002 04:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311841AbSDNIyR>; Sun, 14 Apr 2002 04:54:17 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:32275 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311839AbSDNIyQ>;
	Sun, 14 Apr 2002 04:54:16 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.8-pre3 full compile - warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Apr 2002 18:54:01 +1000
Message-ID: <1605.1018774441@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did a full compile of 2.4.8-pre3 for i386, after suppressing 117
config entries that generated error messages.  Another mail will
contain the error information.

Even after removing all the code that will not compile at all, there
are still a lot of warning messages in 2.5.8-pre3.  I offer this list
in the hope that the maintainers will fix the code (I can dream, can't
I?).  No need to copy me on replies, just fix the code.

arch/i386/kernel/bluesmoke.c: In function `mce_timerfunc':
arch/i386/kernel/bluesmoke.c:267: warning: passing arg 1 of `smp_call_function' from incompatible pointer type
arch/i386/kernel/bluesmoke.c:267: warning: passing arg 2 of `smp_call_function' makes pointer from integer without a cast
arch/i386/kernel/mca.c:314: warning: initialization from incompatible pointer type
arch/i386/kernel/microcode.c: In function `microcode_write':
arch/i386/kernel/microcode.c:341: warning: int format, long int arg (arg 2)

mm/vmalloc.c: In function `vmfree_area_pages':
mm/vmalloc.c:84: warning: unused variable `start'

fs/coda/dir.c: In function `coda_permission':
fs/coda/dir.c:151: warning: unused variable `mode'

fs/devfs/base.c: In function `is_devfsd_or_child':
fs/devfs/base.c:1403: warning: unused variable `p'

drivers/acpi/hardware/hwgpe.c:33: warning: `_THIS_MODULE' defined but not used
drivers/acpi/namespace/nsxfname.c:38: warning: `_THIS_MODULE' defined but not used
drivers/acpi/resources/rsdump.c:31: warning: `_THIS_MODULE' defined but not used
drivers/acpi/utilities/utdebug.c:30: warning: `_THIS_MODULE' defined but not used

drivers/char/mxser.c: In function `mxser_init':
drivers/char/mxser.c:655: warning: suggest parentheses around assignment used as truth value
drivers/char/ip2.c:36: warning: `poll_only' defined but not used
drivers/char/ip2/i2cmd.c:142: warning: `ct89' defined but not used
drivers/char/ip2/i2ellis.c:107: warning: `iiEllisCleanup' defined but not used
drivers/char/applicom.c:268: warning: #warning "LEAK"
drivers/char/applicom.c:532: warning: #warning "Je suis stupide. DW. - copy*user in cli"

drivers/block/ll_rw_blk.c: In function `blk_dev_init':
drivers/block/ll_rw_blk.c:1696: warning: implicit declaration of function `hd_init'

drivers/net/setup.c: In function `special_device_init':
drivers/net/setup.c:154: warning: initialization makes integer from pointer without a cast
drivers/net/depca.c:349: warning: `ALIGN' redefined
include/linux/cache.h:7: warning: this is the location of the previous definition
drivers/net/arlan.c:26: warning: `probe' defined but not used
drivers/net/arlan.c:1128: warning: `arlan_find_devices' defined but not used

drivers/media/video/videodev.c: In function `videodev_exit':
drivers/media/video/videodev.c:503: warning: implicit declaration of function `videodev_proc_destroy'

drivers/char/drm/i810_dma.c: In function `i810_free_page':
drivers/char/drm/i810_dma.c:300: warning: implicit declaration of function `unlock_page'

drivers/net/tokenring/ibmtr.c: In function `find_turbo_adapters':
drivers/net/tokenring/ibmtr.c:262: warning: assignment makes integer from pointer without a cast
drivers/net/tokenring/ibmtr.c:303: warning: passing arg 1 of `iounmap' makes pointer from integer without a cast
drivers/net/tokenring/tmsisa.c:44: warning: `portlist' defined but not used
drivers/net/wan/comx-hw-munich.c: In function `MUNICH_close':
drivers/net/wan/comx-hw-munich.c:2011: warning: assignment from incompatible pointer type
drivers/net/wan/comx-hw-munich.c: In function `BOARD_exit':
drivers/net/wan/comx-hw-munich.c:2780: warning: unused variable `hw'

drivers/ide/ide-tape.c: In function `idetape_output_buffers':
drivers/ide/ide-tape.c:1532: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_update_buffers':
drivers/ide/ide-tape.c:1562: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_copy_stage_from_user':
drivers/ide/ide-tape.c:2927: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_empty_write_pipeline':
drivers/ide/ide-tape.c:3885: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_pad_zeros':
drivers/ide/ide-tape.c:4160: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_chrdev_read':
drivers/ide/ide-tape.c:4603: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c:4622: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_chrdev_write':
drivers/ide/ide-tape.c:4897: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c: In function `idetape_setup':
drivers/ide/ide-tape.c:6082: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c:6082: warning: duplicate `const'
drivers/ide/ide-tape.c:6082: warning: comparison of distinct pointer types lacks a cast
drivers/ide/ide-tape.c:6082: warning: comparison of distinct pointer types lacks a cast

drivers/scsi/53c700.scr:68: unterminated character constant
drivers/scsi/53c700.scr:163: unterminated character constant
drivers/scsi/53c700.scr:190: unterminated character constant
drivers/scsi/qla1280.c:1611: warning: `qla1280_do_dpc' defined but not used
drivers/scsi/ppa.c: In function `ppa_detect':
drivers/scsi/ppa.c:113: warning: `hreg' might be used uninitialized in this function

drivers/ieee1394/sbp2.c: In function `sbp2scsi_complete_command':
drivers/ieee1394/sbp2.c:2838: warning: passing arg 1 of `_raw_spin_lock' from incompatible pointer type
drivers/ieee1394/sbp2.c:2840: warning: passing arg 1 of `_raw_spin_unlock' from incompatible pointer type

drivers/cdrom/gscd.c: In function `__do_gscd_request':
drivers/cdrom/gscd.c:295: warning: int format, pointer arg (arg 2)

sound/oss/bin2hex.c: In function `main':
sound/oss/bin2hex.c:21: warning: implicit declaration of function `exit'
sound/oss/opl3sa2.c: In function `opl3sa2_pm_callback':
sound/oss/opl3sa2.c:981: warning: cast from pointer to integer of different size
sound/oss/ad1816.c:1344: warning: initialization from incompatible pointer type
sound/oss/awe_wave.c:4792: warning: initialization from incompatible pointer type
sound/oss/cmpci.c: In function `cm_release_mixdev':
sound/oss/cmpci.c:1457: warning: unused variable `s'
sound/oss/rme96xx.c: In function `rme96xx_release':
sound/oss/rme96xx.c:1220: warning: unused variable `hwp'
sound/oss/cs4281/cs4281m.c:4479: warning: initialization from incompatible pointer type
sound/oss/cs4281/cs4281m.c:4480: warning: initialization from incompatible pointer type

sound/core/oss/linear.c: In function `convert':
sound/core/oss/linear.c:51: warning: `src' might be used uninitialized in this function
sound/core/oss/linear.c:52: warning: `dst' might be used uninitialized in this function
sound/core/oss/linear.c:53: warning: `src_step' might be used uninitialized in this function
sound/core/oss/linear.c:53: warning: `dst_step' might be used uninitialized in this function
sound/core/oss/linear.c:54: warning: `frames1' might be used uninitialized in this function
sound/core/oss/mulaw.c: In function `mulaw_decode':
sound/core/oss/mulaw.c:166: warning: `src' might be used uninitialized in this function
sound/core/oss/mulaw.c:167: warning: `dst' might be used uninitialized in this function
sound/core/oss/mulaw.c:168: warning: `src_step' might be used uninitialized in this function
sound/core/oss/mulaw.c:168: warning: `dst_step' might be used uninitialized in this function
sound/core/oss/mulaw.c:169: warning: `frames1' might be used uninitialized in this function
sound/core/oss/mulaw.c:183: warning: `sample' might be used uninitialized in this function
sound/core/oss/plugin_ops.h:352: warning: `x' might be used uninitialized in this function
sound/core/oss/plugin_ops.h:353: warning: `x' might be used uninitialized in this function
sound/core/oss/plugin_ops.h:356: warning: `x' might be used uninitialized in this function
sound/core/oss/plugin_ops.h:357: warning: `x' might be used uninitialized in this function
sound/core/oss/plugin_ops.h:360: warning: `x' might be used uninitialized in this function
sound/core/oss/plugin_ops.h:361: warning: `x' might be used uninitialized in this function
sound/core/oss/mulaw.c: In function `mulaw_encode':
sound/core/oss/mulaw.c:209: warning: `src' might be used uninitialized in this function
sound/core/oss/mulaw.c:210: warning: `dst' might be used uninitialized in this function
sound/core/oss/mulaw.c:211: warning: `src_step' might be used uninitialized in this function
sound/core/oss/mulaw.c:211: warning: `dst_step' might be used uninitialized in this function
sound/core/oss/mulaw.c:212: warning: `frames1' might be used uninitialized in this function
sound/core/oss/route.c: In function `route_to_channel_from_one':
sound/core/oss/route.c:98: warning: `conv' might be used uninitialized in this function
sound/core/oss/route.c:101: warning: `src' might be used uninitialized in this function
sound/core/oss/route.c:101: warning: `dst' might be used uninitialized in this function
sound/core/oss/route.c:102: warning: `src_step' might be used uninitialized in this function
sound/core/oss/route.c:102: warning: `dst_step' might be used uninitialized in this function
sound/core/oss/route.c: In function `route_to_channel':
sound/core/oss/route.c:181: warning: `zero' might be used uninitialized in this function
sound/core/oss/route.c:181: warning: `get' might be used uninitialized in this function
sound/core/oss/route.c:181: warning: `add' might be used uninitialized in this function
sound/core/oss/route.c:181: warning: `norm' might be used uninitialized in this function
sound/core/oss/route.c:181: warning: `put_u32' might be used uninitialized in this function
sound/core/oss/route.c:183: warning: `dst' might be used uninitialized in this function
sound/core/oss/route.c:184: warning: `dst_step' might be used uninitialized in this function
sound/core/oss/route.c:218: warning: `ttp' might be used uninitialized in this function
sound/core/oss/route.c:236: warning: `src' might be used uninitialized in this function
sound/core/oss/rate.c: In function `resample_expand':
sound/core/oss/rate.c:74: warning: `S1' might be used uninitialized in this function
sound/core/oss/rate.c:74: warning: `S2' might be used uninitialized in this function
sound/core/oss/rate.c:75: warning: `src' might be used uninitialized in this function
sound/core/oss/rate.c:75: warning: `dst' might be used uninitialized in this function
sound/core/oss/rate.c:76: warning: `channel' might be used uninitialized in this function
sound/core/oss/rate.c:77: warning: `src_step' might be used uninitialized in this function
sound/core/oss/rate.c:77: warning: `dst_step' might be used uninitialized in this function
sound/core/oss/rate.c:78: warning: `src_frames1' might be used uninitialized in this function
sound/core/oss/rate.c:78: warning: `dst_frames1' might be used uninitialized in this function
sound/core/oss/rate.c: In function `resample_shrink':
sound/core/oss/rate.c:162: warning: `S1' might be used uninitialized in this function
sound/core/oss/rate.c:162: warning: `S2' might be used uninitialized in this function
sound/core/oss/rate.c:163: warning: `src' might be used uninitialized in this function
sound/core/oss/rate.c:163: warning: `dst' might be used uninitialized in this function
sound/core/oss/rate.c:165: warning: `src_step' might be used uninitialized in this function
sound/core/oss/rate.c:165: warning: `dst_step' might be used uninitialized in this function
sound/core/oss/rate.c:166: warning: `src_frames1' might be used uninitialized in this function
sound/core/oss/rate.c:166: warning: `dst_frames1' might be used uninitialized in this function

drivers/mtd/devices/doc1000.c:86: warning: #warning This is definitely not SMP safe. Lock the paging mechanism.

drivers/net/pcmcia/axnet_cs.c:1119: warning: `ei_close' defined but not used
drivers/net/tulip/winbond-840.c:149: warning: `version' defined but not used

drivers/video/aty128fb.c: In function `aty128fb_setup':
drivers/video/aty128fb.c:1623: warning: suggest parentheses around assignment used as truth value
drivers/video/aty128fb.c: At top level:
drivers/video/aty128fb.c:219: warning: `font' defined but not used
drivers/video/aty128fb.c:220: warning: `mode' defined but not used
drivers/video/aty128fb.c:221: warning: `nomtrr' defined but not used
drivers/video/radeonfb.c:2508: warning: `fbcon_radeon8' defined but not used
drivers/video/radeonfb.c:601: warning: `radeon_read_OF' declared `static' but never defined
drivers/video/neofb.c: In function `neofb_setup':
drivers/video/neofb.c:2368: warning: implicit declaration of function `strtok'
drivers/video/neofb.c:2368: warning: assignment makes pointer from integer without a cast
drivers/video/neofb.c:2368: warning: assignment makes pointer from integer without a cast
drivers/video/clgenfb.c: In function `clgenfb_setup':
drivers/video/clgenfb.c:2863: warning: implicit declaration of function `strtok'
drivers/video/clgenfb.c:2863: warning: assignment makes pointer from integer without a cast
drivers/video/clgenfb.c:2864: warning: assignment makes pointer from integer without a cast
In file included from drivers/video/sis/sis_main.c:46:
drivers/video/sis/sis_main.h:33: warning: `HW_CURSOR_AREA_SIZE' redefined
drivers/video/sis/sis_main.h:27: warning: this is the location of the previous definition
drivers/video/sis/sis_main.h:92: warning: `IND_SIS_CRT2_WRITE_ENABLE' redefined
drivers/video/sis/sis_main.h:89: warning: this is the location of the previous definition
drivers/video/sis/sis_main.c: In function `sisfb_setup':
drivers/video/sis/sis_main.c:2260: warning: implicit declaration of function `strtok'
drivers/video/sis/sis_main.c:2260: warning: assignment makes pointer from integer without a cast
drivers/video/sis/sis_main.c:2261: warning: assignment makes pointer from integer without a cast
drivers/video/sis/init.c: In function `SiS_SetVCLKState':
drivers/video/sis/init.c:2772: warning: comparison is always 1 due to limited range of data type
drivers/video/sis/init301.c: In function `GetRevisionID':
drivers/video/sis/init301.c:5704: warning: control reaches end of non-void function

drivers/usb/class/printer.c:67: warning: `DEVICE_ID_SIZE' redefined
include/linux/device.h:34: warning: this is the location of the previous definition
In file included from drivers/usb/net/cdc-ether.c:30:
drivers/usb/net/cdc-ether.h:46: warning: `ALIGN' redefined
include/linux/cache.h:7: warning: this is the location of the previous definition
drivers/usb/net/cdc-ether.c:415: warning: `CDC_SetEthernetPacketFilter' defined but not used

drivers/net/irda/w83977af_ir.c:275: warning: `w83977af_close' defined but not used
drivers/net/irda/ali-ircc.c:467: warning: `ali_ircc_probe_43' defined but not used

drivers/hotplug/pci_hotplug_core.c:90: warning: `pcihpfs_statfs' defined but not used

drivers/isdn/avmb1/capi.c:1311: warning: `capinc_tty_break_ctl' defined but not used
drivers/isdn/avmb1/capi.c:1332: warning: `capinc_tty_send_xchar' defined but not used
drivers/isdn/avmb1/capi.c:1340: warning: `capinc_tty_read_proc' defined but not used

net/ipv4/ip_gre.c:123: warning: initialization makes integer from pointer without a cast

net/ipv6/sit.c:67: warning: initialization makes integer from pointer without a cast

net/netrom/nr_out.c: In function `nr_transmit_buffer':
net/netrom/nr_out.c:199: warning: `nr' might be used uninitialized in this function

Although everything compiled, it did not link because of missing symbols.

arch/i386/kernel/pci-pc.o: In function `pci_conf1_read':
arch/i386/kernel/pci-pc.o(.text+0xa3): undefined reference to `mp_bus_id_to_local'
arch/i386/kernel/pci-pc.o: In function `pci_conf1_write':
arch/i386/kernel/pci-pc.o(.text+0x2c3): undefined reference to `mp_bus_id_to_local'
arch/i386/kernel/pci-pc.o: In function `pci_fixup_i450nx':
arch/i386/kernel/pci-pc.o(.text+0x1c01): undefined reference to `quad_local_to_mp_bus_id'
arch/i386/kernel/pci-pc.o(.text+0x1c28): undefined reference to `quad_local_to_mp_bus_id'
arch/i386/kernel/pci-pc.o: In function `pcibios_init':
arch/i386/kernel/pci-pc.o(.text.init+0xbd): undefined reference to `quad_local_to_mp_bus_id'
drivers/video/neofb.o: In function `neofb_setup':
drivers/video/neofb.o(.text.init+0x125): undefined reference to `strtok'
drivers/video/clgenfb.o: In function `clgenfb_setup':
drivers/video/clgenfb.o(.text.init+0x2988): undefined reference to `strtok'
drivers/video/sis/sisfb.o: In function `sisfb_setup':
drivers/video/sis/sisfb.o(.text+0x54e2): undefined reference to `strtok'
drivers/hotplug/ibmphp.o: In function `ibmphp_configure_card':
drivers/hotplug/ibmphp.o(.text+0x5159): undefined reference to `ibmphp_pci_root_ops'
drivers/hotplug/ibmphp.o(.text+0x51e0): undefined reference to `ibmphp_pci_root_ops'
drivers/hotplug/ibmphp.o(.text+0x5206): undefined reference to `ibmphp_pci_root_ops'
drivers/hotplug/ibmphp.o(.text+0x541a): undefined reference to `ibmphp_pci_root_ops'
drivers/hotplug/ibmphp.o(.text+0x565c): undefined reference to `ibmphp_pci_root_ops'
drivers/hotplug/ibmphp.o(.text+0x5a87): more undefined references to `ibmphp_pci_root_ops' follow

Yes, this does mean that I have working kbuild 2.5 rules for 2.5.8-pre3
i386.

