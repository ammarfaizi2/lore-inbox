Return-Path: <linux-kernel-owner+w=401wt.eu-S1161487AbWLPVJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161487AbWLPVJu (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 16:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161489AbWLPVJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 16:09:50 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:58812 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161487AbWLPVJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 16:09:49 -0500
Subject: OOPS: 2.6.20-rc1 in ieee80211softmac_get_network_by_bssid_locked()
From: Ben Collins <ben.collins@ubuntu.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Martin Pitt <martin.pitt@ubuntu.com>, netdev@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 16 Dec 2006 16:09:44 -0500
Message-Id: <1166303384.6748.490.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel is 2.6.20-rc1, SMP, voluntary-preempt.

CC'd Martin, since he was the original reporter.

[  110.701863] ADDRCONF(NETDEV_UP): eth0: link is not ready
[  110.813273] Unable to handle kernel paging request for data at address 0x00000000
[  110.813291] Faulting instruction address: 0xf24124c4
[  110.813306] Oops: Kernel access of bad area, sig: 11 [#1]
[  110.813311] 
[  110.813314] Modules linked in: ipv6 radeon drm ppdev lp parport cpufreq_conservative cpufreq_stats cpufreq_userspace cpufreq_ondemand cpufreq_powersave reiserfs dm_crypt dm_mod therm_adt746x snd_powermac sbp2 scsi_mod apm_emu snd_aoa_i2sbus snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device snd soundcore pmac_zilog serial_core snd_aoa_soundbus bcm43xx ieee80211softmac ieee80211 ieee80211_crypt uninorth_agp agpgart tsdev evdev ext3 jbd mbcache ide_cd cdrom ide_disk ohci1394 ieee1394 sungem sungem_phy ehci_hcd ohci_hcd usbcore capability commoncap
[  110.813408] NIP: F24124C4 LR: F2412C08 CTR: C024C638
[  110.813417] REGS: effc9d90 TRAP: 0300   Not tainted  (2.6.20-1-powerpc)
[  110.813423] MSR: 00001032 <ME,IR,DR>  CR: 22000024  XER: 20000000
[  110.813435] DAR: 00000000, DSISR: 40000000
[  110.813441] TASK = effc0620[4] 'events/0' THREAD: effc8000
[  110.813446] GPR00: F2412C08 EFFC9E40 EFFC0620 EFAFA9A0 EFAFAA2C 00000000 EFFC9F18 F2414754 
[  110.813462] GPR08: 00000000 00000000 C03A5000 00000000 22000028 00000000 01719A4C 00241AC8 
[  110.813477] GPR16: 00241AC4 01719600 016B1E74 01719A44 00241B10 016B1D4C 016B282C 0171981C 
[  110.813492] GPR24: EFAFA9DC 00000000 00000000 F2414754 EFAFAA2C EFAFACC4 00000008 EFAFA9A0 
[  110.813508] NIP [F24124C4] ieee80211softmac_get_network_by_bssid_locked+0x1c/0x88 [ieee80211softmac]
[  110.813541] LR [F2412C08] ieee80211softmac_get_network_by_bssid+0x20/0x38 [ieee80211softmac]
[  110.813555] Call Trace:
[  110.813560] [EFFC9E40] [F2459E48] bcm43xx_generate_txhdr+0x15c/0x2d8 [bcm43xx] (unreliable)
[  110.813607] [EFFC9E60] [F2412C08] ieee80211softmac_get_network_by_bssid+0x20/0x38 [ieee80211softmac]
[  110.813623] [EFFC9E80] [F2414238] ieee80211softmac_send_disassoc_req+0x50/0x80 [ieee80211softmac]
[  110.813639] [EFFC9E90] [F2414528] ieee80211softmac_assoc_work+0x2c0/0x4ec [ieee80211softmac]
[  110.813654] [EFFC9ED0] [F2414D80] ieee80211softmac_notify_callback+0x50/0x1198 [ieee80211softmac]
[  110.813669] [EFFC9F50] [C004218C] run_workqueue+0xb4/0x174
[  110.813691] [EFFC9F70] [C0042A70] worker_thread+0x14c/0x178
[  110.813703] [EFFC9FC0] [C00466A4] kthread+0xc0/0xfc
[  110.813715] [EFFC9FF0] [C00143F4] kernel_thread+0x44/0x60
[  110.813725] Instruction dump:
[  110.813732] 80010024 bba10014 38210020 7c0803a6 4e800020 9421ffe0 7c0802a6 bf810010 
[  110.813753] 7c9c2378 3ba30324 90010024 81230324 <83e90000> 2f9f0000 419e0008 7c00fa2c 
[  110.813774]  <6>ADDRCONF(NETDEV_UP): eth1: link is not ready


