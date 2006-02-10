Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWBJVlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWBJVlr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWBJVlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:41:47 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:36525 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932205AbWBJVlq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:41:46 -0500
Date: Fri, 10 Feb 2006 22:41:22 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Linux-LKLM <linux-kernel@vger.kernel.org>
Subject: [BUG GIT] Unable to handle kernel paging request at virtual address e1380288
Message-ID: <20060210214122.GA13881@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g418aade4-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I just wanted to mount an external USB HDD... this was what I got:

Marc

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="crash.txt"

[4297455.608000] usb 2-1: new full speed USB device using uhci_hcd and address 2
[4297455.813000] usb 2-1: configuration #1 chosen from 1 choice
[4297455.819000] Unable to handle kernel paging request at virtual address e1380288
[4297455.819000]  printing eip:
[4297455.819000] c01ee88e
[4297455.819000] *pde = 1f7f3067
[4297455.819000] *pte = 00000000
[4297455.819000] Oops: 0000 [#1]
[4297455.819000] PREEMPT
[4297455.819000] Modules linked in: irtty_sir sir_dev thermal fan button processor ac battery ipv6 nls_cp437 cifs ip_conntrack_irc ip_conntrack_ftp ip_conntrack nfnetlink dvb_usb_dibusb_mb dib3000mb dvb_usb_dibusb_common dib3000mc dib3000_common dvb_usb dvb_core i2c_core dvb_pll snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_seq_device ircomm_tty ircomm irda crc_ccitt hidp bnep hci_uart rfcomm l2cap bluetooth cpufreq_stats cpufreq_performance cpufreq_powersave cpufreq_ondemand cpufreq_conservative speedstep_ich speedstep_lib freq_table i8k nvidia backlight lcd mousedev evdev serial_cs eth1394 pcmcia firmware_class ohci1394 ieee1394 parport_pc parport 3c59x mii yenta_socket rsrc_nonstatic pcmcia_core snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc hw_random ide_cd cdrom psmouse serio_raw floppy pcspkr rtc uhci_hcd usbcore intel_agp agpgart unix
[4297455.819000] CPU:    0
[4297455.819000] EIP:    0060:[<c01ee88e>]    Tainted: P      VLI
[4297455.819000] EFLAGS: 00010282   (2.6.16-rc2-marc-g418aade4-dirty #46)
[4297455.819000] EIP is at kref_get+0x8/0x4a
[4297455.819000] eax: e1380288   ebx: e1380288   ecx: 00000000   edx: 00000000
[4297455.819000] esi: e138027c   edi: df15ae08   ebp: d7031414   esp: df15add0
[4297455.819000] ds: 007b   es: 007b   ss: 0068
[4297455.819000] Process khubd (pid: 984, threadinfo=df15a000 task=dfd2e030)
[4297455.819000] Stack: <0>e1380280 df15ae08 c02da465 e11b86e8 e1380280 c02da54a e1380288 00000000
[4297455.819000]        df15ae08 c025243b c0251ce5 df15ae08 d7031414 00000000 e0e56138 e0e56138
[4297455.819000]        e11b86dc d70314d8 d7031414 d703147c 00000000 c02524a2 e0e56040 00000000
[4297455.819000] Call Trace:
[4297455.819000]  [<c02da465>] klist_dec_and_del+0x16/0x1a
[4297455.819000]  [<c02da54a>] klist_next+0x3a/0x6c
[4297455.819000]  [<c025243b>] __device_attach+0x0/0x5
[4297455.819000]  [<c0251ce5>] bus_for_each_drv+0x6b/0x81
[4297455.819000]  [<c02524a2>] device_attach+0x62/0x66
[4297455.819000]  [<c025243b>] __device_attach+0x0/0x5
[4297455.819000]  [<c0251b76>] bus_add_device+0x33/0x137
[4297455.819000]  [<c0250e0d>] device_add+0xf3/0x15b
[4297455.819000]  [<e0e3fbf8>] usb_set_configuration+0x363/0x4e6 [usbcore]
[4297455.819000]  [<e0e3a495>] usb_new_device+0x22f/0x2c7 [usbcore]
[4297455.819000]  [<e0e3bb50>] hub_thread+0x869/0xdca [usbcore]
[4297455.819000]  [<c0101bb2>] __switch_to+0x1f/0x220
[4297455.819000]  [<c02dacc3>] schedule+0x383/0x66a
[4297455.819000]  [<c012c348>] autoremove_wake_function+0x0/0x4b
[4297455.819000]  [<c012c138>] kthread+0xaf/0xd4
[4297455.819000]  [<e0e3b2e7>] hub_thread+0x0/0xdca [usbcore]
[4297455.819000]  [<c012c089>] kthread+0x0/0xd4
[4297455.819000]  [<c0101005>] kernel_thread_helper+0x5/0xb
[4297455.819000] Code: 24 04 48 6c 2e c0 c7 04 24 48 3b 2f c0 e8 e6 af f2 ff e8 62 5b f1 ff eb b8 c7 44 24 0c 35 00 00 00 eb d3 53 83 ec 10 8b 5c 24 18 <8b> 03 85 c0 74 07 ff 03 83 c4 10 5b c3 c7 44 24 0c 20 00 00 00
[4297455.819000]  <6>note: khubd[984] exited with preempt_count 1
[4297460.352000] SCSI subsystem initialized
[4297460.371000] Initializing USB Mass Storage driver...

--RnlQjJ0d97Da+TV1--
