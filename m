Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267714AbUBTDmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 22:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267715AbUBTDmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 22:42:18 -0500
Received: from joel.ist.utl.pt ([193.136.198.171]:3008 "EHLO joel.ist.utl.pt")
	by vger.kernel.org with ESMTP id S267714AbUBTDmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 22:42:05 -0500
Date: Thu, 19 Feb 2004 18:31:49 +0000 (WET)
From: Rui Saraiva <rmps@joel.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: reference_init.pl for Linux 2.6
Message-ID: <Pine.LNX.4.58.0402191829330.861@joel.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This are some comments about the (first) output of reference_init.pl
script. Dave Jones already fixed the first ones and there is a second
version that I'll try to check later...


Error: ./arch/i386/kernel/cpu/cpufreq/longhaul.o .text refers to 00000358 R_386_PC32 .init.text
Error: ./arch/i386/kernel/cpu/cpufreq/longhaul.o .text refers to 000003ac R_386_PC32 .init.text
 static int longhaul_cpu_init() calls static void __init longhaul_setup_voltagescaling()
 static int longhaul_cpu_init() calls static int __init longhaul_get_ranges()

Error: ./arch/i386/kernel/cpu/cpufreq/longrun.o .text refers to 0000019b R_386_PC32 .init.text
 static int longrun_cpu_init() calls static unsigned int __init longrun_determine_freqs()

Error: ./arch/i386/kernel/cpu/mtrr/generic.o .text refers to 00000026 R_386_PC32 .init.text
Error: ./arch/i386/kernel/cpu/mtrr/generic.o .text refers to 0000003a R_386_PC32 .init.text
Error: ./arch/i386/kernel/cpu/mtrr/generic.o .text refers to 00000177 R_386_PC32 .init.text
Error: ./arch/i386/kernel/cpu/mtrr/generic.o .text refers to 0000019a R_386_PC32 .init.text
 void get_mtrr_state(void) calls static void __init get_mtrr_var_range()
 void get_mtrr_state(void) calls static void __init get_fixed_ranges()
 static unsigned long set_mtrr_state() calls static int __init set_mtrr_var_ranges()
 static unsigned long set_mtrr_state() calls static int __init set_fixed_ranges()

Error: ./arch/i386/kernel/cpu/nexgen.o .text refers to 0000000a R_386_PC32 .init.text
 static void nexgen_identify() calls static int __init deep_magic_nexgen_probe()

Error: ./arch/i386/kernel/io_apic.o .text refers to 0000178e R_386_PC32 .init.text
 int io_apic_set_pci_routing() calls static void __init add_pin_to_irq()

Error: ./drivers/atm/horizon.o .exit.text refers to 00000059 R_386_PC32 .init.text
 static void __exit hrz_module_exit() calls static void __init hrz_reset()

Error: ./drivers/char/ipmi/ipmi_msghandler.o .text refers to 000006a9 R_386_PC32 .init.text
Error: ./drivers/char/ipmi/ipmi_msghandler.o .text refers to 00002071 R_386_PC32 .init.text
 int ipmi_create_user() calls static __init int ipmi_init_msghandler()
 int ipmi_register_smi() calls static __init int ipmi_init_msghandler()

Error: ./drivers/char/sonypi.o .text refers to 00001e0f R_386_PC32 .init.text
Error: ./drivers/char/sonypi.o .text refers to 00001e64 R_386_PC32 .init.text
 static int sonypi_pm_callback() calls static void __devinit sonypi_type1_srs()
 static int sonypi_pm_callback() calls static void __devinit sonypi_type2_srs()

Error: ./drivers/i2c/busses/i2c-prosavage.o .init.text refers to 0000007e R_386_PC32 .exit.text
Error: ./drivers/i2c/busses/i2c-prosavage.o .init.text refers to 00000165 R_386_PC32 .exit.text
 static int __devinit prosavage_probe() calls static void __devexit prosavage_remove() [twice]

Error: ./drivers/ide/pci/piix.o .text refers to 00000d44 R_386_PC32 .init.text
 static int piix_ide_init() calls static void __init piix_check_450nx()

Error: ./drivers/message/fusion/mptbase.o .text refers to 000004d8 R_386_PC32 .init.text
 int mpt_register() calls static int __init fusion_init(void)

Error: ./drivers/message/fusion/mptscsih.o .text refers to 00000f23 R_386_PC32 .exit.text
Error: ./drivers/message/fusion/mptscsih.o .init.text refers to 0000006b R_386_PC32 .exit.text
 static void mptscsih_exit() calls static void __devexit mptscsih_remove()
 static int  __devinit mptscsih_probe() calls static void __devexit mptscsih_remove()

Error: ./drivers/net/3c59x.o .text refers to 00000139 R_386_PC32 .init.text
 static int vortex_eisa_probe() calls static int __devinit vortex_probe1()

Error: ./drivers/net/eepro.o .text refers to 0000015e R_386_PC32 .init.text
 static void eepro_print_info() calls static void __init printEEPROMInfo()

Error: ./drivers/net/tokenring/ibmtr.o .text refers to 000000b7 R_386_PC32 .init.text
Error: ./drivers/net/tokenring/ibmtr.o .text refers to 000000d3 R_386_PC32 .init.text
Error: ./drivers/net/tokenring/ibmtr.o .text refers to 000000f1 R_386_PC32 .init.text
 static int ibmtr_probe() calls static void __devinit find_turbo_adapters()
 static int ibmtr_probe() uses static int ibmtr_portlist[] __devinitdata
 static int ibmtr_probe() calls static int __devinit ibmtr_probe1()

Error: ./drivers/net/tokenring/smctr.o .text refers to 0000061a R_386_PC32 .init.text
 static int smctr_chk_mca() calls static int __init smctr_get_boardid()

Error: ./drivers/parport/parport_pc.o .text refers to 00001922 R_386_PC32 .init.text
Error: ./drivers/parport/parport_pc.o .text refers to 00001931 R_386_PC32 .init.text
Error: ./drivers/parport/parport_pc.o .text refers to 00001950 R_386_PC32 .init.text
Error: ./drivers/parport/parport_pc.o .text refers to 00001a4f R_386_PC32 .init.text
Error: ./drivers/parport/parport_pc.o .text refers to 00001db6 R_386_PC32 .init.text
Error: ./drivers/parport/parport_pc.o .text refers to 00001dc9 R_386_PC32 .init.text
Error: ./drivers/parport/parport_pc.o .text refers to 00001dec R_386_PC32 .init.text
Error: ./drivers/parport/parport_pc.o .text refers to 00001e70 R_386_PC32 .init.text
Error: ./drivers/parport/parport_pc.o .text refers to 00001e7b R_386_PC32 .init.text
Error: ./drivers/parport/parport_pc.o .text refers to 00001eac R_386_PC32 .init.text
 struct parport *parport_pc_probe_port() calls static int __devinit parport_EPP_supported()
 struct parport *parport_pc_probe_port() calls static int __devinit parport_ECPEPP_supported()
 struct parport *parport_pc_probe_port() calls static int __devinit parport_SPP_supported()
 struct parport *parport_pc_probe_port() calls static int __devinit parport_ECPPS2_supported()
 struct parport *parport_pc_probe_port() calls static int __devinit parport_PS2_supported()
 struct parport *parport_pc_probe_port() calls static int __devinit parport_irq_probe()
 struct parport *parport_pc_probe_port() calls static int __devinit parport_dma_probe()
 struct parport *parport_pc_probe_port() calls static int __devinit parport_ECP_supported()
 struct parport *parport_pc_probe_port() calls static int __devinit parport_ECR_present()
 int init_module() calls int __init parport_pc_init()

Error: ./drivers/pnp/system.o .text refers to 00000007 R_386_PC32 .init.text
 static int system_pnp_probe() calls static void __init reserve_resources_of_dev()

Error: ./drivers/scsi/BusLogic.o .text refers to 000005fd R_386_PC32 .init.text
Error: ./drivers/scsi/BusLogic.o .exit.text refers to 0000002d R_386_PC32 .init.text
 static boolean BusLogic_Failure() calls static void __init BusLogic_AnnounceDriver()
 static int __exit BusLogic_ReleaseHostAdapter() calls static void __init BusLogic_UnregisterHostAdapter()

Error: ./drivers/scsi/scsi_devinfo.o .text refers to 000004fa R_386_32 .init.text
 int scsi_init_devinfo() uses static __init char scsi_dev_flags[]

Error: ./drivers/serial/8250_pnp.o .text refers to 00000021 R_386_PC32 .init.text
 static int serial_pnp_probe() calls static int __devinit serial_pnp_guess_board()

Error: ./drivers/usb/gadget/net2280.o .text refers to 00004508 R_386_PC32 .exit.text
 static int net2280_probe() calls static void __exit net2280_remove()

Error: ./drivers/video/aty/radeon_base.o .text refers to 00004d74 R_386_PC32 .exit.text
Error: ./drivers/video/aty/radeon_base.o .text refers to 00004dcd R_386_PC32 .init.text
Error: ./drivers/video/aty/radeon_base.o .text refers to 00004de2 R_386_PC32 .init.text
Error: ./drivers/video/aty/radeon_base.o .text refers to 00004dee R_386_PC32 .init.text
Error: ./drivers/video/aty/radeon_base.o .text refers to 00004eb8 R_386_PC32 .exit.text
Error: ./drivers/video/aty/radeon_base.o .text refers to 00004f53 R_386_PC32 .init.text
Error: ./drivers/video/aty/radeon_base.o .init.text refers to 00000151 R_386_PC32 .exit.text
 static int radeonfb_pci_register() calls static void __devexit radeon_unmap_ROM() [twice]
 static int radeonfb_pci_register() calls static int __devinit radeon_map_ROM()
 static int radeonfb_pci_register() calls static int __devinit radeon_find_mem_vbios()
 static int radeonfb_pci_register() calls static void __devinit radeon_get_pllinfo()
 static int radeonfb_pci_register() calls static int __devinit radeon_set_fbinfo()
 static int __devinit radeon_map_ROM() calls static void __devexit radeon_unmap_ROM()

Error: ./drivers/video/cyber2000fb.o .exit.text refers to 0000002b R_386_PC32 .init.text
 static void __devexit cyberpro_pci_remove() calls static void __devinit cyberpro_free_fb_info()

Error: ./drivers/video/fbmem.o .text refers to 0000033e R_386_PC32 .init.text
Error: ./drivers/video/fbmem.o .text refers to 0000047f R_386_PC32 .init.text
Error: ./drivers/video/fbmem.o .text refers to 000004b2 R_386_PC32 .init.text
Error: ./drivers/video/fbmem.o .text refers to 000004be R_386_PC32 .init.text
 int fb_show_logo() calls static void __init fb_set_logocmap()
 int fb_show_logo() calls static void __init fb_set_logo_truepalette()
 int fb_show_logo() calls static void __init fb_set_logo_directpalette()
 int fb_show_logo() calls static void __init fb_set_logo()

Error: ./drivers/video/neofb.o .exit.text refers to 0000001f R_386_PC32 .init.text
Error: ./drivers/video/neofb.o .exit.text refers to 00000025 R_386_PC32 .init.text
Error: ./drivers/video/neofb.o .exit.text refers to 0000002b R_386_PC32 .init.text
 static void __devexit neofb_remove() calls static void __devinit neo_unmap_mmio()
 static void __devexit neofb_remove() calls static void __devinit neo_unmap_video()
 static void __devexit neofb_remove() calls static void __devinit neo_free_fb_info()

Error: ./drivers/video/radeonfb.o .text refers to 0000399a R_386_PC32 .init.text
 static int radeonfb_pci_register() calls static int __devinit radeon_set_fbinfo()

Error: ./init/main.o .text refers to 00000107 R_386_PC32 .init.text
Error: ./init/main.o .text refers to 0000010c R_386_PC32 .init.text
 static int init() calls static void __init smp_init()
 static int init() calls static void __init do_basic_setup()

Error: ./kernel/power/swsusp.o .text refers to 00001434 R_386_PC32 .init.text
 static int read_suspend_image() calls static int __init __read_suspend_image()

Error: ./sound/oss/awe_wave.o .text refers to 0000655b R_386_PC32 .init.text
Error: ./sound/oss/awe_wave.o .text refers to 00006744 R_386_PC32 .init.text
Error: ./sound/oss/awe_wave.o .text refers to 000067cc R_386_PC32 .exit.text
 static int awe_attach_device() calls static void __init attach_mixer()
 static int awe_attach_device() calls static void __init attach_midiemu()
 static void awe_initialize() calls static void __init awe_check_dram()
 static void awe_dettach_device() calls static void __exit unload_mixer()
 static void awe_dettach_device() calls static void __exit unload_midiemu()

Error: ./sound/oss/cs4281/cs4281m.o .text refers to 00001bb5 R_386_PC32 .init.text
 int cs4281_resume() calls static __devinit int cs4281_hw_init()

Error: ./sound/oss/cs46xx.o .text refers to 00008cdd R_386_PC32 .init.text
 static int cs_hardware_init() calls static int __init cs_ac97_init()

Error: ./sound/oss/opl3sa2.o .text refers to 000007c2 R_386_PC32 .init.text
Error: ./sound/oss/opl3sa2.o .text refers to 000007ce R_386_PC32 .init.text
Error: ./sound/oss/opl3sa2.o .text refers to 000007da R_386_PC32 .init.text
 static int opl3sa2_pnp_probe() calls static void __init opl3sa2_clear_slots() [3 times]


I didn't check /drivers/scsi/advansys.o and couldn't find anything on this ones:
/drivers/block/cciss.o
/init/do_mounts_rd.o
/init/initramfs.o
/sound/oss/cs4281/built-in.o
/sound/oss/cs4281/cs4281.o
/sound/pci/rme9652/hdsp.o
/sound/pci/rme9652/snd-hdsp.o


Regards,
  Rui Saraiva
