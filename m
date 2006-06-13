Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWFMXhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWFMXhG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWFMXhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:37:06 -0400
Received: from web50208.mail.yahoo.com ([206.190.38.49]:64084 "HELO
	web50208.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964807AbWFMXhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:37:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Rax/Tuew0GuET4MZhYeSogkSS0BRzvmKSlfA6+9EdB+jbJJSmh/Ju3QKGH+oc75TqaOhOxIMuKc+EJ4gamMmr/XOVj/62LYahd2dlQOM8xyYETV43GViurhI/z7/zDYC7ay0DmgHzBPpg15dAQnjeL0E2f/vexwJtvX74SbUMgA=  ;
Message-ID: <20060613233654.57265.qmail@web50208.mail.yahoo.com>
Date: Tue, 13 Jun 2006 16:36:54 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Kernel panic when re-inserting Adaptec PCMCIA card
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The card is an Adaptec SlimSCSI 1460D Fast SCSI card.
I frequently get this panic when re-inserting the card:

Jun 13 17:53:29 siafu kernel: [4364313.475000] pccard: PCMCIA card inserted into slot 0
Jun 13 17:53:29 siafu kernel: [4364313.475000] pcmcia: registering new device pcmcia0.0
Jun 13 17:53:30 siafu kernel: [4364313.526000] aha152x: resetting bus...
Jun 13 17:53:30 siafu kernel: [4364313.882000] aha152x2: vital data: rev=1, io=0xd340
(0xd340/0xd340), irq=3, scsiid=7, reconnect=enabled, parity=enabled, synchronous=enabled,
delay=100, extended translation=disabled
Jun 13 17:53:30 siafu kernel: [4364313.882000] aha152x2: trying software interrupt, ok.
Jun 13 17:53:30 siafu kernel: [4364314.883000] scsi2 : Adaptec 152x SCSI driver; $Revision: 2.7 $
Jun 13 17:53:30 siafu kernel: [4364314.895000]
Jun 13 17:53:30 siafu kernel: [4364314.895000] aha152x0: bottom-half already running!?
Jun 13 17:53:30 siafu kernel: [4364314.895000]
Jun 13 17:53:30 siafu kernel: [4364314.895000] queue status:
Jun 13 17:53:30 siafu kernel: [4364314.895000] issue_SC:
Jun 13 17:53:30 siafu kernel: [4364314.895000] BUG: unable to handle kernel NULL pointer
dereference at virtual address 00000066
Jun 13 17:53:30 siafu kernel: [4364314.895000]  printing eip:
Jun 13 17:53:30 siafu kernel: [4364314.895000] e0a71e0c
Jun 13 17:53:30 siafu kernel: [4364314.895000] *pde = 00000000
Jun 13 17:53:30 siafu kernel: [4364314.895000] Oops: 0000 [#1]
Jun 13 17:53:30 siafu kernel: [4364314.895000] Modules linked in: ide_cd cdrom radeon drm
rate_control bcm43xx_d80211 80211 aha152x_cs scsi_transport_spi snd_pcm_oss snd_mixer_oss ohci_hcd
intel_agp usbhid uhci_hcd generic snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd
soundcore snd_page_alloc 8250_pci 8250 serial_core tg3 yenta_socket rsrc_nonstatic pcmcia
firmware_class crc32 pcmcia_core nls_iso8859_1 ntfs usbkbd usbmouse agpgart usb_storage sd_mod
scsi_mod ehci_hcd
Jun 13 17:53:30 siafu kernel: [4364314.895000] CPU:    0
Jun 13 17:53:30 siafu kernel: [4364314.895000] EIP:    0060:[<e0a71e0c>]    Not tainted VLI
Jun 13 17:53:30 siafu kernel: [4364314.895000] EFLAGS: 00010086   (2.6.17-rc5debug-g3cdcc4d0-dirty
#1)
Jun 13 17:53:30 siafu kernel: [4364314.895000] EIP is at show_command+0xc/0x1a0 [aha152x_cs]
Jun 13 17:53:30 siafu kernel: [4364314.895000] eax: 00000055   ebx: 00000062   ecx: 00000000  
edx: 00000000
Jun 13 17:53:30 siafu kernel: [4364314.895000] esi: dc412000   edi: 00000296   ebp: 00000000  
esp: dff07eb4
Jun 13 17:53:30 siafu kernel: [4364314.895000] ds: 007b   es: 007b   ss: 0068
Jun 13 17:53:30 siafu kernel: [4364314.895000] Process events/0 (pid: 4, threadinfo=dff06000
task=dff63a50)
Jun 13 17:53:30 siafu kernel: [4364314.895000] Stack: 00000296 00000000 c011a947 00000062 00000062
e0a71fd8 00000062 dc412000
Jun 13 17:53:30 siafu kernel: [4364314.895000]        dc412000 dffa2700 e0a71c4f dc412000 00000000
e0a73aa7 00000286 e0a71c10
Jun 13 17:53:30 siafu kernel: [4364314.895000]        dc412000 e0a73aa7 c0294667 dff07f4c dff63560
00000001 00000296 dffa2700
Jun 13 17:53:30 siafu kernel: [4364314.895000] Call Trace:
Jun 13 17:53:30 siafu kernel: [4364314.895000]  <c011a947> printk+0x17/0x20  <e0a71fd8>
show_queues+0x38/0xc0 [aha152x_cs]
Jun 13 17:53:30 siafu kernel: [4364314.895000]  <e0a71c4f> aha152x_error+0x2f/0x40 [aha152x_cs] 
<e0a71c10> is_complete+0x280/0x290 [aha152x_cs]
Jun 13 17:53:30 siafu kernel: [4364314.895000]  <c0294667> schedule+0x317/0x5d0  <e0a6f619>
run+0x19/0x30 [aha152x_cs]
Jun 13 17:53:30 siafu kernel: [4364314.895000]  <c012926f> run_workqueue+0x6f/0xe0  <e0a6f600>
run+0x0/0x30 [aha152x_cs]
Jun 13 17:53:30 siafu kernel: [4364314.895000]  <c012942b> worker_thread+0x14b/0x170  <c0116b60>
default_wake_function+0x0/0x20
Jun 13 17:53:30 siafu kernel: [4364314.895000]  <c0116b60> default_wake_function+0x0/0x20 
<c01292e0> worker_thread+0x0/0x170
Jun 13 17:53:30 siafu kernel: [4364314.895000]  <c012c7ea> kthread+0xba/0xc0  <c012c730>
kthread+0x0/0xc0
Jun 13 17:53:30 siafu kernel: [4364314.895000]  <c01013bd> kernel_thread_helper+0x5/0x18
Jun 13 17:53:30 siafu kernel: [4364314.895000] Code: 6a df e9 bc fe ff ff c7 04 24 8f 3b a7 e0 e8
3c 8b 6a df e9 a2 fe ff ff 8d b4 26 00 00 00 00 53 83 ec 10 8b 5c 24 18 89 5c 24 0c <8b> 53 04 8d
82 34 01 00 00 89 44 24 08 8b 82 70 01 00 00 ba 09
Jun 13 17:53:30 siafu kernel: [4364314.895000] EIP: [<e0a71e0c>] show_command+0xc/0x1a0
[aha152x_cs] SS:ESP 0068:dff07eb4
Jun 13 17:53:46 siafu kernel: [4364314.895000]  <3>(scsi2:0:0) cannot reuse command

I always typed "pccardctl eject" before removing the card.

Can test patches if necessary.

Machine is a Dell Latitude D600 running 2.6.17-rc5

#lspci
00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O Controller (rev 03)
00:01.0 PCI bridge: Intel Corporation 82855PM Processor to AGP Controller (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller
#1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller
#2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller
#3 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 01)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97
Audio Controller (rev 01)
00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev
01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [FireGL 9000] (rev 02)
02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705M Gigabit Ethernet (rev 01)
02:01.0 CardBus bridge: O2 Micro, Inc. OZ711EC1 SmartCardBus Controller (rev 20)
02:01.1 CardBus bridge: O2 Micro, Inc. OZ711EC1 SmartCardBus Controller (rev 20)
02:03.0 Network controller: Broadcom Corporation BCM4309 802.11a/b/g (rev 03)


-Alex

I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
