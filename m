Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131505AbRDSRUR>; Thu, 19 Apr 2001 13:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131508AbRDSRUD>; Thu, 19 Apr 2001 13:20:03 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:40202 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S131505AbRDSRSy>;
	Thu, 19 Apr 2001 13:18:54 -0400
Date: Thu, 19 Apr 2001 13:19:44 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Dead symbol elimination, stage 1
Message-ID: <20010419131944.A3049@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch cleans dead symbols out of the defconfigs in the 2.4.4pre4
source tree.  It corrects a typo involving CONFIG_GEN_RTC.  Another typo
involving CONFIG_SOUND_YMPCI doesn't need to be corrected, as the symbol
is never set in these files.

This completely eliminates one class of dead symbol, that discovered by

	kxref.py -f "d&~(c|h|o|m)"

That's 82 broken symbols, so it's a substantial whack.

--- arch/parisc/defconfig	Tue Dec  5 15:29:39 2000
+++ arch/parisc/defconfig	Thu Apr 19 11:03:09 2001
@@ -255,7 +255,7 @@
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-CONFIG_GENRTC=y
+CONFIG_GEN_RTC=y
 # CONFIG_INTEL_RNG is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
--- arch/alpha/defconfig	Sun Mar  4 17:30:18 2001
+++ arch/alpha/defconfig.tweaked	Thu Apr 19 12:23:56 2001
@@ -378,7 +378,6 @@
 # CONFIG_NE2K_PCI is not set
 # CONFIG_NE3210 is not set
 # CONFIG_ES3210 is not set
-# CONFIG_RTL8129 is not set
 # CONFIG_8139TOO is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
--- arch/arm/def-configs/a5k	Mon Nov 27 20:07:59 2000
+++ arch/arm/def-configs/a5k.tweaked	Thu Apr 19 12:23:56 2001
@@ -527,7 +527,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/def-configs/assabet	Mon Nov 27 20:07:59 2000
+++ arch/arm/def-configs/assabet.tweaked	Thu Apr 19 12:23:56 2001
@@ -54,8 +54,6 @@
 # CONFIG_SA1100_XP860 is not set
 # CONFIG_SA1100_PANGOLIN is not set
 CONFIG_ANGELBOOT=y
-CONFIG_SA1100_FREQUENCY_SCALE=y
-# CONFIG_SA1100_VOLTAGE_SCALE is not set
 # CONFIG_ARCH_ACORN is not set
 # CONFIG_FOOTBRIDGE is not set
 # CONFIG_FOOTBRIDGE_HOST is not set
@@ -83,8 +81,6 @@
 # PCMCIA/CardBus support
 #
 CONFIG_PCMCIA=y
-# CONFIG_PCMCIA_DEBUG is not set
-CONFIG_SA1100_PCMCIA=y
 CONFIG_VIRTUAL_BUS=y
 CONFIG_NET=y
 CONFIG_SYSVIPC=y
@@ -338,8 +334,6 @@
 CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
 CONFIG_SA1100_DEFAULT_BAUDRATE=9600
-CONFIG_TOUCHSCREEN_UCB1200=y
-# CONFIG_TOUCHSCREEN_BITSY is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_UNIX98_PTY_COUNT=32
 
@@ -381,7 +375,6 @@
 # CONFIG_FTAPE is not set
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
-# CONFIG_PCMCIA_SERIAL is not set
 
 #
 # File systems
@@ -517,7 +510,6 @@
 CONFIG_DUMMY_CONSOLE=y
 # CONFIG_FB_CYBER2000 is not set
 CONFIG_FB_SA1100=y
-# CONFIG_FB_MQ200 is not set
 # CONFIG_FB_VIRTUAL is not set
 # CONFIG_FBCON_ADVANCED is not set
 CONFIG_FBCON_CFB2=y
@@ -536,8 +528,6 @@
 # Sound
 #
 CONFIG_SOUND=y
-CONFIG_SOUND_UDA1341=y
-# CONFIG_SOUND_SA1100_SSP is not set
 # CONFIG_SOUND_CMPCI is not set
 # CONFIG_SOUND_EMU10K1 is not set
 # CONFIG_SOUND_FUSION is not set
@@ -561,7 +551,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/def-configs/brutus	Mon Nov 27 20:07:59 2000
+++ arch/arm/def-configs/brutus.tweaked	Thu Apr 19 12:23:56 2001
@@ -37,14 +37,11 @@
 # CONFIG_SA1100_CERF is not set
 # CONFIG_SA1100_BITSY is not set
 # CONFIG_SA1100_LART is not set
-# CONFIG_SA1100_THINCLIENT is not set
 # CONFIG_SA1100_GRAPHICSCLIENT is not set
 # CONFIG_SA1100_NANOENGINE is not set
 # CONFIG_SA1100_VICTOR is not set
 # CONFIG_SA1100_XP860 is not set
 CONFIG_ANGELBOOT=y
-# CONFIG_SA1100_FREQUENCY_SCALE is not set
-# CONFIG_SA1100_VOLTAGE_SCALE is not set
 # CONFIG_ARCH_ACORN is not set
 # CONFIG_FOOTBRIDGE is not set
 # CONFIG_FOOTBRIDGE_HOST is not set
@@ -151,8 +148,6 @@
 # CONFIG_VT_CONSOLE is not set
 CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
-# CONFIG_TOUCHSCREEN_UCB1200 is not set
-# CONFIG_TOUCHSCREEN_BITSY is not set
 # CONFIG_SERIAL is not set
 # CONFIG_SERIAL_EXTENDED is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
@@ -288,7 +283,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_INFO=y
--- arch/arm/def-configs/cerf	Mon Nov 27 20:07:59 2000
+++ arch/arm/def-configs/cerf.tweaked	Thu Apr 19 12:23:56 2001
@@ -35,17 +35,13 @@
 # CONFIG_SA1100_ASSABET is not set
 # CONFIG_SA1100_BRUTUS is not set
 CONFIG_SA1100_CERF=y
-CONFIG_SA1100_CERF_32MB=y
 # CONFIG_SA1100_BITSY is not set
 # CONFIG_SA1100_LART is not set
-# CONFIG_SA1100_THINCLIENT is not set
 # CONFIG_SA1100_GRAPHICSCLIENT is not set
 # CONFIG_SA1100_NANOENGINE is not set
 # CONFIG_SA1100_VICTOR is not set
 # CONFIG_SA1100_XP860 is not set
 # CONFIG_ANGELBOOT is not set
-# CONFIG_SA1100_FREQUENCY_SCALE is not set
-# CONFIG_SA1100_VOLTAGE_SCALE is not set
 # CONFIG_ARCH_ACORN is not set
 # CONFIG_FOOTBRIDGE is not set
 # CONFIG_FOOTBRIDGE_HOST is not set
@@ -63,15 +59,12 @@
 #
 # General setup
 #
-# CONFIG_SA1100_CERF_CMDLINE is not set
 CONFIG_HOTPLUG=y
 
 #
 # PCMCIA/CardBus support
 #
 CONFIG_PCMCIA=y
-# CONFIG_PCMCIA_DEBUG is not set
-CONFIG_SA1100_PCMCIA=y
 CONFIG_VIRTUAL_BUS=y
 CONFIG_NET=y
 CONFIG_SYSVIPC=y
@@ -134,10 +127,8 @@
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IP_PNP_RARP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_IPV6 is not set
@@ -182,7 +173,6 @@
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
-CONFIG_CERF_CS8900A=y
 # CONFIG_ARM_AM79C961A is not set
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_LANCE is not set
@@ -293,8 +283,6 @@
 # CONFIG_VT_CONSOLE is not set
 CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
-CONFIG_TOUCHSCREEN_UCB1200=y
-# CONFIG_TOUCHSCREEN_BITSY is not set
 # CONFIG_SERIAL is not set
 # CONFIG_SERIAL_EXTENDED is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
@@ -339,7 +327,6 @@
 # CONFIG_FTAPE is not set
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
-# CONFIG_PCMCIA_SERIAL is not set
 
 #
 # File systems
@@ -426,7 +413,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/def-configs/clps7500	Mon Sep 18 18:15:24 2000
+++ arch/arm/def-configs/clps7500.tweaked	Thu Apr 19 12:23:56 2001
@@ -37,7 +37,6 @@
 CONFIG_CPU_32=y
 # CONFIG_CPU_26 is not set
 CONFIG_CPU_32v3=y
-CONFIG_CPU_ARM7=y
 # CONFIG_DISCONTIGMEM is not set
 # CONFIG_PCI is not set
 # CONFIG_ISA is not set
@@ -143,7 +142,6 @@
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
-CONFIG_BLK_DEV_FLD7500=y
 
 #
 # Networking options
@@ -159,10 +157,8 @@
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IP_PNP_RARP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_IPV6 is not set
@@ -255,7 +251,6 @@
 # Wan interfaces
 #
 # CONFIG_WAN is not set
-# CONFIG_ASH is not set
 
 #
 # Amateur Radio support
@@ -338,7 +333,6 @@
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-CONFIG_CLPS7500_FLASH=y
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
 
@@ -482,7 +476,6 @@
 #
 # Kernel hacking
 #
-# CONFIG_FRAME_POINTER is not set
 # CONFIG_DEBUG_ERRORS is not set
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/def-configs/ebsa110	Mon Nov 27 20:07:59 2000
+++ arch/arm/def-configs/ebsa110.tweaked	Thu Apr 19 12:23:56 2001
@@ -497,7 +497,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/def-configs/empeg	Wed Oct 20 19:29:08 1999
+++ arch/arm/def-configs/empeg.tweaked	Thu Apr 19 12:23:56 2001
@@ -18,15 +18,10 @@
 # CONFIG_SA1100_ITSY is not set
 # CONFIG_SA1100_PLEB is not set
 # CONFIG_SA1100_VICTOR is not set
-# CONFIG_EMPEG_HENRY is not set
 # CONFIG_ARCH_ACORN is not set
 # CONFIG_ISA_DMA is not set
 CONFIG_CPU_32=y
 # CONFIG_CPU_26 is not set
-# CONFIG_CPU_ARM2 is not set
-# CONFIG_CPU_ARM3 is not set
-# CONFIG_CPU_ARM6 is not set
-# CONFIG_CPU_ARM7 is not set
 CONFIG_CPU_SA110=y
 
 #
@@ -101,8 +96,6 @@
 # CONFIG_WATCHDOG is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
-CONFIG_EMPEG_IR=y
-CONFIG_EMPEG_USB=y
 
 #
 # Video For Linux
@@ -114,7 +107,6 @@
 # CONFIG_RADIO_CADET is not set
 # CONFIG_RADIO_MIROPCM20 is not set
 # CONFIG_RADIO_GEMTEK is not set
-CONFIG_RADIO_EMPEG=y
 # CONFIG_VIDEO_BT848 is not set
 # CONFIG_VIDEO_PMS is not set
 # CONFIG_VIDEO_SAA5249 is not set
@@ -138,19 +130,15 @@
 #
 # CONFIG_PACKET is not set
 # CONFIG_NETLINK is not set
-# CONFIG_FIREWALL is not set
 # CONFIG_FILTER is not set
 # CONFIG_UNIX is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
 # CONFIG_IP_PNP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
 # CONFIG_SYN_COOKIES is not set
-# CONFIG_INET_RARP is not set
 # CONFIG_SKB_LARGE is not set
 # CONFIG_IPV6 is not set
 # CONFIG_IPX is not set
@@ -163,7 +151,6 @@
 # CONFIG_WAN_ROUTER is not set
 # CONFIG_NET_FASTROUTE is not set
 # CONFIG_NET_HW_FLOWCONTROL is not set
-# CONFIG_CPU_IS_SLOW is not set
 
 #
 # QoS and/or fair queueing
@@ -255,10 +242,8 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_USER_BACKTRACE=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_LL is not set
--- arch/arm/def-configs/footbridge	Mon Nov 27 20:07:59 2000
+++ arch/arm/def-configs/footbridge.tweaked	Thu Apr 19 12:23:57 2001
@@ -265,7 +265,6 @@
 # CONFIG_NE3210 is not set
 # CONFIG_ES3210 is not set
 # CONFIG_8139TOO is not set
-# CONFIG_RTL8129 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -586,7 +585,6 @@
 # CONFIG_VIDEO_ZORAN is not set
 # CONFIG_VIDEO_BUZ is not set
 # CONFIG_VIDEO_ZR36120 is not set
-CONFIG_VIDEO_CYBERPRO=m
 
 #
 # Radio Adapters
@@ -746,7 +744,6 @@
 # CONFIG_FB_CLGEN is not set
 # CONFIG_FB_PM2 is not set
 # CONFIG_FB_ACORN is not set
-# CONFIG_FB_CLPS711X is not set
 CONFIG_FB_CYBER2000=y
 # CONFIG_FB_SA1100 is not set
 # CONFIG_FB_MATROX is not set
@@ -826,7 +823,6 @@
 # CONFIG_SOUND_YM3812 is not set
 # CONFIG_SOUND_OPL3SA1 is not set
 # CONFIG_SOUND_OPL3SA2 is not set
-# CONFIG_SOUND_YMPCI is not set
 # CONFIG_SOUND_UART6850 is not set
 # CONFIG_SOUND_AEDSP16 is not set
 CONFIG_SOUND_WAVEARTIST=m
@@ -885,7 +881,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/def-configs/graphicsclient	Mon Nov 27 20:07:59 2000
+++ arch/arm/def-configs/graphicsclient.tweaked	Thu Apr 19 12:23:57 2001
@@ -52,8 +52,6 @@
 # CONFIG_SA1100_SHERMAN is not set
 # CONFIG_SA1100_XP860 is not set
 # CONFIG_ANGELBOOT is not set
-# CONFIG_SA1100_FREQUENCY_SCALE is not set
-# CONFIG_SA1100_VOLTAGE_SCALE is not set
 # CONFIG_ARCH_ACORN is not set
 # CONFIG_FOOTBRIDGE is not set
 # CONFIG_FOOTBRIDGE_HOST is not set
@@ -81,8 +79,6 @@
 # PCMCIA/CardBus support
 #
 CONFIG_PCMCIA=y
-# CONFIG_PCMCIA_DEBUG is not set
-CONFIG_SA1100_PCMCIA=y
 CONFIG_VIRTUAL_BUS=y
 CONFIG_NET=y
 CONFIG_SYSVIPC=y
@@ -341,8 +337,6 @@
 CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
 CONFIG_SA1100_DEFAULT_BAUDRATE=38400
-# CONFIG_TOUCHSCREEN_UCB1200 is not set
-# CONFIG_TOUCHSCREEN_BITSY is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_UNIX98_PTY_COUNT=32
 
@@ -384,7 +378,6 @@
 # CONFIG_FTAPE is not set
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
-# CONFIG_PCMCIA_SERIAL is not set
 
 #
 # File systems
@@ -536,7 +529,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/def-configs/integrator	Mon Nov 27 20:07:59 2000
+++ arch/arm/def-configs/integrator.tweaked	Thu Apr 19 12:23:57 2001
@@ -58,11 +58,6 @@
 #
 CONFIG_CPU_32v4=y
 CONFIG_CPU_ARM720=y
-CONFIG_CPU_ARM920=y
-CONFIG_CPU_ARM920_CPU_IDLE=y
-CONFIG_CPU_ARM920_I_CACHE_ON=y
-CONFIG_CPU_ARM920_D_CACHE_ON=y
-# CONFIG_CPU_ARM920_WRITETHROUGH is not set
 # CONFIG_DISCONTIGMEM is not set
 
 #
@@ -139,7 +134,6 @@
 CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
-CONFIG_MTD_ARM=y
 
 #
 # Plug and Play configuration
@@ -249,7 +243,6 @@
 # CONFIG_NE3210 is not set
 # CONFIG_ES3210 is not set
 # CONFIG_8139TOO is not set
-# CONFIG_RTL8129 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -503,7 +496,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/def-configs/lart	Mon Sep 18 18:15:24 2000
+++ arch/arm/def-configs/lart.tweaked	Thu Apr 19 12:23:57 2001
@@ -33,13 +33,10 @@
 # CONFIG_SA1100_CERF is not set
 # CONFIG_SA1100_BITSY is not set
 CONFIG_SA1100_LART=y
-# CONFIG_SA1100_THINCLIENT is not set
 # CONFIG_SA1100_GRAPHICSCLIENT is not set
 # CONFIG_SA1100_NANOENGINE is not set
 # CONFIG_SA1100_VICTOR is not set
 # CONFIG_ANGELBOOT is not set
-CONFIG_SA1100_FREQUENCY_SCALE=m
-CONFIG_SA1100_VOLTAGE_SCALE=y
 # CONFIG_ARCH_ACORN is not set
 # CONFIG_FOOTBRIDGE is not set
 # CONFIG_FOOTBRIDGE_HOST is not set
@@ -126,10 +123,8 @@
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
 # CONFIG_IP_PNP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_IPV6 is not set
@@ -192,7 +187,6 @@
 # CONFIG_LNE390 is not set
 # CONFIG_NE3210 is not set
 # CONFIG_NE2K_PCI is not set
-# CONFIG_RTL8129 is not set
 # CONFIG_8139TOO is not set
 # CONFIG_SIS900 is not set
 # CONFIG_TLAN is not set
@@ -309,8 +303,6 @@
 # CONFIG_VT is not set
 CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
-CONFIG_TOUCHSCREEN_UCB1200=m
-# CONFIG_TOUCHSCREEN_BITSY is not set
 # CONFIG_SERIAL is not set
 # CONFIG_SERIAL_EXTENDED is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
@@ -471,12 +463,10 @@
 # CONFIG_SOUND_YM3812 is not set
 # CONFIG_SOUND_OPL3SA1 is not set
 # CONFIG_SOUND_OPL3SA2 is not set
-# CONFIG_SOUND_YMPCI is not set
 # CONFIG_SOUND_UART6850 is not set
 # CONFIG_SOUND_AEDSP16 is not set
 # CONFIG_SOUND_VIDC is not set
 # CONFIG_SOUND_WAVEARTIST is not set
-CONFIG_SOUND_SA1100_SSP=m
 # CONFIG_SOUND_TVMIXER is not set
 
 #
@@ -487,7 +477,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/def-configs/lusl7200	Mon Jun 19 20:59:33 2000
+++ arch/arm/def-configs/lusl7200.tweaked	Thu Apr 19 12:23:57 2001
@@ -84,7 +84,6 @@
 # CONFIG_BLK_DEV_LVM is not set
 # CONFIG_BLK_DEV_MD is not set
 # CONFIG_MD_LINEAR is not set
-# CONFIG_MD_STRIPED is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_INITRD=y
 
@@ -221,7 +220,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_INFO=y
--- arch/arm/def-configs/neponset	Mon Nov 27 20:07:59 2000
+++ arch/arm/def-configs/neponset.tweaked	Thu Apr 19 12:23:57 2001
@@ -54,8 +54,6 @@
 # CONFIG_SA1100_XP860 is not set
 CONFIG_ANGELBOOT=y
 CONFIG_SA1111=y
-CONFIG_SA1100_FREQUENCY_SCALE=y
-# CONFIG_SA1100_VOLTAGE_SCALE is not set
 # CONFIG_ARCH_ACORN is not set
 # CONFIG_FOOTBRIDGE is not set
 # CONFIG_FOOTBRIDGE_HOST is not set
@@ -83,8 +81,6 @@
 # PCMCIA/CardBus support
 #
 CONFIG_PCMCIA=y
-# CONFIG_PCMCIA_DEBUG is not set
-CONFIG_SA1100_PCMCIA=y
 CONFIG_VIRTUAL_BUS=y
 CONFIG_NET=y
 CONFIG_SYSVIPC=y
@@ -343,8 +339,6 @@
 CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
 CONFIG_SA1100_DEFAULT_BAUDRATE=9600
-CONFIG_TOUCHSCREEN_UCB1200=y
-# CONFIG_TOUCHSCREEN_BITSY is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_UNIX98_PTY_COUNT=32
 
@@ -389,7 +383,6 @@
 # CONFIG_FTAPE is not set
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
-# CONFIG_PCMCIA_SERIAL is not set
 
 #
 # File systems
@@ -525,7 +518,6 @@
 CONFIG_DUMMY_CONSOLE=y
 # CONFIG_FB_CYBER2000 is not set
 CONFIG_FB_SA1100=y
-# CONFIG_FB_MQ200 is not set
 # CONFIG_FB_VIRTUAL is not set
 # CONFIG_FBCON_ADVANCED is not set
 CONFIG_FBCON_CFB2=y
@@ -544,7 +536,6 @@
 # Sound
 #
 CONFIG_SOUND=y
-CONFIG_SOUND_UDA1341=y
 # CONFIG_SOUND_CMPCI is not set
 # CONFIG_SOUND_EMU10K1 is not set
 # CONFIG_SOUND_FUSION is not set
@@ -568,7 +559,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/def-configs/pangolin	Mon Nov 27 20:07:59 2000
+++ arch/arm/def-configs/pangolin.tweaked	Thu Apr 19 12:23:57 2001
@@ -53,8 +53,6 @@
 # CONFIG_SA1100_XP860 is not set
 CONFIG_SA1100_PANGOLIN=y
 # CONFIG_ANGELBOOT is not set
-# CONFIG_SA1100_FREQUENCY_SCALE is not set
-# CONFIG_SA1100_VOLTAGE_SCALE is not set
 # CONFIG_ARCH_ACORN is not set
 # CONFIG_FOOTBRIDGE is not set
 # CONFIG_FOOTBRIDGE_HOST is not set
@@ -78,8 +76,6 @@
 # PCMCIA/CardBus support
 #
 CONFIG_PCMCIA=y
-# CONFIG_PCMCIA_DEBUG is not set
-CONFIG_SA1100_PCMCIA=y
 CONFIG_VIRTUAL_BUS=y
 CONFIG_NET=y
 CONFIG_SYSVIPC=y
@@ -345,8 +341,6 @@
 CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
 CONFIG_SA1100_DEFAULT_BAUDRATE=115200
-# CONFIG_TOUCHSCREEN_UCB1200 is not set
-# CONFIG_TOUCHSCREEN_BITSY is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_UNIX98_PTY_COUNT=32
 
@@ -384,7 +378,6 @@
 # CONFIG_FTAPE is not set
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
-# CONFIG_PCMCIA_SERIAL is not set
 
 #
 # File systems
@@ -483,7 +476,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/def-configs/rpc	Mon Nov 27 20:07:59 2000
+++ arch/arm/def-configs/rpc.tweaked	Thu Apr 19 12:23:57 2001
@@ -59,8 +59,6 @@
 # Processor Type
 #
 CONFIG_CPU_32v3=y
-CONFIG_CPU_ARM6=y
-CONFIG_CPU_ARM7=y
 CONFIG_CPU_SA110=y
 # CONFIG_DISCONTIGMEM is not set
 
@@ -613,7 +611,6 @@
 CONFIG_FB=y
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FB_ACORN=y
-# CONFIG_FB_CLPS711X is not set
 # CONFIG_FB_CYBER2000 is not set
 # CONFIG_FB_SA1100 is not set
 # CONFIG_FB_VIRTUAL is not set
@@ -688,7 +685,6 @@
 # CONFIG_SOUND_YM3812 is not set
 # CONFIG_SOUND_OPL3SA1 is not set
 # CONFIG_SOUND_OPL3SA2 is not set
-# CONFIG_SOUND_YMPCI is not set
 # CONFIG_SOUND_UART6850 is not set
 # CONFIG_SOUND_AEDSP16 is not set
 CONFIG_SOUND_VIDC=m
@@ -702,7 +698,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/def-configs/shark	Mon Sep 18 18:15:24 2000
+++ arch/arm/def-configs/shark.tweaked	Thu Apr 19 12:23:57 2001
@@ -122,10 +122,8 @@
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
 # CONFIG_IP_PNP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_IPV6 is not set
@@ -192,7 +190,6 @@
 # CONFIG_LNE390 is not set
 # CONFIG_NE3210 is not set
 # CONFIG_NE2K_PCI is not set
-# CONFIG_RTL8129 is not set
 # CONFIG_8139TOO is not set
 # CONFIG_SIS900 is not set
 # CONFIG_TLAN is not set
@@ -230,7 +227,6 @@
 # Wan interfaces
 #
 # CONFIG_WAN is not set
-# CONFIG_ASH is not set
 
 #
 # Amateur Radio support
@@ -633,7 +629,6 @@
 # CONFIG_SOUND_YM3812 is not set
 # CONFIG_SOUND_OPL3SA1 is not set
 # CONFIG_SOUND_OPL3SA2 is not set
-# CONFIG_SOUND_YMPCI is not set
 # CONFIG_SOUND_UART6850 is not set
 # CONFIG_SOUND_AEDSP16 is not set
 # CONFIG_SOUND_VIDC is not set
@@ -647,7 +642,6 @@
 #
 # Kernel hacking
 #
-# CONFIG_FRAME_POINTER is not set
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/def-configs/sherman	Mon Nov 27 20:07:59 2000
+++ arch/arm/def-configs/sherman.tweaked	Thu Apr 19 12:23:57 2001
@@ -19,15 +19,10 @@
 # CONFIG_SA1100_PLEB is not set
 # CONFIG_SA1100_VICTOR is not set
 CONFIG_SA1100_SHERMAN=y
-# CONFIG_VICTOR_BOARD1 is not set
 # CONFIG_ARCH_ACORN is not set
 # CONFIG_ISA_DMA is not set
 CONFIG_CPU_32=y
 # CONFIG_CPU_26 is not set
-# CONFIG_CPU_ARM2 is not set
-# CONFIG_CPU_ARM3 is not set
-# CONFIG_CPU_ARM6 is not set
-# CONFIG_CPU_ARM7 is not set
 CONFIG_CPU_SA110=y
 
 #
@@ -202,7 +197,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_INFO=y
--- arch/arm/def-configs/victor	Mon Jun 19 20:59:33 2000
+++ arch/arm/def-configs/victor.tweaked	Thu Apr 19 12:23:57 2001
@@ -18,15 +18,10 @@
 # CONFIG_SA1100_ITSY is not set
 # CONFIG_SA1100_PLEB is not set
 CONFIG_SA1100_VICTOR=y
-# CONFIG_VICTOR_BOARD1 is not set
 # CONFIG_ARCH_ACORN is not set
 # CONFIG_ISA_DMA is not set
 CONFIG_CPU_32=y
 # CONFIG_CPU_26 is not set
-# CONFIG_CPU_ARM2 is not set
-# CONFIG_CPU_ARM3 is not set
-# CONFIG_CPU_ARM6 is not set
-# CONFIG_CPU_ARM7 is not set
 CONFIG_CPU_SA110=y
 
 #
@@ -195,7 +190,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
--- arch/arm/defconfig	Mon Jun 19 20:59:33 2000
+++ arch/arm/defconfig.tweaked	Thu Apr 19 12:23:57 2001
@@ -18,7 +18,6 @@
 # CONFIG_ARCH_EBSA110 is not set
 CONFIG_FOOTBRIDGE=y
 CONFIG_HOST_FOOTBRIDGE=y
-# CONFIG_ADDIN_FOOTBRIDGE is not set
 CONFIG_ARCH_EBSA285=y
 # CONFIG_ARCH_CATS is not set
 CONFIG_ARCH_NETWINDER=y
@@ -138,7 +137,6 @@
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_MD=y
 CONFIG_MD_LINEAR=m
-CONFIG_MD_STRIPED=m
 CONFIG_BLK_DEV_RAM=y
 # CONFIG_BLK_DEV_INITRD is not set
 
@@ -266,7 +264,6 @@
 CONFIG_USB_AUDIO=m
 CONFIG_USB_ACM=m
 # CONFIG_USB_SERIAL is not set
-# CONFIG_USB_CPIA is not set
 # CONFIG_USB_IBMCAM is not set
 # CONFIG_USB_OV511 is not set
 # CONFIG_USB_DC2XX is not set
@@ -289,8 +286,6 @@
 # CONFIG_USB_WMFORCE is not set
 CONFIG_INPUT_KEYBDEV=m
 CONFIG_INPUT_MOUSEDEV=m
-CONFIG_INPUT_MOUSEDEV_MIX=y
-# CONFIG_INPUT_MOUSEDEV_DIGITIZER is not set
 # CONFIG_INPUT_JOYDEV is not set
 # CONFIG_INPUT_EVDEV is not set
 
@@ -356,10 +351,8 @@
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IP_PNP_RARP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-CONFIG_IP_ALIAS=y
 # CONFIG_SYN_COOKIES is not set
 
 #
@@ -447,7 +440,6 @@
 # CONFIG_LNE390 is not set
 # CONFIG_NE3210 is not set
 CONFIG_NE2K_PCI=y
-# CONFIG_RTL8129 is not set
 # CONFIG_8139TOO is not set
 # CONFIG_SIS900 is not set
 # CONFIG_TLAN is not set
@@ -529,7 +521,6 @@
 CONFIG_BLK_DEV_OFFBOARD=y
 CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_BLK_DEV_IDEDMA=y
-CONFIG_IDEDMA_PCI_EXPERIMENTAL=y
 # CONFIG_IDEDMA_PCI_WIP is not set
 # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
 # CONFIG_BLK_DEV_AEC62XX is not set
@@ -539,14 +530,11 @@
 # CONFIG_BLK_DEV_AMD7409 is not set
 # CONFIG_AMD7409_OVERRIDE is not set
 # CONFIG_BLK_DEV_CMD64X is not set
-# CONFIG_CMD64X_RAID is not set
 CONFIG_BLK_DEV_CY82C693=y
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_HPT34X_AUTODMA is not set
 # CONFIG_BLK_DEV_HPT366 is not set
-# CONFIG_HPT366_FIP is not set
-# CONFIG_HPT366_MODE3 is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
 CONFIG_BLK_DEV_PDC202XX=y
@@ -714,7 +702,6 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
--- arch/cris/defconfig	Wed Apr 18 16:47:32 2001
+++ arch/cris/defconfig.tweaked	Thu Apr 19 12:23:57 2001
@@ -89,10 +89,6 @@
 CONFIG_PB_CHANGEABLE_DIR=00
 CONFIG_PB_CHANGEABLE_BITS=FF
 # CONFIG_JULIETTE is not set
-# CONFIG_JULIETTE_VIDEO is not set
-# CONFIG_JULIETTE_CCD is not set
-# CONFIG_JULIETTE_SS1M is not set
-# CONFIG_JULIETTE_MEGCCD is not set
 # CONFIG_ETRAX_USB_HOST is not set
 
 #
@@ -110,26 +106,17 @@
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_MTDRAM is not set
 CONFIG_MTD_CFI=y
-# CONFIG_MTD_CFI_GEOMETRY is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_AMDSTD=y
-# CONFIG_MTD_SHARP is not set
 # CONFIG_MTD_PHYSMAP is not set
 # CONFIG_MTD_NORA is not set
 # CONFIG_MTD_PNC2000 is not set
 # CONFIG_MTD_RPXLITE is not set
-# CONFIG_MTD_SBC_MEDIAGX is not set
-# CONFIG_MTD_ELAN_104NC is not set
-# CONFIG_MTD_SA1100 is not set
-# CONFIG_MTD_DC21285 is not set
-# CONFIG_MTD_CSTM_CFI_JEDEC is not set
 # CONFIG_MTD_JEDEC is not set
 # CONFIG_MTD_MIXMEM is not set
 # CONFIG_MTD_OCTAGON is not set
 # CONFIG_MTD_VMAX is not set
-# CONFIG_MTD_NAND is not set
-# CONFIG_MTD_NAND_SPIA is not set
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
--- arch/ia64/defconfig	Thu Jun 22 10:09:44 2000
+++ arch/ia64/defconfig.tweaked	Thu Apr 19 12:23:57 2001
@@ -112,24 +112,18 @@
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_BLK_DEV_IDEDMA=y
-CONFIG_IDEDMA_PCI_EXPERIMENTAL=y
 # CONFIG_IDEDMA_PCI_WIP is not set
 # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
-# CONFIG_BLK_DEV_AEC6210 is not set
-# CONFIG_AEC6210_TUNING is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_WDC_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD7409 is not set
 # CONFIG_AMD7409_OVERRIDE is not set
 # CONFIG_BLK_DEV_CMD64X is not set
-# CONFIG_CMD64X_RAID is not set
 # CONFIG_BLK_DEV_CY82C693 is not set
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_HPT34X_AUTODMA is not set
 # CONFIG_BLK_DEV_HPT366 is not set
-# CONFIG_HPT366_FIP is not set
-# CONFIG_HPT366_MODE3 is not set
 CONFIG_BLK_DEV_PIIX=y
 CONFIG_PIIX_TUNING=y
 # CONFIG_BLK_DEV_NS87415 is not set
@@ -275,4 +269,3 @@
 # CONFIG_IA64_DEBUG_CMPXCHG is not set
 # CONFIG_IA64_DEBUG_IRQ is not set
 # CONFIG_IA64_PRINT_HAZARDS is not set
-# CONFIG_KDB is not set
--- arch/m68k/defconfig	Mon Jun 19 15:56:08 2000
+++ arch/m68k/defconfig.tweaked	Thu Apr 19 12:23:57 2001
@@ -86,10 +86,8 @@
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
 # CONFIG_IP_PNP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
 # CONFIG_SYN_COOKIES is not set
 
 #
--- arch/mips/defconfig-ddb5476	Wed Apr 18 16:47:36 2001
+++ arch/mips/defconfig-ddb5476.tweaked	Thu Apr 19 12:23:57 2001
@@ -1,7 +1,6 @@
 #
 # Automatically generated make config: don't edit
 #
-CONFIG_MIPS=y
 # CONFIG_SMP is not set
 
 #
@@ -17,26 +16,18 @@
 # CONFIG_BAGET_MIPS is not set
 # CONFIG_DECSTATION is not set
 # CONFIG_DDB5074 is not set
-# CONFIG_MIPS_EV96100 is not set
-# CONFIG_MIPS_EV64120 is not set
-# CONFIG_MIPS_ATLAS is not set
-# CONFIG_MIPS_MALTA is not set
 # CONFIG_NINO is not set
-# CONFIG_MIPS_MAGNUM_4000 is not set
 # CONFIG_MOMENCO_OCELOT is not set
 CONFIG_DDB5476=y
 # CONFIG_OLIVETTI_M700 is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SNI_RM200_PCI is not set
-# CONFIG_MIPS_ITE8172 is not set
-# CONFIG_MIPS_IVR is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 CONFIG_I8259=y
 CONFIG_ISA=y
 CONFIG_PCI=y
 CONFIG_PC_KEYB=y
-CONFIG_ROTTEN_IRQ=y
 CONFIG_EISA=y
 
 #
@@ -67,7 +58,6 @@
 # General setup
 #
 CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_MIPS_FPU_EMULATOR=y
 CONFIG_KCORE_ELF=y
 CONFIG_ELF_KERNEL=y
 # CONFIG_BINFMT_AOUT is not set
@@ -304,7 +294,6 @@
 # CONFIG_NE3210 is not set
 # CONFIG_ES3210 is not set
 # CONFIG_8139TOO is not set
-# CONFIG_RTL8129 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -312,7 +301,6 @@
 # CONFIG_VIA_RHINE is not set
 # CONFIG_WINBOND_840 is not set
 # CONFIG_HAPPYMEAL is not set
-# CONFIG_LAN_SAA9730 is not set
 # CONFIG_NET_POCKET is not set
 
 #
@@ -536,6 +524,4 @@
 #
 CONFIG_CROSSCOMPILE=y
 # CONFIG_REMOTE_DEBUG is not set
-# CONFIG_LL_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
-# CONFIG_MIPS_UNCACHED is not set
--- arch/mips/defconfig-it8172	Wed Apr 18 16:47:36 2001
+++ arch/mips/defconfig-it8172.tweaked	Thu Apr 19 12:23:58 2001
@@ -1,7 +1,6 @@
 #
 # Automatically generated make config: don't edit
 #
-CONFIG_MIPS=y
 # CONFIG_SMP is not set
 
 #
@@ -17,28 +16,20 @@
 # CONFIG_BAGET_MIPS is not set
 # CONFIG_DECSTATION is not set
 # CONFIG_DDB5074 is not set
-# CONFIG_MIPS_EV96100 is not set
-# CONFIG_MIPS_EV64120 is not set
-# CONFIG_MIPS_ATLAS is not set
-# CONFIG_MIPS_MALTA is not set
 # CONFIG_NINO is not set
-# CONFIG_MIPS_MAGNUM_4000 is not set
 # CONFIG_MOMENCO_OCELOT is not set
 # CONFIG_DDB5476 is not set
 # CONFIG_OLIVETTI_M700 is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SNI_RM200_PCI is not set
-CONFIG_MIPS_ITE8172=y
 # CONFIG_IT8172_REVC is not set
 CONFIG_QTRONIX_KEYBOARD=y
 CONFIG_IT8172_CIR=y
 # CONFIG_IT8172_SCR0 is not set
 # CONFIG_IT8172_SCR1 is not set
-# CONFIG_MIPS_IVR is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
 CONFIG_PCI=y
-CONFIG_IT8712=y
 CONFIG_PC_KEYB=y
 # CONFIG_ISA is not set
 # CONFIG_EISA is not set
@@ -74,7 +65,6 @@
 # General setup
 #
 CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_MIPS_FPU_EMULATOR=y
 CONFIG_KCORE_ELF=y
 CONFIG_ELF_KERNEL=y
 # CONFIG_BINFMT_AOUT is not set
@@ -279,7 +269,6 @@
 # CONFIG_HPT34X_AUTODMA is not set
 # CONFIG_BLK_DEV_HPT366 is not set
 CONFIG_BLK_DEV_IT8172=y
-CONFIG_IT8172_TUNING=y
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
 # CONFIG_BLK_DEV_PDC202XX is not set
@@ -365,7 +354,6 @@
 # CONFIG_NE3210 is not set
 # CONFIG_ES3210 is not set
 CONFIG_8139TOO=y
-# CONFIG_RTL8129 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -373,7 +361,6 @@
 # CONFIG_VIA_RHINE is not set
 # CONFIG_WINBOND_840 is not set
 # CONFIG_HAPPYMEAL is not set
-# CONFIG_LAN_SAA9730 is not set
 # CONFIG_NET_POCKET is not set
 
 #
@@ -562,8 +549,5 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_MIPS_FPE_MODULE is not set
 # CONFIG_REMOTE_DEBUG is not set
-# CONFIG_LL_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
-# CONFIG_MIPS_UNCACHED is not set
--- arch/parisc/defconfig	Thu Apr 19 12:18:57 2001
+++ arch/parisc/defconfig.tweaked	Thu Apr 19 12:23:58 2001
@@ -175,7 +175,6 @@
 # CONFIG_NE2K_PCI is not set
 # CONFIG_NE3210 is not set
 # CONFIG_ES3210 is not set
-# CONFIG_RTL8129 is not set
 # CONFIG_8139TOO is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
@@ -222,7 +221,6 @@
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_GSC_PS2=y
-CONFIG_HIL=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_CONSOLE=y
 CONFIG_SERIAL_GSC=y
--- arch/parisc/defconfig~	Tue Dec  5 15:29:39 2000
+++ arch/parisc/defconfig~.tweaked	Thu Apr 19 12:23:58 2001
@@ -175,7 +175,6 @@
 # CONFIG_NE2K_PCI is not set
 # CONFIG_NE3210 is not set
 # CONFIG_ES3210 is not set
-# CONFIG_RTL8129 is not set
 # CONFIG_8139TOO is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
@@ -222,7 +221,6 @@
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_GSC_PS2=y
-CONFIG_HIL=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_CONSOLE=y
 CONFIG_SERIAL_GSC=y
@@ -255,7 +253,6 @@
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-CONFIG_GENRTC=y
 # CONFIG_INTEL_RNG is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
--- arch/ppc/configs/IVMS8_defconfig	Sat Mar  3 13:52:13 2001
+++ arch/ppc/configs/IVMS8_defconfig.tweaked	Thu Apr 19 12:23:58 2001
@@ -44,8 +44,6 @@
 # CONFIG_SMP is not set
 CONFIG_MACH_SPECIFIC=y
 CONFIG_MATH_EMULATION=y
-CONFIG_SASH=y
-CONFIG_SASH_PATH="/bin/sash"
 
 #
 # General setup
@@ -116,10 +114,8 @@
 CONFIG_IP_PNP=y
 # CONFIG_IP_PNP_BOOTP is not set
 # CONFIG_IP_PNP_RARP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_IPV6 is not set
@@ -321,7 +317,6 @@
 # CONFIG_INTEL_RNG is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
-# CONFIG_FLASH is not set
 
 #
 # Video For Linux
--- arch/ppc/configs/SM850_defconfig	Sat Mar  3 13:52:13 2001
+++ arch/ppc/configs/SM850_defconfig.tweaked	Thu Apr 19 12:23:58 2001
@@ -44,8 +44,6 @@
 # CONFIG_SMP is not set
 CONFIG_MACH_SPECIFIC=y
 CONFIG_MATH_EMULATION=y
-CONFIG_SASH=y
-CONFIG_SASH_PATH="/bin/sash"
 
 #
 # General setup
@@ -116,10 +114,8 @@
 CONFIG_IP_PNP=y
 # CONFIG_IP_PNP_BOOTP is not set
 # CONFIG_IP_PNP_RARP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_IPV6 is not set
@@ -284,8 +280,6 @@
 # CONFIG_INTEL_RNG is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
-CONFIG_FLASH=y
-CONFIG_AMD_FLASH=y
 
 #
 # Video For Linux
--- arch/ppc/configs/SPD823TS_defconfig	Sat Mar  3 13:52:13 2001
+++ arch/ppc/configs/SPD823TS_defconfig.tweaked	Thu Apr 19 12:23:58 2001
@@ -42,8 +42,6 @@
 # CONFIG_SMP is not set
 CONFIG_MACH_SPECIFIC=y
 CONFIG_MATH_EMULATION=y
-CONFIG_SASH=y
-CONFIG_SASH_PATH="/bin/sash"
 
 #
 # General setup
@@ -114,10 +112,8 @@
 CONFIG_IP_PNP=y
 # CONFIG_IP_PNP_BOOTP is not set
 # CONFIG_IP_PNP_RARP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_IPV6 is not set
@@ -282,7 +278,6 @@
 # CONFIG_INTEL_RNG is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
-# CONFIG_FLASH is not set
 
 #
 # Video For Linux
--- arch/ppc/configs/TQM823L_defconfig	Sat Mar  3 13:52:13 2001
+++ arch/ppc/configs/TQM823L_defconfig.tweaked	Thu Apr 19 12:23:58 2001
@@ -43,8 +43,6 @@
 # CONFIG_SMP is not set
 CONFIG_MACH_SPECIFIC=y
 CONFIG_MATH_EMULATION=y
-CONFIG_SASH=y
-CONFIG_SASH_PATH="/bin/sash"
 
 #
 # General setup
@@ -115,10 +113,8 @@
 CONFIG_IP_PNP=y
 # CONFIG_IP_PNP_BOOTP is not set
 # CONFIG_IP_PNP_RARP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_IPV6 is not set
@@ -283,8 +279,6 @@
 # CONFIG_INTEL_RNG is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
-CONFIG_FLASH=y
-CONFIG_AMD_FLASH=y
 
 #
 # Video For Linux
--- arch/ppc/configs/TQM850L_defconfig	Sat Mar  3 13:52:13 2001
+++ arch/ppc/configs/TQM850L_defconfig.tweaked	Thu Apr 19 12:23:58 2001
@@ -43,8 +43,6 @@
 # CONFIG_SMP is not set
 CONFIG_MACH_SPECIFIC=y
 CONFIG_MATH_EMULATION=y
-CONFIG_SASH=y
-CONFIG_SASH_PATH="/bin/sash"
 
 #
 # General setup
@@ -115,10 +113,8 @@
 CONFIG_IP_PNP=y
 # CONFIG_IP_PNP_BOOTP is not set
 # CONFIG_IP_PNP_RARP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_IPV6 is not set
@@ -283,8 +279,6 @@
 # CONFIG_INTEL_RNG is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
-CONFIG_FLASH=y
-CONFIG_AMD_FLASH=y
 
 #
 # Video For Linux
--- arch/ppc/configs/TQM860L_defconfig	Sat Mar  3 13:52:13 2001
+++ arch/ppc/configs/TQM860L_defconfig.tweaked	Thu Apr 19 12:23:58 2001
@@ -43,8 +43,6 @@
 # CONFIG_SMP is not set
 CONFIG_MACH_SPECIFIC=y
 CONFIG_MATH_EMULATION=y
-CONFIG_SASH=y
-CONFIG_SASH_PATH="/bin/sash"
 
 #
 # General setup
@@ -115,10 +113,8 @@
 CONFIG_IP_PNP=y
 # CONFIG_IP_PNP_BOOTP is not set
 # CONFIG_IP_PNP_RARP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_IPV6 is not set
@@ -283,8 +279,6 @@
 # CONFIG_INTEL_RNG is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
-CONFIG_FLASH=y
-CONFIG_AMD_FLASH=y
 
 #
 # Video For Linux
--- arch/ppc/configs/common_defconfig	Sun Mar  4 17:30:18 2001
+++ arch/ppc/configs/common_defconfig.tweaked	Thu Apr 19 12:23:58 2001
@@ -404,7 +404,6 @@
 # CONFIG_NE3210 is not set
 # CONFIG_ES3210 is not set
 # CONFIG_8139TOO is not set
-# CONFIG_RTL8129 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
--- arch/ppc/configs/ibmchrp_defconfig	Mon Jan 22 18:41:14 2001
+++ arch/ppc/configs/ibmchrp_defconfig.tweaked	Thu Apr 19 12:23:58 2001
@@ -26,7 +26,6 @@
 # CONFIG_8260 is not set
 # CONFIG_8xx is not set
 CONFIG_ALL_PPC=y
-# CONFIG_GEMINI is not set
 # CONFIG_APUS is not set
 # CONFIG_PPC601_SYNC_FIX is not set
 # CONFIG_SMP is not set
@@ -306,7 +305,6 @@
 # CONFIG_NE3210 is not set
 # CONFIG_ES3210 is not set
 # CONFIG_8139TOO is not set
-# CONFIG_RTL8129 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
--- arch/ppc/configs/power3_defconfig	Mon Jan 22 18:41:15 2001
+++ arch/ppc/configs/power3_defconfig.tweaked	Thu Apr 19 12:23:58 2001
@@ -105,8 +105,6 @@
 CONFIG_MD_RAID0=y
 CONFIG_MD_RAID1=y
 CONFIG_MD_RAID5=y
-# CONFIG_MD_BOOT is not set
-# CONFIG_AUTODETECT_RAID is not set
 CONFIG_BLK_DEV_LVM=y
 CONFIG_LVM_PROC_FS=y
 
@@ -285,7 +283,6 @@
 # CONFIG_NE3210 is not set
 # CONFIG_ES3210 is not set
 # CONFIG_8139TOO is not set
-# CONFIG_RTL8129 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -643,7 +640,6 @@
 # CONFIG_SOUND_YM3812 is not set
 # CONFIG_SOUND_OPL3SA1 is not set
 # CONFIG_SOUND_OPL3SA2 is not set
-# CONFIG_SOUND_YMPCI is not set
 # CONFIG_SOUND_YMFPCI is not set
 # CONFIG_SOUND_UART6850 is not set
 # CONFIG_SOUND_AEDSP16 is not set
--- arch/ppc/defconfig	Sun Mar  4 17:30:18 2001
+++ arch/ppc/defconfig.tweaked	Thu Apr 19 12:23:58 2001
@@ -403,7 +403,6 @@
 # CONFIG_NE3210 is not set
 # CONFIG_ES3210 is not set
 # CONFIG_8139TOO is not set
-# CONFIG_RTL8129 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
--- arch/sh/defconfig	Wed Aug  9 16:59:04 2000
+++ arch/sh/defconfig.tweaked	Thu Apr 19 12:23:58 2001
@@ -202,5 +202,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 CONFIG_SH_STANDARD_BIOS=y
 CONFIG_DEBUG_KERNEL_WITH_GDB_STUB=y
-CONFIG_GDB_STUB_VBR=a0000000
 CONFIG_SH_EARLY_PRINTK=y
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Love your country, but never trust its government.
	-- Robert A. Heinlein.
