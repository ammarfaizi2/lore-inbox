Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbUJXPM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbUJXPM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbUJXPM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:12:56 -0400
Received: from baikonur.stro.at ([213.239.196.228]:45515 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261511AbUJXPMs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:12:48 -0400
Date: Sun, 24 Oct 2004 17:12:41 +0200
From: maximilian attems <janitor@sternwelten.at>
To: kj <kernel-janitors@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [announce] 2.6.10-rc1-kjt1
Message-ID: <20041024151241.GA1920@stro.at>
Mail-Followup-To: kj <kernel-janitors@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lots of patches got merged! :)
2.6.9-kjt1 "died" in quick race after a few days.
rediffed to have a better base to push current patches soon.

new patches from nacc and domen. 
diffstat (minus the pci patches) shows a lot under drivers/{block,net}.

please test out:
http://debian.stro.at/kjt/2.6.10-rc1-kjt1/2.6.10-rc1-kjt1.patch.bz2

splitted out 168 patches:
http://debian.stro.at/kjt/2.6.10-rc1-kjt1/split/


thanks for feedback.
maks



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
added since 2.6.9-kjt1


fix-comment-fs_jbd_journal.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] jbd: remove comment in journal.c

lib-parser-fs_devpts_inode.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] fs/devpts: use lib/parser

msleep-drivers_pci_quirks.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] pci/quirks: replace schedule_timeout() with msleep()

msleep_interruptible-drivers_cdrom_sonycd535_2.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] cdrom/sonycd535: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_message_fusion_mptbase.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] message/mptbase: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_net_ewrk3.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] net/ewrk3: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_w1_dscore.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] w1/dscore: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_w1_w1_family.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] w1/w1_family: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_w1_w1_int.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] w1/w1_int: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_w1_w1.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] w1/w1: replace schedule_timeout() with 	msleep_interruptible()

msleep+ssleep-drivers_scsi_ahci.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] scsi/ahci: replace schedule_timeout() with 	msleep()/ssleep()

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



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 reworked 

remove-old-ifdefs-aic7xxx_osm_pci.patch
due to rejects and bogus previous rework 
(keeps 2.4 compatibility)

msleep_interruptible-drivers_serial_68328serial.patch
msleep_interruptible-drivers_serial_mcfserial.patch
due to rejects

msleep_interruptible-drivers_media_video_msp3400.patch
msleep-drivers_net_wireless_prism54_islpci_dev.patch
partially merged


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 merged 34 patches up to latest -rc:

min-max-arch_m68k_kernel_bios32.patch
modern-init-drivers_atm_zatm.patch
msleep-drivers_media_dvb_b2c2_skystar2.patch
msleep-drivers_media_dvb_dvb-core_dvb_ca_en50221.patch
msleep-drivers_media_dvb_dvb-core_dvb_frontend.patch
msleep-drivers_media_dvb_frontends_alps_tdmb7.patch
msleep-drivers_media_dvb_frontends_at76c651.patch
msleep-drivers_media_dvb_frontends_cs24110.patch
msleep-drivers_media_dvb_frontends_dst.patch
msleep-drivers_media_dvb_frontends_grundig_29504-401.patch
msleep-drivers_media_dvb_frontends_grundig_29504-491.patch
msleep-drivers_media_dvb_frontends_stv0299.patch
msleep-drivers_media_dvb_frontends_tda1004x.patch
msleep-drivers_media_dvb_frontends_ves1820.patch
msleep-drivers_media_dvb_frontends_ves1x93.patch
msleep-drivers_media_dvb_ttpci_av7110_hw.patch
msleep-drivers_media_dvb_ttpci_av7110.patch
msleep-drivers_media_dvb_ttpci_av7110_v4l.patch
msleep-drivers_media_dvb_ttpci_budget-av.patch
msleep-drivers_media_dvb_ttpci_budget-ci.patch
msleep-drivers_media_dvb_ttpci_budget.patch
msleep-drivers_media_video_bttv-driver.patch
msleep_interruptible-drivers_media_video_bttv-i2c.patch
msleep_interruptible-drivers_media_video_cx88_cx88-tvaudio.patch
msleep_interruptible-drivers_media_video_cx88_cx88-video.patch
msleep_interruptible-drivers_media_video_saa6752hs.patch
msleep_interruptible-drivers_media_video_saa7134_saa7134-core.patch
msleep_interruptible-drivers_media_video_saa7134_saa7134-ts.patch
msleep_interruptible-drivers_media_video_saa7134_saa7134-tvaudio.patch
pci_dev_present-drivers_media_video_bttv-driver.patch
printk-net_wireless_prism54_islpci_mgt.h.patch
msleep-drivers_char_sis-agp.patch
msleep_interruptible-drivers_char_amiserial.patch
msleep_interruptible-drivers_char_cyclades.patch




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 dropped

msleep-drivers_media_dvb_dvb-core_dvb_functions.patch
file removed


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
todo:
- split kernel_thread() patches from Walter Harms
- look at the new patches from Walter Harms
- look at dprintk patches from Daniele Pizzoni

 
