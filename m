Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131446AbRD1Ipi>; Sat, 28 Apr 2001 04:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131477AbRD1Ip3>; Sat, 28 Apr 2001 04:45:29 -0400
Received: from relay03.cablecom.net ([62.2.33.103]:60678 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S131446AbRD1IpW>; Sat, 28 Apr 2001 04:45:22 -0400
Message-ID: <3AEA831A.6707BEF@bluewin.ch>
Date: Sat, 28 Apr 2001 10:45:11 +0200
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.76 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Framebuffer does not handle kernel parameter when compiled as a 
 module
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two almost identical computers with different graphic cards (ATI
RageII, Matrox G200). I'd like to have the framebuffer devices compiled
as modules, but then the kernel parameters from lilo (i.e. append =
"video=atyfb:800x600@72") doesn't work. Afterwards switching with fbset
works. It seems as if the switching of the resolution is handled before
the corresponding module is loaded. Is there any solution to this
problem (besides compiling into the kernel) or is this a bug?

O. Wyss

-----------------------------------------------------------------------------------------
/usr/src/linux$> sh scripts/ver_linux
[...]
Linux Johann 2.4.3 #7 Son Apr 29 10:12:30 CEST 2001 i586 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.5
util-linux             2.11b
modutils               2.4.2
e2fsprogs              1.19
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.58
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nls_iso8859-1 binfmt_misc atyfb udf smbfs 3c509
ide-scsi sr_mod sg sd_mod aic7xxx loop

-----------------------------------------------------------------------------------------
/usr/src/linux$> most current.conf

#
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

[...]
#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
[...]
CONFIG_FB_VESA=y
[...]
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
[...]
CONFIG_FB_MATROX_G100=y
[...]
CONFIG_FB_ATY=m
CONFIG_FB_ATY128=m
[...]
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
[...]
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
