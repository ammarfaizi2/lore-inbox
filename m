Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292104AbSBOLM2>; Fri, 15 Feb 2002 06:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292103AbSBOLMS>; Fri, 15 Feb 2002 06:12:18 -0500
Received: from heavymos.kumin.ne.jp ([61.114.158.133]:5183 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S292100AbSBOLMH>; Fri, 15 Feb 2002 06:12:07 -0500
Message-Id: <200202151111.AA00015@prism.kumin.ne.jp>
Date: Fri, 15 Feb 2002 20:11:48 +0900
To: linux-kernel@vger.kernel.org
Cc: nakasei@fa.mdis.co.jp
Subject: linux-2.5.5-pre1 compile error at vesafb_init
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I update kernel to linux-2.5.4 + patch-2.5.5-pre1.
but compile error occured at vesafb_init.
I change kernel configuration from CONFIG_FB=y to CONFIG_FB=n,
So compile success and kernel work fine.

== Compile error message ( make bzImage ) ==

init/do_mounts.c:958: warning: `crd_load' defined but not used
vesafb.c: In function `vesafb_init':
vesafb.c:553: warning: passing arg 1 of `bus_to_virt_not_defined_use_pci_map' makes pointer from integer without a cast
drivers/video/video.o: In function `vesafb_init':
drivers/video/video.o(.text.init+0x1464): undefined reference to `bus_to_virt_not_defined_use_pci_map'
make: *** [vmlinux] Error 1

== My kernel configuration used CONFIG_FB=y ==

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
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
