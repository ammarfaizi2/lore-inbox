Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVBZAmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVBZAmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 19:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVBZAmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 19:42:31 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:30438 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261271AbVBZAlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:41:42 -0500
Date: Sat, 26 Feb 2005 01:41:37 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.11-rc5
Message-ID: <20050226004137.GA25539@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050224145049.GA21313@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050224145049.GA21313@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Feb 24, Olaf Hering wrote:

>  On Wed, Feb 23, Linus Torvalds wrote:
> 
> > This time it's really supposed to be a quickie, so people who can, please 
> > check it out, and we'll make the real 2.6.11 asap.
> 
> radeonfb oopses on intel.
> Havent checked yet when it started with it.
> 
> ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 11 (level, low) -> IRQ 11
> eth0: VIA Rhine II at 0x1c400, 00:11:5b:83:1e:76, IRQ 11.
> eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 45e1.
> usb 5-1: new low speed USB device using uhci_hcd and address 2
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
> radeonfb: Found Intel x86 BIOS ROM Image
> radeonfb: Retreived PLL infos from BIOS
> radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=133.00 Mhz, System=133.00 MHz
> radeonfb: PLL min 12000 max 35000
> NET: Registered protocol family 23
> radeonfb: Monitor 1 type DFP found
> radeonfb: EDID probed
> radeonfb: Monitor 2 type no found
> radeonfb: Assuming panel size 8x1
> radeonfb: Can't find mode for panel size, going back to CRT
> Unable to handle kernel paging request at virtual address f3fb4000
>  printing eip:
> c01dec14
> *pde = 00000000
> Oops: 0002 [#1]
> Modules linked in: via_ircc irda crc_ccitt snd_via82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore radeonfb i2c_algo_bit i2c_core via_rhine mii pci_hotplug ohci1394 ehci_hcd ieee1394 uhci_hcd via_agp agpgart usbcore reiserfs dm_mod ext3 jbd
> CPU:    0
> EIP:    0060:[<c01dec14>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.11-rc4-bk10-200502230204-usbtest)
> EIP is at cfb_imageblit+0x364/0x610
> eax: 00000000   ebx: f3fb4004   ecx: 00000000   edx: f3fb4000
> esi: 00000004   edi: df282000   ebp: 00000007   esp: dbef1c1c
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 3180, threadinfo=dbef0000 task=da303580)
> Stack: 00000001 00000008 00000001 00000008 00000001 c04a7428 0000000a da302628
>        c011b293 00000046 da36e23c da36e000 00000046 0000051f c01043cf c0102eca
>        0000051f 1c46ece9 0000002b c036a2c0 df282000 00000000 0000000f 00000001
> Call Trace:
>  [<c011b293>] __do_softirq+0x43/0xa0
>  [<c01043cf>] do_IRQ+0x1f/0x30
>  [<c0102eca>] common_interrupt+0x1a/0x20
>  [<c01dd570>] soft_cursor+0x190/0x200
>  [<c01d9124>] bit_cursor+0x464/0x4e0
>  [<c011edbf>] msleep+0x2f/0x40
>  [<c01d4e18>] fbcon_cursor+0x1a8/0x280
>  [<c020eac8>] hide_cursor+0x18/0x30
>  [<c020edd4>] redraw_screen+0x174/0x200
>  [<c01d3caa>] fbcon_prepare_logo+0x39a/0x3a0
>  [<c01d47b0>] fbcon_init+0x260/0x300
>  [<c020ef69>] visual_init+0xe9/0x170
>  [<c02125e6>] take_over_console+0x176/0x350
>  [<c01d38da>] fbcon_takeover+0x5a/0x90
>  [<c01d846a>] fbcon_fb_registered+0x5a/0x70
>  [<c01d8542>] fbcon_event_notify+0x52/0x80
>  [<c0121898>] notifier_call_chain+0x18/0x30
>  [<c01da667>] register_framebuffer+0xd7/0x150
>  [<c0117713>] release_console_sem+0x13/0x90
>  [<c017f7c7>] sysfs_new_dirent+0x17/0x60
>  [<c017f820>] sysfs_make_dirent+0x10/0x70
>  [<c017f59a>] sysfs_add_file+0x3a/0x60
>  [<e0c4a698>] radeonfb_pci_register+0x308/0x510 [radeonfb]
>  [<c01ce482>] pci_device_probe_static+0x32/0x50
>  [<c01ce4c7>] __pci_device_probe+0x27/0x40
>  [<c01ce4fb>] pci_device_probe+0x1b/0x40
>  [<c021ef31>] driver_probe_device+0x21/0x60
>  [<c021f05d>] driver_attach+0x4d/0x80
>  [<c021f44d>] bus_add_driver+0x6d/0xa0
>  [<c021f948>] driver_register+0x28/0x30
>  [<c01ce6c4>] pci_register_driver+0x54/0x70
>  [<c012b1a2>] sys_init_module+0x112/0x190
>  [<c0102c49>] sysenter_past_esp+0x52/0x79
> Code: 24 60 8b 54 24 58 29 ce 0f be 07 89 f1 d3 f8 21 d0 8b 54 24 4c 8b 4c 24 54 23 0c 82 8b 54 24 64 89 c8 31 d0 89 da 83 c3 04 85 f6 <89> 02 75 06 be 08 00 00 00 47 8b 04 24 48 89 04 24 83 3c 24 ff
>  <6>usbcore: registered new driver hiddev
> input: USB HID v1.10 Mouse [Logitech Apple Optical USB Mouse] on usb-0000:00:10.2-1
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.0:USB HID core driver

modedb can not be __init because fb_find_mode() may get db == NULL.
fb_find_mode() is called from modules.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purNx tags linux-2.6.11-rc5.orig/drivers/video/modedb.c linux-2.6.11-rc5/drivers/video/modedb.c
--- linux-2.6.11-rc5.orig/drivers/video/modedb.c	2005-02-24 17:40:24.000000000 +0100
+++ linux-2.6.11-rc5/drivers/video/modedb.c	2005-02-26 01:37:43.138003474 +0100
@@ -37,7 +37,7 @@ const char *global_mode_option;
 
 #define DEFAULT_MODEDB_INDEX	0
 
-static const __init struct fb_videomode modedb[] = {
+static const struct fb_videomode modedb[] = {
     {
 	/* 640x400 @ 70 Hz, 31.5 kHz hsync */
 	NULL, 70, 640, 400, 39721, 40, 24, 39, 9, 96, 2,
