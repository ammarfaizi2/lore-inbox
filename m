Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVCRQNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVCRQNi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVCRQLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:11:12 -0500
Received: from mail.charite.de ([160.45.207.131]:6330 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261681AbVCRQGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:06:02 -0500
Date: Fri, 18 Mar 2005 17:05:54 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.6.10 (EIP is at hid_init_reports+0x151/0x1d0 [usbhid])
Message-ID: <20050318160554.GY6542@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mar 18 14:56:35 newserver kernel: usb 2-2: new low speed USB device using uhci_hcd and address 7
Mar 18 14:56:36 newserver usb.agent[17991]:      usbhid: already loaded
Mar 18 14:56:37 newserver kernel: hiddev96: USB HID v1.00 Device [American Power Conversion Back-UPS 500 FW: 6.4.I USB FW: c1 ] on usb-0000:00:1d.1-2
Mar 18 14:56:37 newserver udev[18027]: configured rule in '/etc/udev/rules.d/udev.rules[38]' applied, 'hiddev0' becomes 'usb/%k'
Mar 18 14:56:37 newserver udev[18027]: creating device node '/dev/usb/hiddev0'
Mar 18 14:57:18 newserver hidups[18038]: Startup successful
Mar 18 14:57:19 newserver kernel: drivers/usb/input/hid-core.c: ctrl urb status -84 received
Mar 18 14:57:19 newserver kernel: drivers/usb/input/hid-core.c: ctrl urb status -71 received
Mar 18 14:57:19 newserver kernel: usb 2-2: USB disconnect, address 7
Mar 18 14:57:19 newserver kernel: drivers/usb/input/hid-core.c: input irq status -84 received
Mar 18 14:57:19 newserver kernel: drivers/usb/input/hid-core.c: can't resubmit intr, 0000:00:1d.1-2/input0, status -19
Mar 18 14:57:19 newserver kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
Mar 18 14:57:19 newserver kernel:  printing eip:
Mar 18 14:57:19 newserver kernel: d0a361b1
Mar 18 14:57:19 newserver kernel: *pde = 00000000
Mar 18 14:57:19 newserver kernel: Oops: 0000 [#1]
Mar 18 14:57:19 newserver kernel: PREEMPT
Mar 18 14:57:19 newserver kernel: Modules linked in: usbhid pppoe pppox ppp_generic slhc af_packet lp autofs4 ipt_TCPMSS ipt_MASQUERADE ipt_state iptable_filter iptable_nat ipv6 ip_conntrack ip_tables ide_cd cdrom parport_pc parport tsdev mousedev psmouse floppy evdev rtc pcspkr 3c59x snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc i810_audio ac97_codec soundcore i2c_i801 i2c_core pci_hotplug usblp uhci_hcd intel_agp agpgart dm_mod capability commoncap usbkbd usbcore ext3 jbd mbcache ide_generic atiixp pdc202xx_old cmd64x hpt366 ide_disk generic amd74xx serverworks cs5530 ns87415 sc1200 sis5513 piix alim15x3 hpt34x cs5520 opti621 slc90e66 cy82c693 trm290 pdc202xx_new rz1000 via82cxxx siimage aec62xx triflex ide_core unix fbcon font bitblit vesafb cfbcopyarea cfbimgblt cfbfillrect
Mar 18 14:57:19 newserver kernel: CPU:    0
Mar 18 14:57:19 newserver kernel: EIP:    0060:[pg0+275272113/1069863936]    Not tainted VLI
Mar 18 14:57:19 newserver kernel: EFLAGS: 00010286   (2.6.10-1-686)
Mar 18 14:57:19 newserver kernel: EIP is at hid_init_reports+0x151/0x1d0 [usbhid]
Mar 18 14:57:19 newserver kernel: eax: 00000000   ebx: 00000000   ecx: cb15e000   edx: be333c00
Mar 18 14:57:19 newserver kernel: esi: c4f3e024   edi: c4f3e000   ebp: 00000000   esp: c8679eb0
Mar 18 14:57:19 newserver kernel: ds: 007b   es: 007b   ss: 0068
Mar 18 14:57:19 newserver kernel: Process hidups (pid: 18038, threadinfo=c8678000 task=ce837590)
Mar 18 14:57:19 newserver kernel: Stack: c4f3e000 cb15e200 00000080 00000021 00000100 00000000 00000000 00000000
Mar 18 14:57:19 newserver kernel:        00001388 c4f3e020 00004805 cb15e000 c4f3e000 00000000 d0a3785f c4f3e000
Mar 18 14:57:19 newserver kernel:        00000005 c8678000 c01253b4 ce837590 00000000 00040004 c8678000 c8679f20
Mar 18 14:57:19 newserver kernel: Call Trace:
Mar 18 14:57:19 newserver kernel:  [pg0+275277919/1069863936] hiddev_ioctl+0x1cf/0x9d0 [usbhid]
Mar 18 14:57:19 newserver kernel:  [ptrace_stop+132/192] ptrace_stop+0x84/0xc0
Mar 18 14:57:19 newserver kernel:  [ptrace_notify+103/144] ptrace_notify+0x67/0x90
Mar 18 14:57:19 newserver kernel:  [sys_ioctl+234/592] sys_ioctl+0xea/0x250
Mar 18 14:57:19 newserver kernel:  [do_syscall_trace+71/144] do_syscall_trace+0x47/0x90
Mar 18 14:57:19 newserver kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 18 14:57:19 newserver kernel: Code: b8 88 13 00 00 31 ed 8b 11 89 44 24 20 31 c0 c1 e2 08 89 44 24 1c 81 ca 00 00 00 80 89 6c 24 18 0f b7 87 4c 0c 00 00 89 44 24 14 <0f> b7 43 08 89 54 24 04 89 0c 24 89 44 24 10 b8 21 00 00 00 89
Mar 18 14:57:19 newserver udev[18047]: removing device node '/dev/usb/hiddev0'

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
