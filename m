Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWFFIxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWFFIxi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 04:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWFFIxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 04:53:38 -0400
Received: from [213.20.50.130] ([213.20.50.130]:12071 "EHLO [213.20.50.130]")
	by vger.kernel.org with ESMTP id S1751179AbWFFIxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 04:53:37 -0400
Date: Tue, 6 Jun 2006 10:53:08 +0200
From: Marc Koschewski <marc@osknowledge.org>
To: linux-kernel@vger.kernel.org
Cc: Patrick Boettcher <pb@linuxtv.org>
Subject: [GIT] BUG: unable to handle kernel paging request at virtual address f8fae04c
Message-ID: <20060606085308.GA11358@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.17-rc5-marc-g364212e0
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys.

Here's another one I found some days ago. Sorry for posting it that late.

The thing was plugging in an USB DVB-T adapter and running gxine on it. gxine
seems to be unable to 'get a lock' and I have to kill it. After killing gxine I
just tried again with no success and thus removed the USB device from the bus.

Patrick Boettcher is CCed.

Regards,
Marc

Jun  2 20:13:28 stiffy [4296959.430000] updating Tx fallback to 1 retries
Jun  2 20:13:28 stiffy [4296959.440000] get_mask 0x00000000, set_mask 0x00000000 - after update
Jun  2 20:13:28 stiffy [4296959.451000] get_mask 0x00000000, set_mask 0x00000200
Jun  2 20:13:28 stiffy [4296959.452000] updating transmit power: 18 dBm
Jun  2 20:13:28 stiffy [4296959.454000] wlan0: changing radio power level to 18 dBm (23)
Jun  2 20:13:28 stiffy [4296959.455000] get_mask 0x00000000, set_mask 0x00000000 - after update
Jun  2 20:13:28 stiffy [4296959.947000] BUG: unable to handle kernel paging request at virtual address f8fae04c
Jun  2 20:13:28 stiffy [4296959.947000]  printing eip:
Jun  2 20:13:28 stiffy [4296959.947000] f9009e8f
Jun  2 20:13:28 stiffy [4296959.947000] *pde = 47e39067
Jun  2 20:13:28 stiffy [4296959.947000] Oops: 0000 [#2]
Jun  2 20:13:28 stiffy [4296959.947000] PREEMPT 
Jun  2 20:13:28 stiffy [4296959.947000] Modules linked in: snd_pcm_oss snd_mixer_oss af_packet ohci_hcd ehci_hcd floppy pcspkr rtc isofs zlib_inflate ircomm_tty ircomm irda crc_ccitt hidp bnep hci_uart rfcomm l2cap bluetooth cpufreq_stats cpufreq_ondemand speedstep_ich speedstep_lib freq_table i8k backlight lcd snd_seq_oss snd_seq_midi_event snd_seq_dummy snd_seq snd_seq_device loop usb_storage scsi_mod video fan button battery ac thermal processor usbtest eth1394 dvb_usb_dibusb_mb dvb_usb_dibusb_common dib3000mc dvb_usb dvb_core dvb_pll dib3000mb serial_cs dib3000_common pcmcia acx firmware_class tsdev mousedev hw_random nvidiafb nvidia snd_intel8x0 snd_intel8x0m snd_ac97_codec snd_ac97_bus uhci_hcd snd_pcm usbcore intel_agp snd_timer evdev agpgart snd i2c_core ohci1394 parport_pc psmouse 3c59x soundcore mii snd_page_alloc ieee1394 parport ide_cd serio_raw yenta_socket rsrc_nonstatic pcmcia_core cdrom unix
Jun  2 20:13:28 stiffy [4296959.947000] CPU:    0
Jun  2 20:13:28 stiffy [4296959.947000] EIP:    0060:[<f9009e8f>]    Tainted: P      VLI
Jun  2 20:13:28 stiffy [4296959.947000] EFLAGS: 00010282   (2.6.17-rc5-marc-g705af309 #144) 
Jun  2 20:13:28 stiffy [4296959.947000] EIP is at dvb_demux_release+0xa/0x150 [dvb_core]
Jun  2 20:13:28 stiffy [4296959.947000] eax: f7ae3d10   ebx: f8fae000   ecx: f9009e85   edx: bff849c0
Jun  2 20:13:28 stiffy [4296959.947000] esi: bff849c0   edi: f7ae3d10   ebp: f7b227dc   esp: bf7c0e10
Jun  2 20:13:28 stiffy [4296959.947000] ds: 007b   es: 007b   ss: 0068
Jun  2 20:13:28 stiffy [4296959.947000] Process gxine (pid: 12832, threadinfo=bf7c0000 task=bf7c1a70)
Jun  2 20:13:28 stiffy [4296959.947000] Stack: f7ae3e38 00000008 bff849c0 f7ae3d10 f7b227dc b0159f14 00000000 b1b94ec0 
Jun  2 20:13:28 stiffy [4296959.947000]        bff849c0 00000000 f7974380 f7974380 b0157602 e236fce0 00001fff f7974388 
Jun  2 20:13:28 stiffy [4296959.947000]        00000000 b011996e 00000000 00000000 00000044 f7974380 bf7c1a70 00000001 
Jun  2 20:13:28 stiffy [4296959.947000] Call Trace:
Jun  2 20:13:28 stiffy [4296959.947000]  [<b0159f14>] __fput+0x8b/0x1c1
Jun  2 20:13:28 stiffy [4296959.947000]  [<b0157602>] filp_close+0x3e/0x62
Jun  2 20:13:28 stiffy [4296959.947000]  [<b011996e>] put_files_struct+0xa3/0xc7
Jun  2 20:13:28 stiffy [4296959.947000]  [<b011ac7d>] do_exit+0x159/0x997
Jun  2 20:13:28 stiffy [4296959.947000]  [<b012178f>] __dequeue_signal+0xb8/0x192
Jun  2 20:13:28 stiffy [4296959.947000]  [<b011b4e3>] do_group_exit+0x28/0x81
Jun  2 20:13:28 stiffy [4296959.947000]  [<b012376c>] get_signal_to_deliver+0x26a/0x410
Jun  2 20:13:28 stiffy [4296959.947000]  [<b01024b1>] do_notify_resume+0x72/0x667
Jun  2 20:13:28 stiffy [4296959.947000]  [<b015a195>] fget_light+0x83/0xa4
Jun  2 20:13:28 stiffy [4296959.947000]  [<f8830b28>] unix_listen+0x5b/0xd6 [unix]
Jun  2 20:13:28 stiffy [4296959.947000]  [<b025f2b0>] sys_socketcall+0xe9/0x294
Jun  2 20:13:28 stiffy [4296959.947000]  [<b0102e7e>] work_notifysig+0x13/0x19
Jun  2 20:13:28 stiffy [4296959.947000] Code: 8b 13 85 d2 74 0b 8b 4b 04 89 c8 ff 91 e4 10 00 00 89 d8 e8 a2 f9 ff ff c7 43 04 00 00 00 00 eb c5 55 57 56 53 83 ec 04 8b 5a 74 <8b> 73 4c 83 c6 38 89 f0 e8 2e 89 2b b7 ba 00 fe ff ff 85 c0 74 
Jun  2 20:13:28 stiffy [4296959.947000] EIP: [<f9009e8f>] dvb_demux_release+0xa/0x150 [dvb_core] SS:ESP 0068:bf7c0e10
Jun  2 20:13:28 stiffy [4296959.947000]  <1>Fixing recursive fault but reboot is needed!
Jun  2 20:13:33 stiffy ifplugd(eth0)[7576]: Exiting.
Jun  2 20:13:35 stiffy syslog-ng[9423]: syslog-ng version 1.6.11 going down
Jun  3 08:56:37 stiffy syslog-ng[9106]: syslog-ng version 1.6.11 starting
Jun  3 08:56:37 stiffy syslog-ng[9106]: Changing permissions on special file /dev/tty12
Jun  3 08:56:37 stiffy [4294667.296000] Linux version 2.6.17-rc5-marc-g705af309 (marc@stiffy) (gcc-Version 4.1.1-pre20060517 (prerelease) (Gentoo 4.1.1_pre20060517)) #144 PREEMPT Fri May 26 11:54:39 CEST 2006


