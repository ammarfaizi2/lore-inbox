Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWDLORi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWDLORi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 10:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWDLORi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 10:17:38 -0400
Received: from math.ut.ee ([193.40.36.2]:8699 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932186AbWDLORh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 10:17:37 -0400
Date: Wed, 12 Apr 2006 17:17:25 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: OOPS (ALSA?) in 2.6.17-rc1-g6246b612 (Apr 3)
Message-ID: <Pine.SOC.4.61.0604121713560.15688@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got this one from openoffice.org today. The -dirty is from a 8250 
serial debug patch. Seems to come from ALSAO OSS emulation.

BUG: unable to handle kernel NULL pointer dereference at virtual address 0000005c
  printing eip:
e08c894f
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: ipt_REJECT iptable_filter ip_tables x_tables r128 ipv6 md_mod adm1025 hwmon_vid smsc47m1 hwmon i2c_isa sd_mod usb_storage scsi_mod isofs zlib_inflate vfat fat eeprom ntfs snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc evdev i2c_i801 i2c_core uhci_hcd usbcore dm_mod
CPU:    0
EIP:    0060:[<e08c894f>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc1-g6246b612-dirty #176)
EIP is at snd_pcm_oss_get_formats+0x1b/0xfb [snd_pcm_oss]
eax: 00000000   ebx: bfc8380c   ecx: 00000050   edx: 00000000
esi: c2ecd960   edi: bfc8380c   ebp: c7555f0c   esp: c7555ee0
ds: 007b   es: 007b   ss: 0068
Process soffice.bin (pid: 30580, threadinfo=c7555000 task=c6a76570)
Stack: <0>c44880c0 dfa55ce8 dfa3f7a0 00000000 c014d29e c44880c0 dfa55ce8 c7555f20
        00000000 bfc8380c c2ecd960 c7555f50 e08c8f74 c44880c0 c7555f3c 08335b54
        c7555f34 c01454d3 c44880c0 00000000 00000000 c7555f88 c0145513 df4a2098
Call Trace:
  <c0103b50> show_stack_log_lvl+0x8b/0x95   <c0103c8c> show_registers+0x132/0x198
  <c0103fb3> die+0x168/0x1f2   <c011154f> do_page_fault+0x451/0x534
  <c01035eb> error_code+0x4f/0x54   <e08c8f74> snd_pcm_oss_ioctl+0x545/0x94d [snd_pcm_oss]
  <c0154c28> do_ioctl+0x20/0x65   <c0154eba> vfs_ioctl+0x24d/0x260
  <c0154ef7> sys_ioctl+0x2a/0x43   <c0102a77> sysenter_past_esp+0x54/0x75
Code: e8 04 4b 75 db 89 f0 e8 93 ff ff ff 5b 5e 5d c3 55 89 e5 56 53 83 ec 24 8d 55 f4 e8 f3 fe ff ff 85 c0 0f 88 dc 00 00 00 8b 55 f4 <8b> 42 5c 8b 80 a0 00 00 00 85 c0 75 11 f6 82 98 00 00 00 02 66

mroos@rhn:~$ uname -a
Linux rhn 2.6.17-rc1-g6246b612-dirty #176 PREEMPT Mon Apr 3 07:41:07 EEST 2006 i686 GNU/Linux


-- 
Meelis Roos (mroos@linux.ee)
