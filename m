Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbUJ0Ixg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbUJ0Ixg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 04:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUJ0Ixg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 04:53:36 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:24271 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262335AbUJ0Ixb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 04:53:31 -0400
Subject: Re: OOPS: 2.6.9 (not reproducable)
From: Marcel Holtmann <marcel@holtmann.org>
To: Ernst Herzberg <earny@net4u.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200410270110.57638.earny@net4u.de>
References: <200410270110.57638.earny@net4u.de>
Content-Type: multipart/mixed; boundary="=-VisIdUDBYjiU7TdjDIP1"
Date: Wed, 27 Oct 2004 10:53:46 +0200
Message-Id: <1098867226.6611.13.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VisIdUDBYjiU7TdjDIP1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ernst,

> Oct 26 23:26:25 halso Bluetooth: HCI USB driver ver 2.7
> Oct 26 23:26:25 halso hci_usb_probe: Can't set isoc interface settings

actually I heard of this problem and I don't know why the selecting of
the alternate setting on the second interface fails. I also seems that
this happens only on boot. I was not able to reproduce it on any of my
machines.

> Oct 26 23:26:25 halso Unable to handle kernel NULL pointer dereference at virtual address 00000120
> Oct 26 23:26:25 halso printing eip:
> Oct 26 23:26:25 halso f9c5688f
> Oct 26 23:26:25 halso *pde = 00000000
> Oct 26 23:26:25 halso Oops: 0000 [#1]
> Oct 26 23:26:25 halso PREEMPT
> Oct 26 23:26:25 halso Modules linked in: hci_usb ehci_hcd usbhid uhci_hcd evdev ath_pci ath_rate_onoe wlan ath_hal ds yenta_socket pcmcia_core snd_intel8x0 snd_ac97_codec snd_mpu401_uart snd_rawmi
> di snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore usbcore irtty_sir sir_dev irda crc_ccitt st sr_mod scsi_mod
> Oct 26 23:26:25 halso CPU:    0
> Oct 26 23:26:25 halso EIP:    0060:[<f9c5688f>]    Tainted: P   VLI
> Oct 26 23:26:25 halso EFLAGS: 00010296   (2.6.9)
> Oct 26 23:26:25 halso EIP is at hci_usb_close+0xf/0x60 [hci_usb]
> Oct 26 23:26:25 halso eax: c1917240   ebx: 00000000   ecx: f70269f8   edx: c1917250
> Oct 26 23:26:25 halso esi: 00000000   edi: 00000002   ebp: f9c58a00   esp: f709fe3c
> Oct 26 23:26:25 halso ds: 007b   es: 007b   ss: 0068
> Oct 26 23:26:25 halso Process modprobe (pid: 9335, threadinfo=f709e000 task=f7b06aa0)
> Oct 26 23:26:25 halso Stack: f743d800 f705c880 00000000 f9c57adf 00000000 c1917240 f9c58b20 c1917240
> Oct 26 23:26:25 halso f9c58b20 f98c2116 c1917240 c1917240 f700aab4 c1917250 f9c58b40 c0265d36
> Oct 26 23:26:25 halso c1917250 c1917278 c1917250 f705c880 f98c23c0 c1917250 00000005 f9c579e7
> Oct 26 23:26:25 halso Call Trace:
> Oct 26 23:26:25 halso [<f9c57adf>] hci_usb_disconnect+0x2f/0xa0 [hci_usb]
> Oct 26 23:26:25 halso [<f98c2116>] usb_unbind_interface+0x76/0x80 [usbcore]
> Oct 26 23:26:25 halso [<c0265d36>] device_release_driver+0x66/0x70
> Oct 26 23:26:25 halso [<f98c23c0>] usb_driver_release_interface+0x50/0x60 [usbcore]
> Oct 26 23:26:25 halso [<f9c579e7>] hci_usb_probe+0x387/0x450 [hci_usb]
> Oct 26 23:26:25 halso [<c018b0b0>] init_dir+0x0/0x20
> Oct 26 23:26:25 halso [<f98c208b>] usb_probe_interface+0x6b/0x80 [usbcore]
> Oct 26 23:26:25 halso [<c0265b5f>] bus_match+0x3f/0x70
> Oct 26 23:26:25 halso [<c0265c8c>] driver_attach+0x5c/0xa0
> Oct 26 23:26:25 halso [<c02661b1>] bus_add_driver+0x91/0xb0
> Oct 26 23:26:25 halso [<c026675f>] driver_register+0x2f/0x40
> Oct 26 23:26:25 halso [<c011a281>] vprintk+0x111/0x170
> Oct 26 23:26:25 halso [<f98c215e>] usb_register+0x3e/0xa0 [usbcore]
> Oct 26 23:26:25 halso [<c011a167>] printk+0x17/0x20
> Oct 26 23:26:25 halso [<f9885028>] hci_usb_init+0x28/0x4f [hci_usb]
> Oct 26 23:26:25 halso [<c0131992>] sys_init_module+0x182/0x230
> Oct 26 23:26:25 halso [<c010434b>] syscall_call+0x7/0xb
> Oct 26 23:26:25 halso Code: 83 7c 24 0c 03 0f 8e 11 ff ff ff 83 c4 10 5b 5e 5f 5d c3 89 f6 8d bc 27 00 00 00 00 83 ec 0c 89 5c 24 04 8b 5c 24 10 89 74 24 08 <8b> b3 20 01 00 00 0f ba 73 14 02 19 c
> 0 85 c0 74 29 9c 58 fa ba
> Oct 26 23:26:25 halso <6>usb 3-1: USB disconnect, address 2

I have the attached patch in my private tree. Please apply it and report
back if this happens again.

Regards

Marcel


--=-VisIdUDBYjiU7TdjDIP1
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/bluetooth/hci_usb.c 1.56 vs edited =====
--- 1.56/drivers/bluetooth/hci_usb.c	2004-10-08 17:21:34 +02:00
+++ edited/drivers/bluetooth/hci_usb.c	2004-10-21 15:43:57 +02:00
@@ -911,7 +917,9 @@
 				BT_ERR("Can't claim isoc interface");
 			else if (usb_set_interface(udev, isoc_ifnum, isoc_alts)) {
 				BT_ERR("Can't set isoc interface settings");
+				husb->isoc_iface = isoc_iface;
 				usb_driver_release_interface(&hci_usb_driver, isoc_iface);
+				husb->isoc_iface = NULL;
 			} else {
 				husb->isoc_iface  = isoc_iface;
 				husb->isoc_in_ep  = isoc_in_ep;

--=-VisIdUDBYjiU7TdjDIP1--

