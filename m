Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbWFWRkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWFWRkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWFWRkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:40:15 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:42135 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751821AbWFWRkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:40:13 -0400
Date: Fri, 23 Jun 2006 19:40:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Section mismatch warnings
Message-ID: <Pine.LNX.4.61.0606231938080.26864@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


as others have already seen to, 2.6.17 spits out a lot of section mismatch 
warnings on modpost. Some of them have may already been addressed; here is 
the output I get when MODPOST starts to run during the compile process of 
an almost-completely-compiled kernel. Need .config?

  MODPOST
WARNING: drivers/atm/he.o - Section mismatch: reference to .init.text: from .text after 'he_init_one' (at offset 0x2915)
WARNING: drivers/atm/idt77105.o - Section mismatch: reference to .init.text:idt77105_init from __ksymtab after '__ksymtab_idt77105_init' (at offset 0x0)
WARNING: drivers/atm/iphase.o - Section mismatch: reference to .init.text: from .text between 'ia_init_one' (at offset 0x1f15) and 'ia_int'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x3c)
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x40)
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x44)
WARNING: drivers/block/paride/pg.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x4)
WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to .init.text: from .text between 'cleanup_module' (at offset 0x47d0) and 'iiWriteWord8'
WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to .init.text: from .text after 'ip2_loadmain' (at offset 0x56a2)
WARNING: drivers/char/ipmi/ipmi_msghandler.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0xc)
WARNING: drivers/char/ipmi/ipmi_si.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x0)
WARNING: drivers/char/ipmi/ipmi_watchdog.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x14)
WARNING: drivers/char/ipmi/ipmi_watchdog.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x18)
WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x0)
WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x4)
WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x8)
WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0xc)
WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x10)
WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x14)
WARNING: drivers/ieee1394/ieee1394.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x0)
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x0)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x0)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x4)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x8)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0xc)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x10)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x14)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x18)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x1c)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x20)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x24)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x28)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x2c)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x30)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x34)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x38)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x3c)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x40)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x44)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x48)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x4c)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x50)
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x0)
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x140) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x16c) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x198) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x1c4) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x1f0) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x21c) and '__param_str_force'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_teles0 from .text between 'checkcard' (at offset 0x789) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_avm_a1 from .text between 'checkcard' (at offset 0xa22) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_ix1micro from .text between 'checkcard' (at offset 0xa31) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_s0box from .text between 'checkcard' (at offset 0xa40) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_avm_pcipnp from .text between 'checkcard' (at offset 0xa5e) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_isurf from .text between 'checkcard' (at offset 0xa7c) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_hfcs from .text between 'checkcard' (at offset 0xa8b) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_saphir from .text between 'checkcard' (at offset 0xa9a) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_bkm_a4t from .text between 'checkcard' (at offset 0xaa9) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_sct_quadro from .text between 'checkcard' (at offset 0xab9) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_gazel from .text between 'checkcard' (at offset 0xac9) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_hfcpci from .text between 'checkcard' (at offset 0xad9) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_w6692 from .text between 'checkcard' (at offset 0xae9) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_netjet_u from .text between 'checkcard' (at offset 0xb09) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_enternow_pci from .text between 'checkcard' (at offset 0xb23) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_TeleInt from .text between 'checkcard' (at offset 0xb32) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_sportster from .text between 'checkcard' (at offset 0xb41) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_mic from .text between 'checkcard' (at offset 0xb50) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_netjet_s from .text between 'checkcard' (at offset 0xb7d) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_telespci from .text between 'checkcard' (at offset 0xb8c) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_niccy from .text between 'checkcard' (at offset 0xb9b) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_diva from .text between 'checkcard' (at offset 0xbaa) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_asuscom from .text between 'checkcard' (at offset 0xbb9) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:init_ipacx from .text between 'Diva_card_msg' (at offset 0x2d88f) and 'ReadISAC'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:inithfc from .text between 'TeleInt_card_msg' (at offset 0x313c1) and 'WriteHFC'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:inittiger from .text between 'NETjet_S_card_msg' (at offset 0x3c1ac) and 'netjet_s_interrupt'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:inittiger from .text between 'NETjet_U_card_msg' (at offset 0x3e29e) and 'netjet_u_interrupt'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:clear_pending_icc_ints from .text between 'NETjet_U_card_msg' (at offset 0x3e2ac) and 'netjet_u_interrupt'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:initicc from .text between 'NETjet_U_card_msg' (at offset 0x3e2b3) and 'netjet_u_interrupt'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:init2bds0 from .text between 'hfcs_card_msg' (at offset 0x3f8b4) and 'ReadReg'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:clear_pending_jade_ints from .text between 'BKM_card_msg' (at offset 0x4b375) and 'ReadISAC'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:initjade from .text between 'BKM_card_msg' (at offset 0x4b383) and 'ReadISAC'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:inittiger from .text between 'enpci_card_msg' (at offset 0x50d82) and 'enpci_interrupt'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x260)
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x4ac)
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x4b0)
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x4b4)
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x53c)
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x700)
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x770)
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x77c)
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0xa08)
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0xa94)
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0xa98)
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0xa9c)
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0xb64)
WARNING: drivers/md/md-mod.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x88)
WARNING: drivers/net/3c501.o - Section mismatch: reference to .init.text:el1_probe from .text between 'init_module' (at offset 0xe9) and 'netdev_get_drvinfo'
WARNING: drivers/net/3c503.o - Section mismatch: reference to .init.data:netcard_portlist from .text between 'init_module' (at offset 0x276) and 'netdev_get_drvinfo'
WARNING: drivers/net/3c503.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x27d) and 'netdev_get_drvinfo'
WARNING: drivers/net/3c503.o - Section mismatch: reference to .init.data:netcard_portlist from .text between 'init_module' (at offset 0x2a9) and 'netdev_get_drvinfo'
WARNING: drivers/net/3c503.o - Section mismatch: reference to .init.data:netcard_portlist from .text between 'init_module' (at offset 0x2be) and 'netdev_get_drvinfo'
WARNING: drivers/net/3c503.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x2c9) and 'netdev_get_drvinfo'
WARNING: drivers/net/3c503.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x2f7) and 'netdev_get_drvinfo'
WARNING: drivers/net/3c505.o - Section mismatch: reference to .init.data:addr_list from .text between 'init_module' (at offset 0xe78) and 'elp_timeout'
WARNING: drivers/net/3c505.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0xe8d) and 'elp_timeout'
WARNING: drivers/net/3c505.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x114b) and 'elp_timeout'
WARNING: drivers/net/3c505.o - Section mismatch: reference to .init.data:addr_list from .text between 'init_module' (at offset 0x1168) and 'elp_timeout'
WARNING: drivers/net/3c507.o - Section mismatch: reference to .init.text:el16_probe from .text between 'init_module' (at offset 0x2f6) and 'netdev_get_drvinfo'
WARNING: drivers/net/82596.o - Section mismatch: reference to .init.text:i82596_probe from .text between 'init_module' (at offset 0x177) and 'i596_add_cmd'
WARNING: drivers/net/ac3200.o - Section mismatch: reference to .init.data:config2irqmap from .text between 'init_module' (at offset 0x422) and 'ac_close_card'
WARNING: drivers/net/appletalk/cops.o - Section mismatch: reference to .init.text:cops_probe from .text between 'init_module' (at offset 0xd6) and 'cops_rx'
WARNING: drivers/net/at1700.o - Section mismatch: reference to .init.text:at1700_probe from .text between 'init_module' (at offset 0x76) and 'net_get_stats'
WARNING: drivers/net/cs89x0.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x1698) and 'net_close'
WARNING: drivers/net/cs89x0.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x1991) and 'net_close'
WARNING: drivers/net/cs89x0.o - Section mismatch: reference to .init.data:version from .text between 'init_module' (at offset 0x1a60) and 'net_close'
WARNING: drivers/net/e2100.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x100) and 'e21_reset_8390'
WARNING: drivers/net/e2100.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x12e) and 'e21_reset_8390'
WARNING: drivers/net/eepro.o - Section mismatch: reference to .init.data:eepro_portlist from .text between 'init_module' (at offset 0x284) and 'eepro_ethtool_get_drvinfo'
WARNING: drivers/net/eepro.o - Section mismatch: reference to .init.data:eepro_portlist from .text between 'init_module' (at offset 0x29a) and 'eepro_ethtool_get_drvinfo'
WARNING: drivers/net/eepro.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x2b4) and 'eepro_ethtool_get_drvinfo'
WARNING: drivers/net/eepro.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x345) and 'eepro_ethtool_get_drvinfo'
WARNING: drivers/net/eexpress.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x762) and 'eexp_hw_lasttxstat'
WARNING: drivers/net/eexpress.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x79a) and 'eexp_hw_lasttxstat'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.data:cardname from .text between 'init_module' (at offset 0x7a1) and 'eth16i_multicast'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.data:cardname from .text between 'init_module' (at offset 0x7b6) and 'eth16i_multicast'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x7c5) and 'eth16i_multicast'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.data:cardname from .text between 'init_module' (at offset 0x84e) and 'eth16i_multicast'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.data:cardname from .text between 'init_module' (at offset 0x866) and 'eth16i_multicast'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x871) and 'eth16i_multicast'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x883) and 'eth16i_multicast'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.data:cardname from .text between 'init_module' (at offset 0x8cc) and 'eth16i_multicast'
WARNING: drivers/net/hp-plus.o - Section mismatch: reference to .init.data:hpplus_portlist from .text between 'init_module' (at offset 0xbb) and 'hpp_io_block_output'
WARNING: drivers/net/hp-plus.o - Section mismatch: reference to .init.data:hpplus_portlist from .text between 'init_module' (at offset 0xd0) and 'hpp_io_block_output'
WARNING: drivers/net/hp-plus.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0xdb) and 'hpp_io_block_output'
WARNING: drivers/net/hp-plus.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x10d) and 'hpp_io_block_output'
WARNING: drivers/net/hp.o - Section mismatch: reference to .init.data:hppclan_portlist from .text between 'init_module' (at offset 0xbb) and 'hp_close'
WARNING: drivers/net/hp.o - Section mismatch: reference to .init.data:hppclan_portlist from .text between 'init_module' (at offset 0xd0) and 'hp_close'
WARNING: drivers/net/hp.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0xdb) and 'hp_close'
WARNING: drivers/net/hp.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x10d) and 'hp_close'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0xf0) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x108) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x120) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x138) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x150) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x168) and '__param_str_ircc_dma'
WARNING: drivers/net/lance.o - Section mismatch: reference to .init.data:lance_portlist from .text between 'init_module' (at offset 0xda) and 'lance_purge_ring'
WARNING: drivers/net/lance.o - Section mismatch: reference to .init.data:lance_portlist from .text between 'init_module' (at offset 0x124) and 'lance_purge_ring'
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x169) and 'ne_block_input'
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x183) and 'ne_block_input'
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x18e) and 'ne_block_input'
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x1ed) and 'ne_block_input'
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x261) and 'ne_block_input'
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x275) and 'ne_block_input'
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x2b0) and 'ne_block_input'
WARNING: drivers/net/ni52.o - Section mismatch: reference to .init.text:ni52_probe from .text between 'init_module' (at offset 0xb18) and 'ni52_close'
WARNING: drivers/net/ni65.o - Section mismatch: reference to .init.text:ni65_probe from .text between 'init_module' (at offset 0x639) and 'ni65_stop_start'
WARNING: drivers/net/seeq8005.o - Section mismatch: reference to .init.text:seeq8005_probe from .text between 'init_module' (at offset 0x119) and 'seeq8005_open'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.data:ultra_device_ids from .text between 'init_module' (at offset 0xfa) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.data:ultra_device_ids from .text between 'init_module' (at offset 0x116) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x12f) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.data:ultra_device_ids from .text between 'init_module' (at offset 0x169) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.data:ultra_device_ids from .text between 'init_module' (at offset 0x175) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.data:ultra_device_ids from .text between 'init_module' (at offset 0x180) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x1cb) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.data:ultra_device_ids from .text between 'init_module' (at offset 0x253) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x267) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.data:ultra_device_ids from .text between 'init_module' (at offset 0x287) and 'ultra_close_card'
WARNING: drivers/net/smc9194.o - Section mismatch: reference to .init.text:smc_init from .text between 'init_module' (at offset 0x106) and 'smc_close'
WARNING: drivers/net/smc9194.o - Section mismatch: reference to .init.data:smc_devlist from .data between 'smcdev.17832' (at offset 0x0) and '__param_str_io'
WARNING: drivers/net/tokenring/ibmtr.o - Section mismatch: reference to .init.data:ibmtr_mem_base from .text between 'ibmtr_probe1' (at offset 0xa95) and 'ibmtr_probe_card'
WARNING: drivers/net/tokenring/ibmtr.o - Section mismatch: reference to .init.data:ibmtr_mem_base from .text between 'ibmtr_probe1' (at offset 0xad4) and 'ibmtr_probe_card'
WARNING: drivers/net/tokenring/ibmtr.o - Section mismatch: reference to .init.data:ibmtr_mem_base from .text between 'ibmtr_probe1' (at offset 0xbce) and 'ibmtr_probe_card'
WARNING: drivers/net/tokenring/smctr.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x3b48) and 'smctr_get_stats'
WARNING: drivers/net/tokenring/smctr.o - Section mismatch: reference to .init.text:smctr_probe from .text between 'init_module' (at offset 0x3b91) and 'smctr_get_stats'
WARNING: drivers/net/tulip/de2104x.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x28)
WARNING: drivers/net/wan/dlci.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x4)
WARNING: drivers/net/wan/sdla.o - Section mismatch: reference to .init.data:valid_port from .text between 'sdla_set_config' (at offset 0x208b) and 'sdla_poll'
WARNING: drivers/net/wan/sdla.o - Section mismatch: reference to .init.data:valid_port from .text between 'sdla_set_config' (at offset 0x2302) and 'sdla_poll'
WARNING: drivers/net/wd.o - Section mismatch: reference to .init.data:wd_portlist from .text between 'init_module' (at offset 0xf2) and 'wd_open'
WARNING: drivers/net/wd.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x124) and 'wd_open'
WARNING: drivers/net/wd.o - Section mismatch: reference to .init.data:wd_portlist from .text between 'init_module' (at offset 0x15d) and 'wd_open'
WARNING: drivers/net/wd.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x1c1) and 'wd_open'
WARNING: drivers/pci/hotplug/ibmphp.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x8)
WARNING: drivers/pci/hotplug/ibmphp.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0xc)
WARNING: drivers/scsi/qla2xxx/qla2xxx.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x0)
WARNING: drivers/scsi/qla2xxx/qla2xxx.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x4)
WARNING: drivers/scsi/wd7000.o - Section mismatch: reference to .init.text: from .text between 'wd7000_detect' (at offset 0x846) and 'wd7000_intr'
WARNING: drivers/scsi/wd7000.o - Section mismatch: reference to .init.text: from .text between 'wd7000_detect' (at offset 0xcf1) and 'wd7000_intr'
WARNING: drivers/scsi/wd7000.o - Section mismatch: reference to .init.text: from .text between 'wd7000_detect' (at offset 0xe9c) and 'wd7000_intr'
WARNING: drivers/scsi/wd7000.o - Section mismatch: reference to .init.text: from .text between 'wd7000_detect' (at offset 0xed1) and 'wd7000_intr'
WARNING: drivers/scsi/wd7000.o - Section mismatch: reference to .init.text: from .text between 'wd7000_detect' (at offset 0xeec) and 'wd7000_intr'
WARNING: drivers/scsi/wd7000.o - Section mismatch: reference to .init.text: from .text between 'wd7000_detect' (at offset 0xf12) and 'wd7000_intr'
WARNING: drivers/scsi/wd7000.o - Section mismatch: reference to .init.text: from .text between 'wd7000_detect' (at offset 0xf79) and 'wd7000_intr'
WARNING: drivers/scsi/wd7000.o - Section mismatch: reference to .init.text: from .text between 'wd7000_detect' (at offset 0xfa5) and 'wd7000_intr'
WARNING: drivers/usb/storage/usb-storage.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x40)
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.data: from .text between 'atyfb_pci_probe' (at offset 0x2dc5) and 'aty_enable_irq'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.text:aty_init_cursor from .text between 'atyfb_pci_probe' (at offset 0x2e22) and 'aty_enable_irq'
WARNING: drivers/video/macmodes.o - Section mismatch: reference to .init.text:mac_find_mode from __ksymtab after '__ksymtab_mac_find_mode' (at offset 0x18)
WARNING: fs/jffs2/jffs2.o - Section mismatch: reference to .init.text:jffs2_zlib_init from .text between 'jffs2_compressors_init' (at offset 0x24) and 'jffs2_free_comprbuf'
WARNING: fs/reiserfs/reiserfs.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x3d4)
WARNING: fs/reiserfs/reiserfs.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x3d8)
WARNING: net/ax25/ax25.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x0)
WARNING: net/ax25/ax25.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x78)
WARNING: net/ax25/ax25.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0xb4)
WARNING: net/ax25/ax25.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0xb8)
WARNING: net/bluetooth/rfcomm/rfcomm.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0xc)
WARNING: net/bluetooth/rfcomm/rfcomm.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x10)
WARNING: net/bridge/bridge.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x0)
WARNING: net/decnet/decnet.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x1dc)
WARNING: net/ipv4/ip_gre.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x0)
WARNING: net/ipv4/ipip.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x0)
WARNING: net/ipv4/netfilter/ip_conntrack.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x8)
WARNING: net/ipv4/netfilter/ipt_ROUTE.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x30)
WARNING: net/ipv4/netfilter/iptable_tproxy.o - Section mismatch: reference to .init.data:initial_table from .text between 'init_or_cleanup' (at offset 0xc) and 'ip_tproxy_fn'
WARNING: net/ipv6/ipv6.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x23c)
WARNING: net/ipv6/ipv6.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x240)
WARNING: net/ipv6/ipv6.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x280)
WARNING: net/ipx/ipx.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x10)
WARNING: net/netrom/netrom.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x50)
WARNING: net/netrom/netrom.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x54)
WARNING: net/netrom/netrom.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x58)
WARNING: net/netrom/netrom.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x5c)
WARNING: net/netrom/netrom.o - Section mismatch: reference to .exit.text: from .smp_locks after '' (at offset 0x60)
WARNING: sound/isa/sb/snd-sbawe.o - Section mismatch: reference to .init.text:snd_emu8000_new from .text between 'snd_sb16_probe' (at offset 0x47d) and 'snd_sb16_nonpnp_probe1'
WARNING: sound/isa/sb/snd-sbawe.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x0)
WARNING: sound/isa/sb/snd-sbawe.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x4)
WARNING: sound/isa/snd-opl3sa2.o - Section mismatch: reference to .init.text: from .text between 'snd_opl3sa2_pnp_cdetect' (at offset 0x112b) and 'snd_opl3sa2_pnp_remove'
WARNING: sound/isa/snd-opl3sa2.o - Section mismatch: reference to .init.text: from .text after 'snd_opl3sa2_pnp_detect' (at offset 0x1273)
WARNING: sound/isa/wavefront/snd-wavefront.o - Section mismatch: reference to .init.text:snd_wavefront_midi_start from .text between 'snd_wavefront_new_midi' (at offset 0x15b) and 'snd_wavefront_probe'
WARNING: sound/isa/wavefront/snd-wavefront.o - Section mismatch: reference to .init.text:snd_wavefront_detect from .text between 'snd_wavefront_probe' (at offset 0x3ac) and 'snd_wavefront_ics2115_interrupt'
WARNING: sound/isa/wavefront/snd-wavefront.o - Section mismatch: reference to .init.text:snd_wavefront_start from .text between 'snd_wavefront_probe' (at offset 0x3bc) and 'snd_wavefront_ics2115_interrupt'
WARNING: sound/isa/wavefront/snd-wavefront.o - Section mismatch: reference to .init.text:snd_wavefront_fx_start from .text between 'snd_wavefront_probe' (at offset 0x6d1) and 'snd_wavefront_ics2115_interrupt'

Jan Engelhardt
-- 
