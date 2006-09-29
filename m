Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161584AbWI2Tmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161584AbWI2Tmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161585AbWI2Tmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:42:55 -0400
Received: from p5082C379.dip.t-dialin.net ([80.130.195.121]:28408 "EHLO
	stiffy.osknowledge.org") by vger.kernel.org with ESMTP
	id S1161584AbWI2Tmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:42:54 -0400
Date: Fri, 29 Sep 2006 21:42:09 +0200
From: Marc Koschewski <marc@osknowledge.org>
To: linux-kernel@vger.kernel.org
Subject: [GIT 2.6.18-g94c12cc7] CRASH: removed PCMCIA device
Message-ID: <20060929194209.GA13805@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.18-rc5-marc
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi hackers,

this is what I got with yesterdays -git kernel running.

Case was:

Boot with D-Link DWL-650+ WLAN card using this acx driver

	http://acx100.erley.org/acx-20060215.tar.bz2

and remove the card from the slot. In case anyone wants to test me
some 'special' case or config, don't hasitate to direct me.

Regards,
Marc


Sep 29 21:08:20 stiffy sdpd[10655]: Bluetooth SDP daemon
Sep 29 21:08:22 stiffy cpufreqd: apm_init                 : /proc/apm: No such file or directory
Sep 29 21:08:25 stiffy [   92.721000] pccard: card ejected from slot 1
Sep 29 21:08:25 stiffy [   92.752000] BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000c
Sep 29 21:08:25 stiffy [   92.752000]  printing eip:
Sep 29 21:08:25 stiffy [   92.752000] c02d8bb6
Sep 29 21:08:25 stiffy [   92.752000] *pde = 00000000
Sep 29 21:08:25 stiffy [   92.752000] Oops: 0000 [#1]
Sep 29 21:08:25 stiffy [   92.752000] PREEMPT 
Sep 29 21:08:25 stiffy [   92.752000] Modules linked in: snd_pcm_oss snd_mixer_oss rtc isofs zlib_inflate pwc compat_ioctl32 videodev v4l1_compat v4l2_common dvb_usb_dibusb_mb dib3000mb dvb_usb_dibusb_common dib3000mc dib3000_common dvb_usb dvb_core dvb_pll ircomm_tty ircomm irda crc_ccitt hidp bnep hci_uart rfcomm l2cap bluetooth cpufreq_stats speedstep_lib acpi_cpufreq freq_table i8k backlight lcd snd_seq_oss snd_seq_midi_event snd_seq_dummy snd_seq snd_seq_device loop usb_storage scsi_mod video fan button sbs i2c_ec i2c_core battery ac thermal processor acx eth1394 pcmcia firmware_class tsdev mousedev snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm uhci_hcd usbcore parport_pc yenta_socket snd_timer ohci1394 intel_agp snd ieee1394 evdev rsrc_nonstatic agpgart psmouse parport pcspkr nvidiafb 3c59x soundcore mii pcmcia_core snd_page_alloc serio_raw ide_cd cdrom unix
Sep 29 21:08:25 stiffy [   92.752000] CPU:    0
Sep 29 21:08:25 stiffy [   92.752000] EIP:    0060:[<c02d8bb6>]    Not tainted VLI
Sep 29 21:08:25 stiffy [   92.752000] EFLAGS: 00010246   (2.6.18-marc-g94c12cc7 #1)
Sep 29 21:08:25 stiffy [   92.752000] EIP is at klist_del+0x6/0x52
Sep 29 21:08:25 stiffy [   92.752000] eax: 00000000   ebx: 00000104   ecx: f75932a4   edx: c033a890
Sep 29 21:08:25 stiffy [   92.752000] esi: f7ad7090   edi: c033a500   ebp: c1b5a448   esp: f7a4af20
Sep 29 21:08:25 stiffy [   92.752000] ds: 007b   es: 007b   ss: 0068
Sep 29 21:08:25 stiffy [   92.752000] Process pccardd (pid: 2462, ti=f7a4a000 task=f7da0570 task.ti=f7a4a000)
Sep 29 21:08:25 stiffy [   92.752000] Stack: 00000104 f7ad7048 c02516c4 f7ad7048 f7ad7048 f7ad70b0 c02504ca f7ad7048 
Sep 29 21:08:25 stiffy [   92.752000]        c1b5a400 f7ad7000 f7b12540 c0250500 f7ad7000 c01fa005 00000000 c01fa0f5 
Sep 29 21:08:25 stiffy [   92.752000]        c1b2f014 c1b5a400 00000080 c01fa188 f7b12428 f7b12428 f8841788 f8841852 
Sep 29 21:08:25 stiffy [   92.752000] Call Trace:
Sep 29 21:08:25 stiffy [   92.752000]  [<c02516c4>] bus_remove_device+0x86/0x9f
Sep 29 21:08:25 stiffy [   92.752000]  [<c02504ca>] device_del+0x13b/0x169
Sep 29 21:08:25 stiffy [   92.752000]  [<c0250500>] device_unregister+0x8/0x10
Sep 29 21:08:25 stiffy [   92.752000]  [<c01fa005>] pci_stop_dev+0x25/0x51
Sep 29 21:08:25 stiffy [   92.752000]  [<c01fa0f5>] pci_remove_bus_device+0x26/0x96
Sep 29 21:08:25 stiffy [   92.752000]  [<c01fa188>] pci_remove_behind_bridge+0x23/0x3b
Sep 29 21:08:25 stiffy [   92.752000]  [<f8841788>] socket_shutdown+0x88/0x136 [pcmcia_core]
Sep 29 21:08:25 stiffy [   92.752000]  [<f88421f7>] pccardd+0x23d/0x260 [pcmcia_core]
Sep 29 21:08:25 stiffy [   92.752000]  [<c012a0ca>] kthread+0xc9/0xcd
Sep 29 21:08:25 stiffy [   92.752000]  [<c0103ae3>] kernel_thread_helper+0x7/0x14
Sep 29 21:08:25 stiffy [   92.752000]  =======================
Sep 29 21:08:25 stiffy [   92.752000] Code: 04 89 42 04 89 10 c7 43 f8 00 01 10 00 c7 41 04 00 02 20 00 8d 43 04 e8 62 be e3 ff c7 43 f4 00 00 00 00 5b c3 56 53 89 c6 8b 00 <8b> 58 0c b8 01 00 00 00 e8 bc ac e3 ff 89 f0 e8 a9 ff ff ff 85 
Sep 29 21:08:25 stiffy [   92.752000] EIP: [<c02d8bb6>] klist_del+0x6/0x52 SS:ESP 0068:f7a4af20
Sep 29 21:08:28 stiffy exim[11153]: 2006-09-29 21:08:28 IPv6 socket creation failed: Address family not supported by protocol
Sep 29 21:08:28 stiffy exim[11153]: 2006-09-29 21:08:28 Failed to create IPv6 socket for wildcard listening (Address family not supported by protocol): will use IPv4
Sep 29 21:08:28 stiffy exim[11153]: 2006-09-29 21:08:28 exim 4.63 daemon started: pid=11153, -q15m, listening for SMTP on port 25 (IPv4)
Sep 29 21:10:19 stiffy syslog-ng[9704]: syslog-ng version 1.6.11 starting
Sep 29 21:10:19 stiffy syslog-ng[9704]: Changing permissions on special file /dev/tty12
Sep 29 21:10:19 stiffy [    0.000000] Linux version 2.6.18-rc7-marc (marc@stiffy) (gcc-Version 4.1.1 (Gentoo 4.1.1-r1)) #1 PREEMPT Mon Sep 11 22:31:32 CEST 2006


-- 
Marc Koschewski
