Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269523AbTGOTVq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269531AbTGOTVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:21:46 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:23935 "EHLO
	mwinf0204.wanadoo.fr") by vger.kernel.org with ESMTP
	id S269523AbTGOTVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:21:40 -0400
Date: Tue, 15 Jul 2003 21:35:45 +0200
From: "Jean-Luc Coulon (f5ibh)" <jean-luc.coulon@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Matrox Millenium and framebuffer
Message-ID: <20030715193545.GA1024@tangerine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've a Matrox Millenium card and I want to run the framebuffer.
I've set the following configuration :

# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G450 is not set
# CONFIG_FB_MATROX_G100A is not set
CONFIG_FB_MATROX_PROC=m
# CONFIG_FB_MATROX_MULTIHEAD is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_MFB=y
# CONFIG_FBCON_CFB2 is not set
# CONFIG_FBCON_CFB4 is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
# CONFIG_FBCON_AFB is not set
# CONFIG_FBCON_ILBM is not set
# CONFIG_FBCON_IPLAN2P2 is not set
# CONFIG_FBCON_IPLAN2P4 is not set
# CONFIG_FBCON_IPLAN2P8 is not set
# CONFIG_FBCON_MAC is not set


And I pass the parameter video=matrox to the kernel.
I tried video=matrox:vesa=<something> without any success.

Here are the boot lines from dmesg :

[root@tangerine] /usr/src/linux/drivers/video/matrox # dmesg | more
Linux version 2.4.21 (root@tangerine) (version gcc 3.3.1 20030626 
(Debian prerel
ease)) #1 mar jui 15 18:40:01 CEST 2003 matroxfb_Ti3026.c
BIOS-provided physical RAM map:50.h     matroxfb_Ti3026.h
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)s 
matroxfb_base.c  BIOS-e820: 0000000000100000 - 0000000017ffc000 
(usable)ess /boot/
config
  BIOS-e820: 0000000017ffc000 - 0000000017fff000 (ACPI data)
  BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)s /boot/
config-2.4.21  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98300
zone(0): 4096 pages.
zone(1): 94204 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda2 reboot=warm hdc=ide-scsi hdd=ide-
scsi pci=bi
osirq video=matrox
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 501.160 MHz processor.
Console: colour VGA+ 80x25

If I compile a vesa framebuffer, it works but not accelerated.

---
Regards
	Jean-Luc

----------------------------------------------------------------------------
Jean-Luc Coulon
28 rue d'Evette
90350 Evette-Salbert
FRANCE
