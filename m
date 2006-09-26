Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWIZR4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWIZR4B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWIZRzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:55:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:38787 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932222AbWIZRzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:55:44 -0400
X-Authenticated: #625117
Date: Tue, 26 Sep 2006 19:56:05 +0200
From: Dimitri Chausson <tri2000@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: serious kernel messages in /var/log/messages
Message-Id: <20060926195605.e0e9efa8.tri2000@gmx.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__26_Sep_2006_19_56_05_+0200_Aj_1633/iD+14C9i"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__26_Sep_2006_19_56_05_+0200_Aj_1633/iD+14C9i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I am using a 2.6.16-2-k7 kernel and experiencing problems. The computer sometimes freezes (not only X), sometimes my terminal disappear as I am typing something in, so it's very difficult to find the reason. I already suspect a hardware problem, but I do not know what to start with. I also included two excerpts of my /var/log/messages after such problem occured. 
Maybe some of you can give me a good hint. 
I reinstalled my whole system on sunday, b/c I wanted to exclude the possibility of badly broken software.. but those abnormal logs appeared since,

thanks a lot for your time,

Dimitri

--Multipart=_Tue__26_Sep_2006_19_56_05_+0200_Aj_1633/iD+14C9i
Content-Type: text/plain;
 name="kernel_pb.txt"
Content-Disposition: attachment;
 filename="kernel_pb.txt"
Content-Transfer-Encoding: 7bit

Sep 24 10:48:55 localhost pppoe-discovery: Timeout waiting for PADO packets
Sep 24 10:48:55 localhost kernel: eth1: link up, 100Mbps, full-duplex, lpa 0x41E1
Sep 24 10:49:07 localhost kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Sep 24 10:49:07 localhost kernel:  printing eip:
Sep 24 10:49:07 localhost kernel: b01264c2
Sep 24 10:49:07 localhost kernel: *pde = 00000000
Sep 24 10:49:07 localhost kernel: Oops: 0000 [#1]
Sep 24 10:49:07 localhost kernel: Modules linked in: pppoe pppox ppp_generic slhc nls_iso8859_1 isofs udf radeon drm ppdev lp button ac battery dm_mod loop bt878 tuner tvaudio msp3400 mousedev tsdev bttv video_buf firmware_class compat_ioctl32 i2c_algo_bit snd_via82xx i2c_viapro v4l2_common btcx_risc ir_common snd_ymfpci tveeprom snd_ac97_codec snd_ac97_bus snd_opl3_lib i2c_core via_ircc snd_mpu401 analog psmouse irda snd_bt87x snd_hwdep snd_mpu401_uart snd_pcm snd_timer snd_page_alloc shpchp pci_hotplug via_agp videodev snd_rawmidi snd_seq_device rtc snd serio_raw parport_pc parport gameport agpgart pcspkr evdev soundcore floppy crc_ccitt ext3 jbd mbcache ide_cd cdrom ide_disk via82cxxx via_rhine mii generic ide_core uhci_hcd usbcore thermal processor fan
Sep 24 10:49:07 localhost kernel: CPU:    0
Sep 24 10:49:07 localhost kernel: EIP:    0060:[<b01264c2>]    Not tainted VLI
Sep 24 10:49:07 localhost kernel: EFLAGS: 00210246   (2.6.16-2-k7 #1) 
Sep 24 10:49:07 localhost kernel: EIP is at hrtimer_cancel+0x4/0x12
Sep 24 10:49:07 localhost kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   edx: cfcaca00
Sep 24 10:49:07 localhost kernel: esi: c8df7f58   edi: cac9c800   ebp: c8df7f50   esp: c8df7f04
Sep 24 10:49:07 localhost kernel: ds: 007b   es: 007b   ss: 0068
Sep 24 10:49:07 localhost kernel: Process gksu (pid: 4667, threadinfo=c8df6000 task=cab04590)
Sep 24 10:49:07 localhost kernel: Stack: <0>00000000 b02627a5 c8df7f58 c8df7f58 00030d40 00000000 00000001 c8df7f58 
Sep 24 10:49:07 localhost kernel:        c8df7f58 00000000 c8df7f58 00000001 00000000 b012659d c8df7f58 00000001 
Sep 24 10:49:07 localhost kernel:        00000001 b011737b 00000282 ce554050 082a76f8 ceb03f58 00000000 00000000 
Sep 24 10:49:07 localhost kernel: Call Trace:
Sep 24 10:49:07 localhost kernel:  [<b02627a5>] schedule_hrtimer+0x2e/0x6c
Sep 24 10:49:07 localhost kernel:  [<b012659d>] hrtimer_nanosleep+0x56/0xee
Sep 24 10:49:07 localhost kernel:  [<b011737b>] eligible_child+0xb1/0xc2
Sep 24 10:49:07 localhost kernel:  [<b0126672>] sys_nanosleep+0x3d/0x4f
Sep 24 10:49:07 localhost kernel:  [<b0102939>] syscall_call+0x7/0xb
Sep 24 10:49:07 localhost kernel: Code: c8 ff 39 5a 18 74 1b 31 c0 83 7b 18 03 75 13 89 d8 e8 26 fe ff ff c7 43 18 00 00 00 00 b8 01 00 00 00 56 9d 5b 5e c3 53 8b 5c 24 <08> 53 e8 c1 ff ff ff 85 c0 5a 78 f5 5b c3 55 57 56 53 83 ec 10 
Sep 24 10:49:07 localhost kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000ec8
Sep 24 10:49:07 localhost kernel:  printing eip:
Sep 24 10:49:07 localhost kernel: b01264bf
Sep 24 10:49:07 localhost kernel: *pde = 00000000
Sep 24 10:49:07 localhost kernel: Oops: 0000 [#2]
Sep 24 10:49:07 localhost kernel: Modules linked in: pppoe pppox ppp_generic slhc nls_iso8859_1 isofs udf radeon drm ppdev lp button ac battery dm_mod loop bt878 tuner tvaudio msp3400 mousedev tsdev bttv video_buf firmware_class compat_ioctl32 i2c_algo_bit snd_via82xx i2c_viapro v4l2_common btcx_risc ir_common snd_ymfpci tveeprom snd_ac97_codec snd_ac97_bus snd_opl3_lib i2c_core via_ircc snd_mpu401 analog psmouse irda snd_bt87x snd_hwdep snd_mpu401_uart snd_pcm snd_timer snd_page_alloc shpchp pci_hotplug via_agp videodev snd_rawmidi snd_seq_device rtc snd serio_raw parport_pc parport gameport agpgart pcspkr evdev soundcore floppy crc_ccitt ext3 jbd mbcache ide_cd cdrom ide_disk via82cxxx via_rhine mii generic ide_core uhci_hcd usbcore thermal processor fan
Sep 24 10:49:07 localhost kernel: CPU:    0
Sep 24 10:49:07 localhost kernel: EIP:    0060:[<b01264bf>]    Not tainted VLI
Sep 24 10:49:07 localhost kernel: EFLAGS: 00210282   (2.6.16-2-k7 #1) 
Sep 24 10:49:07 localhost kernel: EIP is at hrtimer_cancel+0x1/0x12
Sep 24 10:49:07 localhost kernel: eax: cfedb540   ebx: cab04590   ecx: cab04590   edx: 00000f01
Sep 24 10:49:07 localhost kernel: esi: cab04590   edi: 0000000b   ebp: c8df7e5c   esp: c8df7e30
Sep 24 10:49:07 localhost kernel: ds: 007b   es: 007b   ss: 0068
Sep 24 10:49:07 localhost kernel: Process gksu (pid: 4667, threadinfo=c8df6000 task=cab04590)
Sep 24 10:49:07 localhost kernel: Stack: <0>cab04590 b0117b32 cfedb540 00000001 b01168ef b02848f1 c8df7e58 c8df7e58 
Sep 24 10:49:07 localhost kernel:        c8df6000 00000000 00200202 c8df7ed0 b0103dca c8df7ed0 b0274946 00000000 
Sep 24 10:49:07 localhost kernel:        000000ff 0000000b 00000000 00000000 cb14aa6c 00000000 b0111f85 b0274946 
Sep 24 10:49:07 localhost kernel: Call Trace:
Sep 24 10:49:07 localhost kernel:  [<b0117b32>] do_exit+0x145/0x615
Sep 24 10:49:07 localhost kernel:  [<b01168ef>] printk+0x12/0x16
Sep 24 10:49:07 localhost kernel:  [<b0103dca>] do_simd_coprocessor_error+0x0/0x163
Sep 24 10:49:07 localhost kernel:  [<b0111f85>] do_page_fault+0x37b/0x4a4
Sep 24 10:49:07 localhost kernel:  [<b0111c0a>] do_page_fault+0x0/0x4a4
Sep 24 10:49:07 localhost kernel:  [<b010346b>] error_code+0x4f/0x54
Sep 24 10:49:07 localhost kernel:  [<b01264c2>] hrtimer_cancel+0x4/0x12
Sep 24 10:49:07 localhost kernel:  [<b02627a5>] schedule_hrtimer+0x2e/0x6c
Sep 24 10:49:07 localhost kernel:  [<b012659d>] hrtimer_nanosleep+0x56/0xee
Sep 24 10:49:07 localhost kernel:  [<b011737b>] eligible_child+0xb1/0xc2
Sep 24 10:49:07 localhost kernel:  [<b0126672>] sys_nanosleep+0x3d/0x4f
Sep 24 10:49:07 localhost kernel:  [<b0102939>] syscall_call+0x7/0xb
Sep 24 10:49:07 localhost kernel: Code: 5e fa 83 c8 ff 39 5a 18 74 1b 31 c0 83 7b 18 03 75 13 89 d8 e8 26 fe ff ff c7 43 18 00 00 00 00 b8 01 00 00 00 56 9d 5b 5e c3 53 <8b> 5c 24 08 53 e8 c1 ff ff ff 85 c0 5a 78 f5 5b c3 55 57 56 53 
Sep 24 10:49:07 localhost kernel:  <1>Fixing recursive fault but reboot is needed!

--Multipart=_Tue__26_Sep_2006_19_56_05_+0200_Aj_1633/iD+14C9i
Content-Type: text/plain;
 name="kernel_pb2.txt"
Content-Disposition: attachment;
 filename="kernel_pb2.txt"
Content-Transfer-Encoding: 7bit

Sep 26 19:34:14 localhost kernel: Modules linked in: pppoe pppox radeon drm ppdev lp button ac battery ipv6 ppp_generic slhc dm_mod loop bt878 tuner tvaudio msp3400 mousedev tsdev bttv video_buf firmware_class compat_ioctl32 i2c_algo_bit snd_via82xx v4l2_common btcx_risc ir_common snd_ymfpci i2c_viapro analog tveeprom snd_ac97_codec snd_ac97_bus snd_opl3_lib via_ircc sd_mod i2c_core via_agp snd_bt87x snd_mpu401 snd_hwdep snd_mpu401_uart gameport shpchp pci_hotplug irda videodev snd_rawmidi snd_seq_device psmouse pcspkr agpgart floppy parport_pc parport snd_pcm snd_timer snd snd_page_alloc crc_ccitt evdev serio_raw soundcore rtc ext3 jbd mbcache ide_cd cdrom ide_disk usb_storage scsi_mod via82cxxx via_rhine mii generic ide_core uhci_hcd usbcore thermal processor fan
Sep 26 19:34:14 localhost kernel: EIP:    0060:[<b01564ed>]    Not tainted VLI
Sep 26 19:34:14 localhost kernel: EFLAGS: 00010287   (2.6.16-2-k7 #1) 
Sep 26 19:34:14 localhost kernel:  <0>general protection fault: 9408 [#2]
Sep 26 19:34:14 localhost kernel: Modules linked in: pppoe pppox radeon drm ppdev lp button ac battery ipv6 ppp_generic slhc dm_mod loop bt878 tuner tvaudio msp3400 mousedev tsdev bttv video_buf firmware_class compat_ioctl32 i2c_algo_bit snd_via82xx v4l2_common btcx_risc ir_common snd_ymfpci i2c_viapro analog tveeprom snd_ac97_codec snd_ac97_bus snd_opl3_lib via_ircc sd_mod i2c_core via_agp snd_bt87x snd_mpu401 snd_hwdep snd_mpu401_uart gameport shpchp pci_hotplug irda videodev snd_rawmidi snd_seq_device psmouse pcspkr agpgart floppy parport_pc parport snd_pcm snd_timer snd snd_page_alloc crc_ccitt evdev serio_raw soundcore rtc ext3 jbd mbcache ide_cd cdrom ide_disk usb_storage scsi_mod via82cxxx via_rhine mii generic ide_core uhci_hcd usbcore thermal processor fan
Sep 26 19:34:14 localhost kernel: EIP:    0060:[<b01564ed>]    Not tainted VLI
Sep 26 19:34:14 localhost kernel: EFLAGS: 00210287   (2.6.16-2-k7 #1) 
Sep 26 19:34:14 localhost kernel:  <0>general protection fault: 1600 [#3]
Sep 26 19:34:14 localhost kernel: Modules linked in: pppoe pppox radeon drm ppdev lp button ac battery ipv6 ppp_generic slhc dm_mod loop bt878 tuner tvaudio msp3400 mousedev tsdev bttv video_buf firmware_class compat_ioctl32 i2c_algo_bit snd_via82xx v4l2_common btcx_risc ir_common snd_ymfpci i2c_viapro analog tveeprom snd_ac97_codec snd_ac97_bus snd_opl3_lib via_ircc sd_mod i2c_core via_agp snd_bt87x snd_mpu401 snd_hwdep snd_mpu401_uart gameport shpchp pci_hotplug irda videodev snd_rawmidi snd_seq_device psmouse pcspkr agpgart floppy parport_pc parport snd_pcm snd_timer snd snd_page_alloc crc_ccitt evdev serio_raw soundcore rtc ext3 jbd mbcache ide_cd cdrom ide_disk usb_storage scsi_mod via82cxxx via_rhine mii generic ide_core uhci_hcd usbcore thermal processor fan
Sep 26 19:34:14 localhost kernel: EIP:    0060:[<b01564ed>]    Not tainted VLI
Sep 26 19:34:14 localhost kernel: EFLAGS: 00010287   (2.6.16-2-k7 #1) 

--Multipart=_Tue__26_Sep_2006_19_56_05_+0200_Aj_1633/iD+14C9i--
