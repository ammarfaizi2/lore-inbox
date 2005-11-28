Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVK1NyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVK1NyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 08:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVK1NyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 08:54:07 -0500
Received: from attila.bofh.it ([213.92.8.2]:37836 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S932104AbVK1NyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 08:54:06 -0500
Date: Mon, 28 Nov 2005 14:52:54 +0100
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com
Subject: saa7134 broken in 2.6.15-rc2
Message-ID: <20051128135254.GA4218@wonderland.linux.it>
Reply-To: linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       md@linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: md@linux.it (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I am not subscribed anymore to the v4l list, please Cc me.]

If I remove the card=2 parameter then it loads without errors (but
obviously it will not work).

Nov 28 14:34:52 wonderland kernel: saa7130/34: v4l2 driver version 0.2.14 loaded
Nov 28 14:34:52 wonderland kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 16 (level, low) -> IRQ 20
Nov 28 14:34:52 wonderland kernel: saa7134[0]: found at 0000:00:0a.0, rev: 1, irq: 20, latency: 32, mmio: 0xd6000000
Nov 28 14:34:52 wonderland kernel: saa7134[0]: subsystem: 1131:0000, board: LifeView FlyVIDEO3000 [card=2,insmod option]
Nov 28 14:34:52 wonderland kernel: saa7134[0]: board init: gpio is 31000
Nov 28 14:34:52 wonderland kernel: saa7134[0]: there are different flyvideo cards with different tuners
Nov 28 14:34:52 wonderland kernel: saa7134[0]: out there, you might have to use the tuner=<nr> insmod
Nov 28 14:34:52 wonderland kernel: saa7134[0]: option to override the default value.
Nov 28 14:34:52 wonderland kernel: Unable to handle kernel NULL pointer dereference at virtual address 000006d0
Nov 28 14:34:52 wonderland kernel:  printing eip:
Nov 28 14:34:52 wonderland kernel: c0259b1b
Nov 28 14:34:52 wonderland kernel: *pde = 00000000
Nov 28 14:34:52 wonderland kernel: Oops: 0000 [#1]
Nov 28 14:34:52 wonderland kernel: Modules linked in: saa7134 radeon drm binfmt_misc af_packet lp nfsd exportfs lockd ipt_MASQUERADE sunrpc iptable_nat ip_nat ip_conntrack nfnetlink ipt_REJECT ipt_multiport iptable_filter ip_tables pppoatm ppp_generic slhc cxacru firmware_class usbatm atm it87 hwmon_vid hwmon i2c_dev i2c_isa usbhid snd_seq_midi snd_seq_midi_event snd_seq snd_via82xx snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi psmouse snd_seq_device serio_raw parport_pc parport 8250_pnp 8250 snd serial_core soundcore video_buf v4l2_common v4l1_compat ir_kbd_i2c ir_common videodev i2c_viapro evdev i2c_core skge crc32 ehci_hcd uhci_hcd sata_via libata usbcore ide_cd scsi_mod via_agp agpgart cdrom
Nov 28 14:34:52 wonderland kernel: CPU:    0
Nov 28 14:34:52 wonderland kernel: EIP:    0060:[<c0259b1b>]    Not tainted VLI
Nov 28 14:34:52 wonderland kernel: EFLAGS: 00010296   (2.6.15-rc2) 
Nov 28 14:34:52 wonderland kernel: EIP is at input_register_device+0xb/0x190
Nov 28 14:34:52 wonderland kernel: eax: 00000000   ebx: d0954a38   ecx: 00000000   edx: cc76d800
Nov 28 14:34:52 wonderland kernel: esi: 00000000   edi: ce872000   ebp: cc57ddec   esp: cc57ddd8
Nov 28 14:34:52 wonderland kernel: ds: 007b   es: 007b   ss: 0068
Nov 28 14:34:52 wonderland kernel: Process modprobe (pid: 5554, threadinfo=cc57c000 task=d37af540)
Nov 28 14:34:52 wonderland kernel: Stack: e0c540c0 00000200 d0954a38 d0954a38 d0954800 cc57de28 e0c431c5 00000000 
Nov 28 14:34:52 wonderland kernel:        d0954804 00000063 e0c540c0 d0954a18 cc76d800 e0c540c0 0ec00000 00040000 
Nov 28 14:34:52 wonderland kernel:        00000000 ce872000 dff0c000 000001e0 cc57de3c e0c3a448 ce872000 e0c448ae 
Nov 28 14:34:52 wonderland kernel: Call Trace:
Nov 28 14:34:52 wonderland kernel:  [<c01039ec>] show_stack+0x9c/0xe0
Nov 28 14:34:52 wonderland kernel:  [<c0103baf>] show_registers+0x15f/0x1f0
Nov 28 14:34:52 wonderland kernel:  [<c0103dad>] die+0xcd/0x150
Nov 28 14:34:52 wonderland kernel:  [<c030cd59>] do_page_fault+0x209/0x67b
Nov 28 14:34:52 wonderland kernel:  [<c010369f>] error_code+0x4f/0x54
Nov 28 14:34:52 wonderland kernel:  [<e0c431c5>] saa7134_input_init1+0x1d5/0x420 [saa7134]
Nov 28 14:34:52 wonderland kernel:  [<e0c3a448>] saa7134_hwinit1+0x98/0x110 [saa7134]
Nov 28 14:34:52 wonderland kernel:  [<e0c3ab35>] saa7134_initdev+0x2f5/0x7d0 [saa7134]
Nov 28 14:34:52 wonderland kernel:  [<c01ddd89>] pci_call_probe+0x19/0x20
Nov 28 14:34:52 wonderland kernel:  [<c01ddde1>] __pci_device_probe+0x51/0x60
Nov 28 14:34:52 wonderland kernel:  [<c01dde1f>] pci_device_probe+0x2f/0x50
Nov 28 14:34:52 wonderland kernel:  [<c02424f1>] driver_probe_device+0x41/0xc0
Nov 28 14:34:52 wonderland kernel:  [<c024265f>] __driver_attach+0x4f/0x60
Nov 28 14:34:52 wonderland kernel:  [<c0241a84>] bus_for_each_dev+0x54/0x80
Nov 28 14:34:52 wonderland kernel:  [<c0242698>] driver_attach+0x28/0x30
Nov 28 14:34:52 wonderland kernel:  [<c0241f6d>] bus_add_driver+0x7d/0xe0
Nov 28 14:34:52 wonderland kernel:  [<c0242abd>] driver_register+0x3d/0x50
Nov 28 14:34:52 wonderland kernel:  [<c01de0a2>] __pci_register_driver+0x72/0x90
Nov 28 14:34:52 wonderland kernel:  [<e0c3b322>] saa7134_init+0x52/0x60 [saa7134]
Nov 28 14:34:52 wonderland kernel:  [<c0130fed>] sys_init_module+0xcd/0x1c0
Nov 28 14:34:52 wonderland kernel:  [<c0102c09>] syscall_call+0x7/0xb
Nov 28 14:34:52 wonderland kernel: Code: 44 24 04 a8 13 37 c0 e8 24 15 f3 ff 83 c4 10 5b 5e 5f c9 c3 8d b6 00 00 00 00 8d bf 00 00 00 00 55 89 e5 56 53 83 ec 0c 8b 75 08 <8b> 96 d0 06 00 00 85 d2 0f 84 4e 01 00 00 8d 86 3c 06 00 00 c7 

-- 
ciao,
Marco
