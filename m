Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSHTKer>; Tue, 20 Aug 2002 06:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSHTKer>; Tue, 20 Aug 2002 06:34:47 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:12787 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S316792AbSHTKeq>; Tue, 20 Aug 2002 06:34:46 -0400
Message-ID: <3D621BF8.F1242760@bigpond.com>
Date: Tue, 20 Aug 2002 20:37:44 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.20-pre4 blows away Xwindows with Matrox G400 and DRM
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was OK with pre2, went straight to pre4.
Upon running startx I get a fraction of a second of activity before
I'm plunged into an instant reboot.  Inspection of the XFree86.0.log
shows the first and last lines as:
XFree86 Version 4.2.0 (Red Hat Linux release: 4.2.0-8) / X Window System
(protocol Version 11, revision 0, vendor release 6600)
Release Date: 23 January 2002
        If the server is older than 6-12 months, or if your card is
        newer than the above date, look for a newer version before
        reporting problems.  (See http://www.XFree86.Org/)
Build Operating System: Linux 2.4.17-0.13smp i686 [ELF]
Build Host: daffy.perf.redhat.com
...
(==) MGA(0): Write-combining range (0xd8000000,0x2000000)
(II) MGA(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
(--) MGA(0): 16 DWORD fifo
(==) MGA(0): Default visual is TrueColor
(II) MGA(0): [drm] bpp: 16 depth: 16
(II) MGA(0): [drm] Sarea 2200+664: 2864
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
<EOF>

A good start continues on:
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 7, (OK)
drmGetBusid returned ''
(II) MGA(0): [drm] loaded kernel module for "mga" driver
(II) MGA(0): [drm] created "mga" driver at busid "PCI:1:0:0"
(II) MGA(0): [drm] added 8192 byte SAREA at 0xe08e2000
(II) MGA(0): [drm] mapped SAREA 0xe08e2000 to 0x40016000
(II) MGA(0): [drm] framebuffer handle = 0xd8000000
(II) MGA(0): [drm] added 1 reserved context for kernel
(II) MGA(0): [agp] Mode 0x1f000201 [AGP 0x1106/0x3099; Card 0x102b/0x0525]

Selection from my config:
CONFIG_AGP=m
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set

#
# DRM 4.1 drivers
#
CONFIG_DRM_NEW=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
CONFIG_DRM_MGA=m

Hardware:
Althon 1600+ XP, Matrox G400, VIA KT266A
