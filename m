Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWEUBAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWEUBAm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 21:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWEUBAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 21:00:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:24235 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932276AbWEUBAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 21:00:41 -0400
X-Authenticated: #31060655
Message-ID: <446FBB52.1080402@gmx.net>
Date: Sun, 21 May 2006 02:58:58 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060316 SUSE/1.0-27 SeaMonkey/1.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc4-mm2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

with 2.6.17-rc4-mm2, running "make" always relinks the kernel
even if a previous run was completed successfully.

kerncomp@p35:/sources/linux-2.6.17-rc4-mm2> make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CC      kernel/nsproxy.o
  CC      kernel/utsname.o
  LD      kernel/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  AS      arch/i386/boot/setup.o
  LD      arch/i386/boot/setup
  OBJCOPY arch/i386/boot/compressed/vmlinux.bin
  GZIP    arch/i386/boot/compressed/vmlinux.bin.gz
  LD      arch/i386/boot/compressed/piggy.o
  LD      arch/i386/boot/compressed/vmlinux
  OBJCOPY arch/i386/boot/vmlinux.bin
  BUILD   arch/i386/boot/bzImage
Root device is (3, 5)
Boot sector 512 bytes.
Setup is 7327 bytes.
System is 1398 kB
Kernel: arch/i386/boot/bzImage is ready  (#3)
  Building modules, stage 2.
  MODPOST
WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data: from .text between 'acpi_processor_power_init' (at offset 0x1667) and 'acpi_safe_halt'
WARNING: drivers/atm/he.o - Section mismatch: reference to .init.text: from .text after 'he_init_one' (at offset 0x2195)
WARNING: drivers/atm/idt77105.o - Section mismatch: reference to .init.text:idt77105_init from __ksymtab after '__ksymtab_idt77105_init' (at offset 0x0)
WARNING: drivers/atm/iphase.o - Section mismatch: reference to .init.text: from .text between 'ia_init_one' (at offset 0x1772) and 'ia_int'
WARNING: drivers/cdrom/cm206.o - Section mismatch: reference to .init.text:cm206_init from .text between 'init_module' (at offset 0xfe7) and 'cm206_timeout'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x120) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x14c) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x178) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x1a4) and '__param_str_force'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x1d0) and '__param_str_force'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_teles0 from .text between 'checkcard' (at offset 0x632) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_s0box from .text between 'checkcard' (at offset 0x64e) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_telespci from .text between 'checkcard' (at offset 0x65c) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_avm_a1 from .text between 'checkcard' (at offset 0x66a) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_avm_pcipnp from .text between 'checkcard' (at offset 0x686) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_ix1micro from .text between 'checkcard' (at offset 0x6a2) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_diva from .text between 'checkcard' (at offset 0x6b0) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_asuscom from .text between 'checkcard' (at offset 0x6be) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_TeleInt from .text between 'checkcard' (at offset 0x6cc) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_sportster from .text between 'checkcard' (at offset 0x6e8) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_mic from .text between 'checkcard' (at offset 0x6f6) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_netjet_s from .text between 'checkcard' (at offset 0x704) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_hfcs from .text between 'checkcard' (at offset 0x712) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_hfcpci from .text between 'checkcard' (at offset 0x720) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_niccy from .text between 'checkcard' (at offset 0x73c) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_isurf from .text between 'checkcard' (at offset 0x74a) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_saphir from .text between 'checkcard' (at offset 0x755) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_bkm_a4t from .text between 'checkcard' (at offset 0x760) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_sct_quadro from .text between 'checkcard' (at offset 0x76b) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_gazel from .text between 'checkcard' (at offset 0x776) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_w6692 from .text between 'checkcard' (at offset 0x781) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_netjet_u from .text between 'checkcard' (at offset 0x78c) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_enternow_pci from .text between 'checkcard' (at offset 0x797) and 'hisax_init_pcmcia'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:init_ipacx from .text between 'Diva_card_msg' (at offset 0x24b62) and 'ReadISAC'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:inithfc from .text between 'TeleInt_card_msg' (at offset 0x27aa7) and 'WriteHFC'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:inittiger from .text between 'NETjet_S_card_msg' (at offset 0x30ce3) and 'netjet_s_interrupt'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:inittiger from .text between 'NETjet_U_card_msg' (at offset 0x32756) and 'netjet_u_interrupt'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:clear_pending_icc_ints from .text between 'NETjet_U_card_msg' (at offset 0x32764) and
'netjet_u_interrupt'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:initicc from .text between 'NETjet_U_card_msg' (at offset 0x3276b) and 'netjet_u_interrupt'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:init2bds0 from .text between 'hfcs_card_msg' (at offset 0x33995) and 'ReadReg'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:clear_pending_jade_ints from .text between 'BKM_card_msg' (at offset 0x3d164) and 'ReadISAC'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:initjade from .text between 'BKM_card_msg' (at offset 0x3d172) and 'ReadISAC'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:inittiger from .text between 'enpci_card_msg' (at offset 0x41a05) and 'enpci_interrupt'
WARNING: drivers/net/3c501.o - Section mismatch: reference to .init.text:el1_probe from .text between 'init_module' (at offset 0xa2) and 'netdev_get_drvinfo'
WARNING: drivers/net/3c503.o - Section mismatch: reference to .init.data:netcard_portlist from .text between 'init_module' (at offset 0x1ff) and 'netdev_get_drvinfo'
WARNING: drivers/net/3c503.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x206) and 'netdev_get_drvinfo'
WARNING: drivers/net/3c503.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x238) and 'netdev_get_drvinfo'
WARNING: drivers/net/3c503.o - Section mismatch: reference to .init.data:netcard_portlist from .text between 'init_module' (at offset 0x247) and 'netdev_get_drvinfo'
WARNING: drivers/net/3c503.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x254) and 'netdev_get_drvinfo'
WARNING: drivers/net/3c505.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0xcf5) and 'elp_timeout'
WARNING: drivers/net/3c505.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0xd02) and 'elp_timeout'
WARNING: drivers/net/3c505.o - Section mismatch: reference to .init.data:addr_list from .text between 'init_module' (at offset 0xd0d) and 'elp_timeout'
WARNING: drivers/net/3c505.o - Section mismatch: reference to .init.data:addr_list from .text between 'init_module' (at offset 0xd2d) and 'elp_timeout'
WARNING: drivers/net/3c507.o - Section mismatch: reference to .init.text:el16_probe from .text between 'init_module' (at offset 0x2a7) and 'netdev_get_drvinfo'
WARNING: drivers/net/82596.o - Section mismatch: reference to .init.text:i82596_probe from .text between 'init_module' (at offset 0x13d) and 'i596_add_cmd'
WARNING: drivers/net/ac3200.o - Section mismatch: reference to .init.data:config2irqmap from .text between 'init_module' (at offset 0x1f3) and 'ac_close_card'
WARNING: drivers/net/appletalk/cops.o - Section mismatch: reference to .init.text:cops_probe from .text between 'init_module' (at offset 0xe4) and 'cops_rx'
WARNING: drivers/net/at1700.o - Section mismatch: reference to .init.text:at1700_probe from .text between 'init_module' (at offset 0x5a) and 'net_get_stats'
WARNING: drivers/net/cs89x0.o - Section mismatch: reference to .init.data:version from .text between 'init_module' (at offset 0xea9) and 'set_mac_address'
WARNING: drivers/net/cs89x0.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x10eb) and 'set_mac_address'
WARNING: drivers/net/cs89x0.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x14a9) and 'set_mac_address'
WARNING: drivers/net/e2100.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0xae) and 'e21_reset_8390'
WARNING: drivers/net/e2100.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0xce) and 'e21_reset_8390'
WARNING: drivers/net/eepro.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x25b) and 'eepro_ethtool_get_drvinfo'
WARNING: drivers/net/eepro.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x27b) and 'eepro_ethtool_get_drvinfo'
WARNING: drivers/net/eepro.o - Section mismatch: reference to .init.data:eepro_portlist from .text between 'init_module' (at offset 0x287) and 'eepro_ethtool_get_drvinfo'
WARNING: drivers/net/eexpress.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x65b) and 'eexp_hw_lasttxstat'
WARNING: drivers/net/eexpress.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x6f5) and 'eexp_hw_lasttxstat'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.data:cardname from .text between 'init_module' (at offset 0x6e7) and 'eth16i_multicast'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x704) and 'eth16i_multicast'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x717) and 'eth16i_multicast'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.data:cardname from .text between 'init_module' (at offset 0x723) and 'eth16i_multicast'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x732) and 'eth16i_multicast'
WARNING: drivers/net/eth16i.o - Section mismatch: reference to .init.data:cardname from .text between 'init_module' (at offset 0x73e) and 'eth16i_multicast'
WARNING: drivers/net/hamradio/dmascc.o - Section mismatch: reference to .init.data:io from .text between 'dev_setup' (at offset 0xe62) and 'scc_send_packet'
WARNING: drivers/net/hamradio/dmascc.o - Section mismatch: reference to .init.data:io from .text between 'dev_setup' (at offset 0xe95) and 'scc_send_packet'
WARNING: drivers/net/hp-plus.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x97) and 'hpp_io_block_output'
WARNING: drivers/net/hp-plus.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0xac) and 'hpp_io_block_output'
WARNING: drivers/net/hp-plus.o - Section mismatch: reference to .init.data:hpplus_portlist from .text between 'init_module' (at offset 0xbb) and 'hpp_io_block_output'
WARNING: drivers/net/hp.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x96) and 'hp_close'
WARNING: drivers/net/hp.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0xab) and 'hp_close'
WARNING: drivers/net/hp.o - Section mismatch: reference to .init.data:hppclan_portlist from .text between 'init_module' (at offset 0xba) and 'hp_close'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0xf0) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x108) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x120) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x138) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x150) and '__param_str_ircc_dma'
WARNING: drivers/net/irda/smsc-ircc2.o - Section mismatch: reference to .init.text: from .data between 'subsystem_configurations' (at offset 0x168) and '__param_str_ircc_dma'
WARNING: drivers/net/lance.o - Section mismatch: reference to .init.data:lance_portlist from .text between 'init_module' (at offset 0x992) and 'lance_purge_ring'
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x109) and 'ne_block_input'
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x1a6) and 'ne_block_input'
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x1b9) and 'ne_block_input'
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x1d0) and 'ne_block_input'
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x1d9) and 'ne_block_input'
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x1fe) and 'ne_block_input'
WARNING: drivers/net/ni5010.o - Section mismatch: reference to .init.text:ni5010_probe from .text between 'init_module' (at offset 0x76) and 'ni5010_timeout'
WARNING: drivers/net/ni52.o - Section mismatch: reference to .init.text:ni52_probe from .text between 'init_module' (at offset 0xa05) and 'ni52_close'
WARNING: drivers/net/ni65.o - Section mismatch: reference to .init.text:ni65_probe from .text between 'init_module' (at offset 0x588) and 'ni65_stop_start'
WARNING: drivers/net/seeq8005.o - Section mismatch: reference to .init.text:seeq8005_probe from .text between 'init_module' (at offset 0xeb) and 'seeq8005_open'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0xbf) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.data:ultra_device_ids from .text between 'init_module' (at offset 0x166) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x179) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.data:ultra_device_ids from .text between 'init_module' (at offset 0x18c) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.data:ultra_device_ids from .text between 'init_module' (at offset 0x195) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.data:ultra_device_ids from .text between 'init_module' (at offset 0x1b3) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x1e6) and 'ultra_close_card'
WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.data:ultra_device_ids from .text between 'init_module' (at offset 0x1f2) and 'ultra_close_card'
WARNING: drivers/net/smc9194.o - Section mismatch: reference to .init.text:smc_init from .text between 'init_module' (at offset 0xda) and 'smc_close'
WARNING: drivers/net/smc9194.o - Section mismatch: reference to .init.data:smc_devlist from .data between 'smcdev.17359' (at offset 0x0) and '__param_str_io'
WARNING: drivers/net/tokenring/ibmtr.o - Section mismatch: reference to .init.data:ibmtr_mem_base from .text between 'ibmtr_probe1' (at offset 0x68f) and 'ibmtr_probe_card'
WARNING: drivers/net/tokenring/ibmtr.o - Section mismatch: reference to .init.data:ibmtr_mem_base from .text between 'ibmtr_probe1' (at offset 0x6e7) and 'ibmtr_probe_card'
WARNING: drivers/net/tokenring/ibmtr.o - Section mismatch: reference to .init.data:ibmtr_mem_base from .text between 'ibmtr_probe1' (at offset 0x790) and 'ibmtr_probe_card'
WARNING: drivers/net/tokenring/smctr.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x33c7) and 'smctr_get_stats'
WARNING: drivers/net/tokenring/smctr.o - Section mismatch: reference to .init.text:smctr_probe from .text between 'init_module' (at offset 0x3409) and 'smctr_get_stats'
WARNING: drivers/net/wan/sdla.o - Section mismatch: reference to .init.data:valid_port from .text between 'sdla_set_config' (at offset 0x1be4) and 'sdla_poll'
WARNING: drivers/net/wan/sdla.o - Section mismatch: reference to .init.data:valid_port from .text between 'sdla_set_config' (at offset 0x1efb) and 'sdla_poll'
WARNING: drivers/net/wd.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0xeb) and 'wd_open'
WARNING: drivers/net/wd.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x13b) and 'wd_open'
WARNING: drivers/net/wd.o - Section mismatch: reference to .init.data:wd_portlist from .text between 'init_module' (at offset 0x174) and 'wd_open'
WARNING: drivers/net/wireless/wavelan.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0xb3a) and 'wv_82586_config'
WARNING: drivers/scsi/wd7000.o - Section mismatch: reference to .init.text: from .text between 'wd7000_detect' (at offset 0x75d) and 'wd7000_intr'
WARNING: drivers/scsi/wd7000.o - Section mismatch: reference to .init.text: from .text between 'wd7000_detect' (at offset 0x7b8) and 'wd7000_intr'
WARNING: drivers/scsi/wd7000.o - Section mismatch: reference to .init.text: from .text between 'wd7000_detect' (at offset 0x86a) and 'wd7000_intr'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.data: from .text between 'atyfb_pci_probe' (at offset 0x2a9b) and 'aty_enable_irq'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.text:aty_init_cursor from .text between 'atyfb_pci_probe' (at offset 0x2b3c) and 'aty_enable_irq'
WARNING: drivers/video/macmodes.o - Section mismatch: reference to .init.text:mac_find_mode from __ksymtab after '__ksymtab_mac_find_mode' (at offset 0x18)
WARNING: sound/isa/sb/snd-sbawe.o - Section mismatch: reference to .init.text:snd_emu8000_new from .text between 'snd_sb16_probe' (at offset 0x4e9) and 'snd_sb16_nonpnp_probe1'
WARNING: sound/isa/snd-opl3sa2.o - Section mismatch: reference to .init.text: from .text between 'snd_opl3sa2_pnp_cdetect' (at offset 0xc9b) and 'snd_opl3sa2_pnp_remove'
WARNING: sound/isa/snd-opl3sa2.o - Section mismatch: reference to .init.text: from .text between 'snd_opl3sa2_pnp_detect' (at offset 0xd84) and 'snd_opl3sa2_put_single'
WARNING: sound/isa/wavefront/snd-wavefront.o - Section mismatch: reference to .init.text:snd_wavefront_midi_start from .text between 'snd_wavefront_new_midi' (at offset
0xe4) and 'snd_wavefront_probe'
WARNING: sound/isa/wavefront/snd-wavefront.o - Section mismatch: reference to .init.text:snd_wavefront_detect from .text between 'snd_wavefront_probe' (at offset 0x3ae) and
'snd_wavefront_ics2115_interrupt'
WARNING: sound/isa/wavefront/snd-wavefront.o - Section mismatch: reference to .init.text:snd_wavefront_start from .text between 'snd_wavefront_probe' (at offset 0x3bb) and
'snd_wavefront_ics2115_interrupt'
WARNING: sound/isa/wavefront/snd-wavefront.o - Section mismatch: reference to .init.text:snd_wavefront_fx_start from .text between 'snd_wavefront_probe' (at offset 0x56e)
and 'snd_wavefront_ics2115_interrupt'
WARNING: sound/oss/cs4232.o - Section mismatch: reference to .init.text: from .text between 'cs4232_pnp_probe' (at offset 0x60) and 'unload_cs4232'
WARNING: "generic_file_read" [fs/reiser4/reiser4.ko] undefined!

kerncomp@p35:/sources/linux-2.6.17-rc4-mm2> gcc --version
gcc (GCC) 4.1.0 (SUSE Linux)

kerncomp@p35:/sources/linux-2.6.17-rc4-mm2> ld --version
GNU ld version 2.16.91.0.5 20051219 (SUSE Linux)

kerncomp@p35:/sources/linux-2.6.17-rc4-mm2> uname -pio
i686 i386 GNU/Linux

.config is very similar to allmodconfig.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
