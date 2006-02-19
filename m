Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWBSLhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWBSLhK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 06:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWBSLhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 06:37:10 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:58119 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932400AbWBSLhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 06:37:08 -0500
Date: Sun, 19 Feb 2006 12:36:30 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org, rusty@rustcorp.com.au
Subject: Re: kbuild: Section mismatch warnings
Message-ID: <20060219113630.GA5032@mars.ravnborg.org>
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217224702.GA25761@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 11:47:02PM +0100, Sam Ravnborg wrote:
> Background:
> I have introduced a build-time check for section mismatch and it showed
> up a great number of warnings.
> Below is the result of the run on a 2.6.16-rc1 tree (which my kbuild
> tree is based upon) based on a 'make allmodconfig'

Updated list of warnings below. This time on a rc4 tree and with
referenced symbol included in warning (when possible).
This is with my latest kbuild tree which will show up in next -mm.

Question: Several modules contains init_module() cleanup_module() -
for example floppy.o. I cannot see they are used anymore and subject for
deletion - correct?

The module parameter warning are still pending - I hope Rusty will
comment on yhe suggested patch to use __initdata in the moduleparam
macro.

	Sam

WARNING: drivers/acpi/asus_acpi.o - Section mismatch: reference to .init.text:asus_hotk_add from .data between 'asus_hotk_driver' (at offset 0xe0) and 'model_conf'
WARNING: drivers/atm/fore_200e.o - Section mismatch: reference to .init.text: from .text between 'fore200e_pca_detect' (at offset 0x21bf) and 'fore200e_pca_remove_one'
WARNING: drivers/block/cpqarray.o - Section mismatch: reference to .init.text:cpqarray_init_one from .data between 'cpqarray_pci_driver' (at offset 0x60) and 'products'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data: from .text between 'init_module' (at offset 0x69b7) and 'cleanup_module'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data: from .text between 'init_module' (at offset 0x69d6) and 'cleanup_module'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data: from .text between 'init_module' (at offset 0x69dd) and 'cleanup_module'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data: from .text between 'init_module' (at offset 0x69e9) and 'cleanup_module'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data: from .text between 'init_module' (at offset 0x69f9) and 'cleanup_module'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data: from .text between 'init_module' (at offset 0x6a22) and 'cleanup_module'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data: from .text between 'init_module' (at offset 0x6a5a) and 'cleanup_module'
WARNING: drivers/char/hw_random.o - Section mismatch: reference to .init.text:intel_init from .data between 'rng_vendor_ops' (at offset 0x2c8) and 'rng_lock.0'
WARNING: drivers/char/hw_random.o - Section mismatch: reference to .init.text:amd_init from .data between 'rng_vendor_ops' (at offset 0x2f0) and 'rng_lock.0'
WARNING: drivers/char/hw_random.o - Section mismatch: reference to .init.text:geode_init from .data between 'rng_vendor_ops' (at offset 0x318) and 'rng_lock.0'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text: from .text between 'cleanup_module' (at offset 0x1fa4) and 'ip2_loadmain'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text: from .text between 'ip2_loadmain' (at offset 0x32d5) and 'ip2_interrupt'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x1f97) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x20c2) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x2210) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x227d) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.data: from .text between 'init_module' (at offset 0x229f) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.data: from .text between 'init_module' (at offset 0x22c2) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.data: from .text between 'init_module' (at offset 0x22da) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x251a) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text:ide_scan_pcibus from .text between 'init_module' (at offset 0x2544) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text:ide_probe_for_cmd640x from .text between 'init_module' (at offset 0x2549) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text:pnpide_init from .text between 'init_module' (at offset 0x254e) and 'cleanup_module'
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference to .init.data: from .data between '' (at offset 0x8) and '__param_str_dev3'
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference to .init.data: from .data between '' (at offset 0x28) and '__param_str_dev3'
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference to .init.data: from .data between '__param_arr_dev2' (at offset 0x48) and '__param_str_dev2'
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference to .init.data: from .data between '__param_arr_dev2' (at offset 0x68) and '__param_str_dev2'
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference to .init.data: from .data between '__param_arr_dev' (at offset 0x88) and '__param_str_dev'
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference to .init.data:db9 from .data between '__param_arr_dev' (at offset 0xa8) and '__param_str_dev'
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.data: from .data between '__param_arr_map3' (at offset 0x28) and '__param_str_map3'
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.data: from .data between '__param_arr_map3' (at offset 0x48) and '__param_str_map3'
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.data: from .data between '__param_arr_map2' (at offset 0x68) and '__param_str_map2'
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.data: from .data between '__param_arr_map2' (at offset 0x88) and '__param_str_map2'
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.data: from .data between '__param_arr_map' (at offset 0xa8) and '__param_str_map'
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.data:gc from .data between '__param_arr_map' (at offset 0xc8) and '__param_str_map'
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference to .init.data: from .data between '' (at offset 0x8) and '__param_str_map3'
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference to .init.data: from .data between '' (at offset 0x28) and '__param_str_map3'
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference to .init.data: from .data between '__param_arr_map2' (at offset 0x48) and '__param_str_map2'
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference to .init.data: from .data between '__param_arr_map2' (at offset 0x68) and '__param_str_map2'
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference to .init.data: from .data between '__param_arr_map' (at offset 0x88) and '__param_str_map'
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference to .init.data:tgfx from .data between '__param_arr_map' (at offset 0xa8) and '__param_str_map'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_s0box from .text between 'checkcard' (at offset 0x8db) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_telespci from .text between 'checkcard' (at offset 0x8e8) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_avm_pcipnp from .text between 'checkcard' (at offset 0x902) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_diva from .text between 'checkcard' (at offset 0x91c) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_netjet_s from .text between 'checkcard' (at offset 0x936) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_hfcpci from .text between 'checkcard' (at offset 0x940) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_niccy from .text between 'checkcard' (at offset 0x954) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_bkm_a4t from .text between 'checkcard' (at offset 0x95e) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_sct_quadro from .text between 'checkcard' (at offset 0x968) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_gazel from .text between 'checkcard' (at offset 0x972) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_w6692 from .text between 'checkcard' (at offset 0x97c) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_netjet_u from .text between 'checkcard' (at offset 0x986) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_enternow_pci from .text between 'checkcard' (at offset 0x990) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:init_ipacx from .text between 'Diva_card_msg' (at offset 0x282e1) and 'ph_command'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:inittiger from .text between 'NETjet_S_card_msg' (at offset 0x302fc) and 'NETjet_ReadIC'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:inittiger from .text between 'NETjet_U_card_msg' (at offset 0x32011) and 'ph_command'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:clear_pending_icc_ints from .text between 'NETjet_U_card_msg' (at offset 0x32021) and 'ph_command'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:initicc from .text between 'NETjet_U_card_msg' (at offset 0x32029) and 'ph_command'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:clear_pending_jade_ints from .text between 'BKM_card_msg' (at offset 0x3a5a4) and 'jade_write_indirect'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:initjade from .text between 'BKM_card_msg' (at offset 0x3a5b4) and 'jade_write_indirect'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:inittiger from .text between 'enpci_card_msg' (at offset 0x3f471) and 'enpci_interrupt'
WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .init.text:av7110_ir_init from .text between 'av7110_attach' (at offset 0xcaa6) and 'av7110_detach'
WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .exit.text:av7110_ir_exit from .text between 'av7110_detach' (at offset 0xcbc5) and 'av7110_irq'
WARNING: drivers/net/acenic.o - Section mismatch: reference to .init.data:tigon2FwText from .text after 'acenic_probe_one' (at offset 0x3409)
WARNING: drivers/net/acenic.o - Section mismatch: reference to .init.data:tigon2FwRodata from .text after 'acenic_probe_one' (at offset 0x3422)
WARNING: drivers/net/acenic.o - Section mismatch: reference to .init.data: from .text after 'acenic_probe_one' (at offset 0x343b)
WARNING: drivers/net/de620.o - Section mismatch: reference to .init.text:de620_probe from .text between 'init_module' (at offset 0x1681) and 'cleanup_module'
WARNING: drivers/net/dgrs.o - Section mismatch: reference to .init.text:dgrs_pci_probe from .data between 'dgrs_pci_driver' (at offset 0x160) and 'dgrs_ipxnet'
WARNING: drivers/net/tulip/de2104x.o - Section mismatch: reference to .init.text:de_init_one from .data between 'de_driver' (at offset 0xa0) and 'de_ethtool_ops'
WARNING: drivers/net/tulip/de2104x.o - Section mismatch: reference to .exit.text:de_remove_one from .data between 'de_driver' (at offset 0xa8) and 'de_ethtool_ops'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data: from .text between 'init_module' (at offset 0x14ef) and 'cleanup_module'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x14f9) and 'cleanup_module'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data: from .text between 'init_module' (at offset 0x1518) and 'cleanup_module'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x1531) and 'cleanup_module'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data:mac from .data between '__param_arr_mac' (at offset 0x48) and '__param_str_mac'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data:rxl from .data between '__param_arr_rxl' (at offset 0x88) and '__param_str_rxl'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data:baud from .data between '__param_arr_baud' (at offset 0xc8) and '__param_str_baud'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data:irq from .data between '__param_arr_irq' (at offset 0x108) and '__param_str_irq'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data:io from .data between '__param_arr_io' (at offset 0x148) and '__param_str_io'
WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.data: from .data between '__param_arr_io_hi' (at offset 0xc8) and '__param_str_io_hi'
WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.data:io from .data between '__param_arr_io' (at offset 0x108) and '__param_str_io'
WARNING: drivers/scsi/gdth.o - Section mismatch: reference to .init.data:irq from .data between '__param_arr_irq' (at offset 0x248) and '__param_str_irq'
WARNING: drivers/scsi/gdth.o - Section mismatch: reference to .init.text:gdth_detect from .data between 'driver_template' (at offset 0x270) and 'async_cache_tab'
WARNING: drivers/usb/gadget/g_ether.o - Section mismatch: reference to .init.text:eth_bind from .data between 'eth_driver' (at offset 0x70) and 'stringtab'
WARNING: drivers/usb/gadget/g_file_storage.o - Section mismatch: reference to .init.text:fsg_bind from .data between 'fsg_driver' (at offset 0x130) and 'stringtab'
WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text:usb_ep_autoconfig_reset from .text between 'gs_bind' (at offset 0x1d2c) and '.text.lock.serial'
WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text:usb_ep_autoconfig from .text between 'gs_bind' (at offset 0x1d3b) and '.text.lock.serial'
WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text:usb_ep_autoconfig from .text between 'gs_bind' (at offset 0x1d64) and '.text.lock.serial'
WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text:usb_ep_autoconfig from .text between 'gs_bind' (at offset 0x1d96) and '.text.lock.serial'
WARNING: drivers/usb/gadget/g_zero.o - Section mismatch: reference to .init.text:usb_ep_autoconfig_reset from .text between 'zero_bind' (at offset 0x11c1) and 'zero_suspend'
WARNING: drivers/usb/gadget/g_zero.o - Section mismatch: reference to .init.text:usb_ep_autoconfig from .text between 'zero_bind' (at offset 0x11d0) and 'zero_suspend'
WARNING: drivers/usb/gadget/g_zero.o - Section mismatch: reference to .init.text:usb_ep_autoconfig from .text between 'zero_bind' (at offset 0x1218) and 'zero_suspend'
WARNING: drivers/usb/host/isp116x-hcd.o - Section mismatch: reference to .init.text:isp116x_probe from .data between '' (at offset 0x0) and 'isp116x_hc_driver'
WARNING: drivers/video/arcfb.o - Section mismatch: reference to .init.text:arcfb_probe from .data between 'arcfb_driver' (at offset 0x60) and 'arcfb_ops'
WARNING: drivers/video/aty/aty128fb.o - Section mismatch: reference to .init.text:aty128_probe from .data between 'aty128fb_driver' (at offset 0x640) and 'aty128fb_ops'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.data: from .text between 'atyfb_pci_probe' (at offset 0x2ac9) and 'atyfb_pci_remove'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.text:aty_init_cursor from .text between 'atyfb_pci_probe' (at offset 0x2b62) and 'atyfb_pci_remove'
WARNING: drivers/video/geode/gx1fb.o - Section mismatch: reference to .init.text: from .data between 'gx1fb_driver' (at offset 0x100) and 'gx1fb_ops'
WARNING: drivers/video/hgafb.o - Section mismatch: reference to .init.text:hgafb_probe from .data between 'hgafb_driver' (at offset 0x140) and 'hgafb_device'
WARNING: drivers/video/macmodes.o - Section mismatch: reference to .init.text:mac_find_mode from __ksymtab between '' (at offset 0x0) and '__ksymtab_mac_map_monitor_sense'
WARNING: drivers/video/nvidia/nvidiafb.o - Section mismatch: reference to .exit.text: from .data between 'nvidiafb_driver' (at offset 0x1688) and 'nvidia_fb_ops'
WARNING: drivers/video/riva/rivafb.o - Section mismatch: reference to .exit.text: from .data between 'rivafb_driver' (at offset 0x5c8) and 'riva_fb_ops'
WARNING: drivers/video/savage/savagefb.o - Section mismatch: reference to .init.data: from .text between 'savagefb_probe' (at offset 0x34c3) and 'savagefb_remove'
WARNING: drivers/video/vfb.o - Section mismatch: reference to .init.text:vfb_probe from .data between 'vfb_driver' (at offset 0x40) and 'vfb_device'
WARNING: drivers/video/vga16fb.o - Section mismatch: reference to .init.text:vga16fb_probe from .data between '' (at offset 0x120) and 'vga16fb_device'
WARNING: fs/jffs2/jffs2.o - Section mismatch: reference to .init.text:jffs2_zlib_init from .text between 'jffs2_compressors_init' (at offset 0x5d3) and 'jffs2_compressors_exit'
WARNING: net/decnet/decnet.o - Section mismatch: reference to .init.data:addr from .data between '__param_arr_addr' (at offset 0x7e8) and '__param_str_addr'
WARNING: net/ipv4/netfilter/ip_conntrack.o - Section mismatch: reference to .init.text:ip_conntrack_init from .text between 'init_or_cleanup' (at offset 0x783) and 'ip_conntrack_protocol_register'
WARNING: net/ipv4/netfilter/iptable_nat.o - Section mismatch: reference to .init.text:ip_nat_rule_init from .text after 'init_or_cleanup' (at offset 0xab5)
WARNING: sound/drivers/snd-dummy.o - Section mismatch: reference to .init.text: from .data between 'snd_dummy_driver' (at offset 0x3c0) and 'snd_card_dummy_capture_ops'
WARNING: sound/drivers/snd-mtpav.o - Section mismatch: reference to .init.text:snd_mtpav_probe from .data between 'snd_mtpav_driver' (at offset 0x40) and 'snd_mtpav_output'
WARNING: sound/drivers/snd-serial-u16550.o - Section mismatch: reference to .init.text:snd_serial_probe from .data between 'snd_serial_driver' (at offset 0x840) and 'adaptor_names'
WARNING: sound/drivers/snd-virmidi.o - Section mismatch: reference to .init.text: from .data after 'snd_virmidi_driver' (at offset 0x2e0)
WARNING: sound/oss/cs4232.o - Section mismatch: reference to .init.text: from .text between 'cs4232_pnp_probe' (at offset 0x13b) and 'cs4232_pnp_remove'
WARNING: sound/oss/forte.o - Section mismatch: reference to .init.text:forte_probe from .data between 'forte_pci_driver' (at offset 0x60) and 'forte_dsp_fops'
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:cdirq from .text after 'init_mad16' (at offset 0x172)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:cddma from .text after 'init_mad16' (at offset 0x198)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data: from .text after 'init_mad16' (at offset 0x1cc)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:joystick from .text after 'init_mad16' (at offset 0x1d5)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data: from .text after 'init_mad16' (at offset 0x1fa)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:joystick from .text after 'init_mad16' (at offset 0x203)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data: from .text after 'init_mad16' (at offset 0x229)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:cdirq from .text after 'init_mad16' (at offset 0x22f)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data: from .text after 'init_mad16' (at offset 0x23f)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:opl4 from .text after 'init_mad16' (at offset 0x262)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:dma_map from .text after 'init_mad16' (at offset 0x278)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:cdport from .text after 'init_mad16' (at offset 0x2bd)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:irq_map from .text after 'init_mad16' (at offset 0x2e0)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:cddma from .text after 'init_mad16' (at offset 0x2f7)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:opl4 from .text after 'init_mad16' (at offset 0x312)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:dma_map from .text after 'init_mad16' (at offset 0x31d)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data: from .text after 'init_mad16' (at offset 0x329)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:cddma from .text after 'init_mad16' (at offset 0x338)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:cdport from .text after 'init_mad16' (at offset 0x388)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:irq_map from .text after 'init_mad16' (at offset 0x38f)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:dma from .text after 'init_mad16' (at offset 0x3a9)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:cdtype from .text after 'init_mad16' (at offset 0x3af)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:dma16 from .text after 'init_mad16' (at offset 0x3b5)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:irq from .text after 'init_mad16' (at offset 0x3bb)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.text: from .text after 'init_mad16' (at offset 0x519)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.text: from .text after 'init_mad16' (at offset 0x545)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.text: from .text after 'init_mad16' (at offset 0x5c9)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.text: from .text after 'init_mad16' (at offset 0x658)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.text: from .text after 'init_mad16' (at offset 0x6a2)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.text: from .text after 'init_mad16' (at offset 0x6d0)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:mpu_irq from .text after 'init_mad16' (at offset 0xc5e)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data:io from .text after 'init_mad16' (at offset 0xc71)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data: from .text after 'init_mad16' (at offset 0xe7e)
WARNING: sound/oss/maestro.o - Section mismatch: reference to .init.text:maestro_probe from .data between 'maestro_pci_driver' (at offset 0x100) and 'acpi_state_mask'
WARNING: sound/oss/msnd.o - Section mismatch: reference to .init.text:msnd_register from __ksymtab after '__ksymtab_msnd_register' (at offset 0xf0)
