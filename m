Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbVE1MYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVE1MYw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 08:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVE1MYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 08:24:51 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:42143 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S262716AbVE1MYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 08:24:49 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: Ark Linux team
To: linux-kernel@vger.kernel.org
Subject: ALSA Oops in 2.6.12-rc5-mm1
Date: Sat, 28 May 2005 14:25:08 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505281425.08171.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel NULL pointer dereference at virtual address 000000a4
 printing eip:
e0ead873
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: eeprom i2c_sensor radeon drm i2c_algo_bit i2c_core 
intel_agp agpgart snd_intel8x0 snd_via82xx
 gameport snd_ac97_codec ac97_bus snd_pcm snd_timer snd_page_alloc 
snd_mpu401_uart snd_rawmidi snd_seq_device sn
d soundcore psmouse binfmt_misc pcmcia firmware_class yenta_socket 
rsrc_nonstatic pcmcia_core 8139too mii af_pac
ket sr_mod ide_cd cdrom ohci1394 ieee1394 sd_mod usbhid usb_storage scsi_mod 
ehci_hcd uhci_hcd usbcore video the
rmal processor hotkey fan container button battery ac rtc
CPU:    0
EIP:    0060:[<e0ead873>]    Not tainted VLI
EFLAGS: 00010286   (2.6.12-0.rc5.1ark)
EIP is at snd_pcm_mmap_data_close+0xa/0x11 [snd_pcm]
eax: 00000000   ebx: d8bac880   ecx: d85dfd50   edx: e0ead869
esi: db2216a0   edi: db2216a0   ebp: b7eed000   esp: dbc94f54
ds: 007b   es: 007b   ss: 0068
Process artsd (pid: 1723, threadinfo=dbc94000 task=da70b030)
Stack: c0148c21 db2216a0 de875580 00000000 00000000 c0149ed6 db2216a0 000800fb
       d8bac880 fffffff0 de875584 d977bb70 d977bb7c b7efd000 d977bb70 de875580
       de8755b0 080970a0 dbc94000 c014a759 de875580 b7eed000 00010000 b7eed000
Call Trace:
 [<c0148c21>] remove_vm_struct+0x63/0x65
 [<c0149ed6>] do_munmap+0x1cf/0x22c
 [<c014a759>] sys_munmap+0x49/0x69
 [<c0102d7f>] sysenter_past_esp+0x54/0x75
Code: 8d 05 a0 0a ec e0 e8 a9 4d 41 df e9 17 ff ff ff 8b 44 24 04 8b 40 50 8b 
40 60 ff 80 a4 00 00 00 c3 8b 44 2
4 04 8b 40 50 8b 40 60 <ff> 88 a4 00 00 00 c3 83 ec 1c b9 48 00 00 00 89 7c 24 
14 89 6c
