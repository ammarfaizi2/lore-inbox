Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbUKTCWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbUKTCWG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbUKTCV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:21:59 -0500
Received: from baikonur.stro.at ([213.239.196.228]:52956 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S262853AbUKTCSc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:18:32 -0500
Date: Sat, 20 Nov 2004 03:18:29 +0100
From: maximilian attems <janitor@sternwelten.at>
To: kj <kernel-janitors@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [announce] 2.6.10-rc2-kjt1 patchset
Message-ID: <20041120021829.GK2202@stro.at>
Mail-Followup-To: kj <kernel-janitors@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20041024151241.GA1920@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024151241.GA1920@stro.at>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

new janitorial stuff mostly under drivers.
again lots of patches got merged, thanks gregkh, akpm and linus.

patches resulted in nice discussions about msleep() and friends on
the #kerneljanitor channel. :)
until better solutions are merged the msleep_interruptible()
patches are frozen. others will be sent upstream.

please test out (based on 2.6.10-rc2-bk4):
http://debian.stro.at/kjt/2.6.10-rc2-kjt1/2.6.10-rc2-kjt1.patch.bz2

splitted out 130 patches (based on 2.6.10-rc2-bk4):
http://debian.stro.at/kjt/2.6.10-rc2-kjt1/2.6.10-rc2-kjt1-split.patch.bz2

thanks for feedback.
a++ maks



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
added since 2.6.10-rc1-kjt1

fix-comment-fs_jbd_journal.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] jbd: remove comment in journal.c

lib-parser-fs_devpts_inode.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] fs/devpts: use lib/parser

msleep_interruptible-drivers_cdrom_sonycd535_2.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] cdrom/sonycd535: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_message_fusion_mptbase.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] message/mptbase: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_net_ewrk3.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] net/ewrk3: replace schedule_timeout() with 	msleep_interruptible()

reorder-state-drivers_char_snsc.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] char/snsc: reorder set_current_state() and 	add_wait_queue()

reorder-state-drivers_video_pxafb.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] video/pxafb: reorder add_wait_queue() and 	set_current_state()

reorder-state-drivers_video_sa1100fb.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] video/sa1100fb: reorder set_current_state() and 	add_wait_queue()

set_current_state-drivers_input_joystick_iforce_iforce-packets.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] input/iforce-packets: insert set_current_state() 	before schedule_timeout()

ssleep-drivers_scsi_qla2xxx_qla_os.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] scsi/qla_os: replace schedule_timeout() with ssleep()

check-register_netdevice_notifier-net_8021q_vlan.patch
  From: <WHarms@bfs.de>(Walter Harms)
  Subject: [KJ] linux-2.6.7/net/8021q/vlan.c: add error check

check-register_netdevice_notifier-net_atm_mpc.patch
  From: <WHarms@bfs.de>(Walter Harms)
  Subject: [KJ] linux-2.6.7/net/atm/mpc.c: add error check

docs-fs_super.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] fs/super.c: docbook comment fix

docs-kernel_sysctl.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] kernel/sysctl.c: docbook comments update

fix-test-kernel_sched.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] kernel/sched.c: fix subtle TASK_RUNNING compare

kconfig-arch_sh_drivers_pci.patch
  From: james4765@verizon.net
  Subject: [KJ] [PATCH 1/9] to arch/sh/drivers/pci/Kconfig

kconfig-arch_sparc64.patch
  From: james4765@verizon.net
  Subject: [KJ] [PATCH 2/9] to arch/sparc64/Kconfig

module_parm-net_ne2k-pci.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] net/ne2k-pci: module_param conversion

module_parm-net_wireless_atmel_cs.patch
  From: Stefan Sperling <stefan@binarchy.net>
  Subject: [KJ] [PATCH] convert atmel_cs wireless driver to module_param

module_parm-net_wireless_orinoco.patch
  From: Stefan Sperling <stefan@binarchy.net>
  Subject: [KJ] [PATCH] convert orinoco wireless driver to module_param

module_parm-net_wireless_wavelan.p.h.patch
  From: Stefan Sperling <stefan@binarchy.net>
  Subject: [KJ] [PATCH] convert wavelan.p.h to module_param

module_parm-net_wireless_wl3501_cs.patch
  From: Stefan Sperling <stefan@binarchy.net>
  Subject: [KJ] [PATCH] convert wl3501_cs wireless driver to module_param

msleep-sound_sparc_cs4231.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] Re: [Alsa-devel] [PATCH] sound/cs4231: replace 	schedule_timeout() with msleep_interruptible()

myri_code_cleanup.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] drivers/net/myri_code.h cleanup

printk-drivers-scsi-zalon.patch
  From: Andrew McGregor <am@misk.net>
  Subject: [KJ] [patch scsi/zalon 1] scsi/zalon: Added KERN macro to printk()

strlcpy-net_wireless_wavelan.patch
  From: Stefan Sperling <stefan@binarchy.net>
  Subject: [KJ] [PATCH] wavelan wireless driver: use strlcpy instead of memcpy 	to copy the interface name parameter


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 reworked 

msleep_interruptible-drivers_net_ixgb_ixgb_ethtool.patch
thanks Adrian Bunk for pointing to the error,
corrected by nacc.

for-each-pci-dev-arch_i386_pci_acpi.patch
msleep-drivers_net_e1000_e1000_osdep.patch
msleep-sound_isa_cs423x_cs4231_lib.patch
pci_dev_present-arch_ia64_pci_pci.patch
me due to rejects


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 merged 53 patches up to latest -rc:

add-for_each_pci_dev.patch
for-each-pci-dev-arch_ppc64_kernel_iSeries_pci.patch
for-each-pci-dev-arch_ppc64_kernel_pmac_pci.patch
for-each-pci-dev-arch_ppc64_kernel_pSeries_pci.patch
for-each-pci-dev-arch_ppc64_kernel_u3_iommu.patch
for-each-pci-dev-arch_sh_drivers_pci_fixups-dreamcast.patch
for-each-pci-dev-drivers_char_agp_sis-agp.patch
kernel-doc_sgml.patch
module-version-drivers_usb_serial_belkin_sa.patch
module-version-drivers_usb_serial_cyberjack.patch
module-version-drivers_usb_serial_pl2303.patch
msleep-drivers_net_tulip_de2104x.patch
msleep-drivers_pci_quirks.patch
msleep-drivers_serial_pmac_zilog.patch
msleep_interruptible-drivers_media_video_msp3400.patch 
msleep_interruptible-drivers_pnp_pnpbios_core.patch
msleep_interruptible-drivers_scsi_53c700.patch
msleep_interruptible-drivers_scsi_scsi_lib.patch
msleep_interruptible-drivers_serial_68328serial.patch
msleep_interruptible-drivers_serial_68360serial.patch
msleep_interruptible-drivers_serial_mcfserial.patch
msleep_interruptible-drivers_usb_media_dausb.patch
msleep_interruptible-drivers_usb_misc_tiglusb.patch
msleep_interruptible-drivers_w1_dscore.patch
msleep_interruptible-drivers_w1_w1_family.patch
msleep_interruptible-drivers_w1_w1_int.patch
msleep_interruptible-drivers_w1_w1.patch
msleep+msleep_interruptible-drivers_serial_serial_core.patch
msleep+ssleep-drivers_scsi_ahci.patch
pci_dev_present-arch-pci-irq.patch
pci_dev_present-drivers_char_watchdoc_scx200_wdt.patch
pci_dev_present-drivers_ide_ide.patch
pci_dev_present-drivers_pci_hotplug_ibmphp_core.patch
pci_dev_present-drivers_video_matrox_matroxfb_base.patch
pci_dev_present-sound_pci_cmipci.patch
remove-custom-msleep-drivers_serial_icom.patch
remove-pci-find-device-arch_m68k_atari_hades-pci.patch
remove-pci-find-device-arch_ppc_platforms_chrp_pci.patch
remove-pci-find-device-arch_ppc_platforms_gemini_pci.patch
remove-pci-find-device-arch_ppc_platforms_lopec.patch
remove-pci-find-device-arch_ppc_platforms_mcpn765.patch
remove-pci-find-device-arch_ppc_platforms_pcore.patch
remove-pci-find-device-arch_ppc_platforms_pmac_pci.patch
remove-pci-find-device-arch_ppc_platforms_pplus.patch
remove-pci-find-device-arch_ppc_platforms_prep_pci.patch
remove-pci-find-device-arch_ppc_platforms_prpmc750.patch
remove-pci-find-device-arch_ppc_platforms_sandpoint.patch
remove-pci-find-device-arch_sparc64_kernel_pci_iommu.patch
remove-pci-find-device-arch_sparc_kernel_ebus.patch
remove-pci-find-device-arch_x86_64_kernel_pci-gart.patch
remove-pci-find-device-drivers_net_sis900.patch
remove-pci-find-device-drivers_net_tulip_tulip_core.patch
remove-useless-pci-check-drivers_media_video_zr36120.patch


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
todo:
- more msleep* friends from nacc on the way
 
