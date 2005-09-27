Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVI0WUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVI0WUo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVI0WUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:20:44 -0400
Received: from packet.digeo.com ([12.110.80.53]:54015 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id S1751061AbVI0WUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:20:35 -0400
Message-ID: <4339C59B.7090907@namesys.com>
Date: Tue, 27 Sep 2005 15:20:11 -0700
From: Nate Diller <nate@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de, akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] block cleanups: remove CONFIG_IOSCHED_NOOP
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2005 22:20:06.0574 (UTC) FILETIME=[9D4EC4E0:01C5C3B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The no-op scheduler is always compiled in, but the build system hasn't forgotten about 
CONFIG_IOSCHED_NOOP yet.  This patch removes all mention of it, since its last use is removed in 
add-kconfig-default-iosched-submenu.

Thanks

NATE

Signed-off-by: Nate Diller <nate@namesys.com>

---

  arch/alpha/defconfig                      |    1 -
  arch/arm/configs/assabet_defconfig        |    1 -
  arch/arm/configs/badge4_defconfig         |    1 -
  arch/arm/configs/bast_defconfig           |    1 -
  arch/arm/configs/cerfcube_defconfig       |    1 -
  arch/arm/configs/clps7500_defconfig       |    1 -
  arch/arm/configs/ebsa110_defconfig        |    1 -
  arch/arm/configs/edb7211_defconfig        |    1 -
  arch/arm/configs/enp2611_defconfig        |    1 -
  arch/arm/configs/ep80219_defconfig        |    1 -
  arch/arm/configs/epxa10db_defconfig       |    1 -
  arch/arm/configs/footbridge_defconfig     |    1 -
  arch/arm/configs/fortunet_defconfig       |    1 -
  arch/arm/configs/h3600_defconfig          |    1 -
  arch/arm/configs/h7201_defconfig          |    1 -
  arch/arm/configs/h7202_defconfig          |    1 -
  arch/arm/configs/hackkit_defconfig        |    1 -
  arch/arm/configs/integrator_defconfig     |    1 -
  arch/arm/configs/iq31244_defconfig        |    1 -
  arch/arm/configs/iq80321_defconfig        |    1 -
  arch/arm/configs/iq80331_defconfig        |    1 -
  arch/arm/configs/iq80332_defconfig        |    1 -
  arch/arm/configs/ixdp2400_defconfig       |    1 -
  arch/arm/configs/ixdp2401_defconfig       |    1 -
  arch/arm/configs/ixdp2800_defconfig       |    1 -
  arch/arm/configs/ixdp2801_defconfig       |    1 -
  arch/arm/configs/ixp4xx_defconfig         |    1 -
  arch/arm/configs/jornada720_defconfig     |    1 -
  arch/arm/configs/lart_defconfig           |    1 -
  arch/arm/configs/lpd7a400_defconfig       |    1 -
  arch/arm/configs/lpd7a404_defconfig       |    1 -
  arch/arm/configs/lubbock_defconfig        |    1 -
  arch/arm/configs/lusl7200_defconfig       |    1 -
  arch/arm/configs/mainstone_defconfig      |    1 -
  arch/arm/configs/mx1ads_defconfig         |    1 -
  arch/arm/configs/neponset_defconfig       |    1 -
  arch/arm/configs/netwinder_defconfig      |    1 -
  arch/arm/configs/omap_h2_1610_defconfig   |    1 -
  arch/arm/configs/pleb_defconfig           |    1 -
  arch/arm/configs/pxa255-idp_defconfig     |    1 -
  arch/arm/configs/rpc_defconfig            |    1 -
  arch/arm/configs/s3c2410_defconfig        |    1 -
  arch/arm/configs/shannon_defconfig        |    1 -
  arch/arm/configs/shark_defconfig          |    1 -
  arch/arm/configs/simpad_defconfig         |    1 -
  arch/arm/configs/smdk2410_defconfig       |    1 -
  arch/arm/configs/versatile_defconfig      |    1 -
  arch/cris/defconfig                       |    1 -
  arch/frv/defconfig                        |    1 -
  arch/h8300/defconfig                      |    1 -
  arch/i386/defconfig                       |    1 -
  arch/ia64/configs/bigsur_defconfig        |    1 -
  arch/ia64/configs/sim_defconfig           |    1 -
  arch/ia64/configs/sn2_defconfig           |    1 -
  arch/ia64/configs/tiger_defconfig         |    1 -
  arch/ia64/configs/zx1_defconfig           |    1 -
  arch/ia64/defconfig                       |    1 -
  arch/m32r/defconfig                       |    1 -
  arch/m32r/m32700ut/defconfig.m32700ut.smp |    1 -
  arch/m32r/m32700ut/defconfig.m32700ut.up  |    1 -
  arch/m32r/mappi/defconfig.nommu           |    1 -
  arch/m32r/mappi/defconfig.smp             |    1 -
  arch/m32r/mappi/defconfig.up              |    1 -
  arch/m32r/mappi2/defconfig.vdec2          |    1 -
  arch/m32r/mappi3/defconfig.smp            |    1 -
  arch/m32r/oaks32r/defconfig.nommu         |    1 -
  arch/m32r/opsput/defconfig.opsput         |    1 -
  arch/m68k/configs/amiga_defconfig         |    1 -
  arch/m68k/configs/apollo_defconfig        |    1 -
  arch/m68k/configs/atari_defconfig         |    1 -
  arch/m68k/configs/bvme6000_defconfig      |    1 -
  arch/m68k/configs/hp300_defconfig         |    1 -
  arch/m68k/configs/mac_defconfig           |    1 -
  arch/m68k/configs/mvme147_defconfig       |    1 -
  arch/m68k/configs/mvme16x_defconfig       |    1 -
  arch/m68k/configs/q40_defconfig           |    1 -
  arch/m68k/configs/sun3_defconfig          |    1 -
  arch/m68k/configs/sun3x_defconfig         |    1 -
  arch/m68k/defconfig                       |    1 -
  arch/m68knommu/defconfig                  |    1 -
  arch/mips/configs/atlas_defconfig         |    1 -
  arch/mips/configs/capcella_defconfig      |    1 -
  arch/mips/configs/cobalt_defconfig        |    1 -
  arch/mips/configs/db1000_defconfig        |    1 -
  arch/mips/configs/db1100_defconfig        |    1 -
  arch/mips/configs/db1500_defconfig        |    1 -
  arch/mips/configs/db1550_defconfig        |    1 -
  arch/mips/configs/ddb5476_defconfig       |    1 -
  arch/mips/configs/ddb5477_defconfig       |    1 -
  arch/mips/configs/decstation_defconfig    |    1 -
  arch/mips/configs/e55_defconfig           |    1 -
  arch/mips/configs/ev64120_defconfig       |    1 -
  arch/mips/configs/ev96100_defconfig       |    1 -
  arch/mips/configs/ip22_defconfig          |    1 -
  arch/mips/configs/ip27_defconfig          |    1 -
  arch/mips/configs/ip32_defconfig          |    1 -
  arch/mips/configs/it8172_defconfig        |    1 -
  arch/mips/configs/ivr_defconfig           |    1 -
  arch/mips/configs/jaguar-atx_defconfig    |    1 -
  arch/mips/configs/jmr3927_defconfig       |    1 -
  arch/mips/configs/lasat200_defconfig      |    1 -
  arch/mips/configs/malta_defconfig         |    1 -
  arch/mips/configs/mpc30x_defconfig        |    1 -
  arch/mips/configs/ocelot_3_defconfig      |    1 -
  arch/mips/configs/ocelot_c_defconfig      |    1 -
  arch/mips/configs/ocelot_defconfig        |    1 -
  arch/mips/configs/ocelot_g_defconfig      |    1 -
  arch/mips/configs/pb1100_defconfig        |    1 -
  arch/mips/configs/pb1500_defconfig        |    1 -
  arch/mips/configs/pb1550_defconfig        |    1 -
  arch/mips/configs/qemu_defconfig          |    1 -
  arch/mips/configs/rm200_defconfig         |    1 -
  arch/mips/configs/sb1250-swarm_defconfig  |    1 -
  arch/mips/configs/sead_defconfig          |    1 -
  arch/mips/configs/tb0226_defconfig        |    1 -
  arch/mips/configs/tb0229_defconfig        |    1 -
  arch/mips/configs/tb0287_defconfig        |    1 -
  arch/mips/configs/workpad_defconfig       |    1 -
  arch/mips/configs/yosemite_defconfig      |    1 -
  arch/mips/defconfig                       |    1 -
  arch/parisc/configs/712_defconfig         |    1 -
  arch/parisc/configs/a500_defconfig        |    1 -
  arch/parisc/configs/b180_defconfig        |    1 -
  arch/parisc/configs/c3000_defconfig       |    1 -
  arch/parisc/defconfig                     |    1 -
  arch/ppc/configs/ads8272_defconfig        |    1 -
  arch/ppc/configs/bamboo_defconfig         |    1 -
  arch/ppc/configs/bubinga_defconfig        |    1 -
  arch/ppc/configs/chestnut_defconfig       |    1 -
  arch/ppc/configs/common_defconfig         |    1 -
  arch/ppc/configs/cpci405_defconfig        |    1 -
  arch/ppc/configs/cpci690_defconfig        |    1 -
  arch/ppc/configs/ebony_defconfig          |    1 -
  arch/ppc/configs/ep405_defconfig          |    1 -
  arch/ppc/configs/ev64260_defconfig        |    1 -
  arch/ppc/configs/ev64360_defconfig        |    1 -
  arch/ppc/configs/hdpu_defconfig           |    1 -
  arch/ppc/configs/ibmchrp_defconfig        |    1 -
  arch/ppc/configs/katana_defconfig         |    1 -
  arch/ppc/configs/lite5200_defconfig       |    1 -
  arch/ppc/configs/lopec_defconfig          |    1 -
  arch/ppc/configs/luan_defconfig           |    1 -
  arch/ppc/configs/mpc834x_sys_defconfig    |    1 -
  arch/ppc/configs/mpc8540_ads_defconfig    |    1 -
  arch/ppc/configs/mpc8548_cds_defconfig    |    1 -
  arch/ppc/configs/mpc8555_cds_defconfig    |    1 -
  arch/ppc/configs/mpc8560_ads_defconfig    |    1 -
  arch/ppc/configs/mpc86x_ads_defconfig     |    1 -
  arch/ppc/configs/mpc885ads_defconfig      |    1 -
  arch/ppc/configs/mvme5100_defconfig       |    1 -
  arch/ppc/configs/ocotea_defconfig         |    1 -
  arch/ppc/configs/pmac_defconfig           |    1 -
  arch/ppc/configs/power3_defconfig         |    1 -
  arch/ppc/configs/pplus_defconfig          |    1 -
  arch/ppc/configs/prpmc750_defconfig       |    1 -
  arch/ppc/configs/prpmc800_defconfig       |    1 -
  arch/ppc/configs/radstone_ppc7d_defconfig |    1 -
  arch/ppc/configs/redwood5_defconfig       |    1 -
  arch/ppc/configs/redwood6_defconfig       |    1 -
  arch/ppc/configs/rpx8260_defconfig        |    1 -
  arch/ppc/configs/rpxcllf_defconfig        |    1 -
  arch/ppc/configs/rpxlite_defconfig        |    1 -
  arch/ppc/configs/sandpoint_defconfig      |    1 -
  arch/ppc/configs/spruce_defconfig         |    1 -
  arch/ppc/configs/stx_gp3_defconfig        |    1 -
  arch/ppc/configs/sycamore_defconfig       |    1 -
  arch/ppc/configs/walnut_defconfig         |    1 -
  arch/ppc64/configs/bpa_defconfig          |    1 -
  arch/ppc64/configs/g5_defconfig           |    1 -
  arch/ppc64/configs/iSeries_defconfig      |    1 -
  arch/ppc64/configs/maple_defconfig        |    1 -
  arch/ppc64/configs/pSeries_defconfig      |    1 -
  arch/ppc64/defconfig                      |    1 -
  arch/s390/defconfig                       |    1 -
  arch/sh/configs/adx_defconfig             |    1 -
  arch/sh/configs/cqreek_defconfig          |    1 -
  arch/sh/configs/dreamcast_defconfig       |    1 -
  arch/sh/configs/hp680_defconfig           |    1 -
  arch/sh/configs/microdev_defconfig        |    1 -
  arch/sh/configs/rts7751r2d_defconfig      |    1 -
  arch/sh/configs/se7300_defconfig          |    1 -
  arch/sh/configs/se73180_defconfig         |    1 -
  arch/sh/configs/se7705_defconfig          |    1 -
  arch/sh/configs/se7750_defconfig          |    1 -
  arch/sh/configs/se7751_defconfig          |    1 -
  arch/sh/configs/sh03_defconfig            |    1 -
  arch/sh/configs/snapgear_defconfig        |    1 -
  arch/sh/configs/systemh_defconfig         |    1 -
  arch/sh64/configs/cayman_defconfig        |    1 -
  arch/sparc/defconfig                      |    1 -
  arch/sparc64/defconfig                    |    1 -
  arch/um/defconfig                         |    1 -
  arch/v850/configs/rte-ma1-cb_defconfig    |    1 -
  arch/v850/configs/rte-me2-cb_defconfig    |    1 -
  arch/v850/configs/sim_defconfig           |    1 -
  arch/x86_64/defconfig                     |    1 -
  arch/xtensa/configs/common_defconfig      |    1 -
  arch/xtensa/configs/iss_defconfig         |    1 -
  drivers/block/Kconfig.iosched             |   10 ----------
  drivers/block/Makefile                    |    3 +--
  200 files changed, 1 insertion(+), 210 deletions(-)


diff -urN a/arch/alpha/defconfig b/arch/alpha/defconfig
--- a/arch/alpha/defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/alpha/defconfig	2005-09-27 10:38:34.000000000 -0700
@@ -36,7 +36,6 @@
  # CONFIG_KALLSYMS_EXTRA_PASS is not set
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
--- a/arch/arm/configs/assabet_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/assabet_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -310,7 +310,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/badge4_defconfig b/arch/arm/configs/badge4_defconfig
--- a/arch/arm/configs/badge4_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/badge4_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -315,7 +315,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/bast_defconfig b/arch/arm/configs/bast_defconfig
--- a/arch/arm/configs/bast_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/bast_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -311,7 +311,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/cerfcube_defconfig b/arch/arm/configs/cerfcube_defconfig
--- a/arch/arm/configs/cerfcube_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/cerfcube_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -316,7 +316,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/clps7500_defconfig b/arch/arm/configs/clps7500_defconfig
--- a/arch/arm/configs/clps7500_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/clps7500_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -246,7 +246,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/ebsa110_defconfig b/arch/arm/configs/ebsa110_defconfig
--- a/arch/arm/configs/ebsa110_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/ebsa110_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -203,7 +203,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/edb7211_defconfig b/arch/arm/configs/edb7211_defconfig
--- a/arch/arm/configs/edb7211_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/edb7211_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -197,7 +197,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/enp2611_defconfig b/arch/arm/configs/enp2611_defconfig
--- a/arch/arm/configs/enp2611_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/arm/configs/enp2611_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -364,7 +364,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/ep80219_defconfig b/arch/arm/configs/ep80219_defconfig
--- a/arch/arm/configs/ep80219_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/ep80219_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -292,7 +292,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/epxa10db_defconfig b/arch/arm/configs/epxa10db_defconfig
--- a/arch/arm/configs/epxa10db_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/epxa10db_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -201,7 +201,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
--- a/arch/arm/configs/footbridge_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/footbridge_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -258,7 +258,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/fortunet_defconfig b/arch/arm/configs/fortunet_defconfig
--- a/arch/arm/configs/fortunet_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/fortunet_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -258,7 +258,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
--- a/arch/arm/configs/h3600_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/h3600_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -319,7 +319,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/h7201_defconfig b/arch/arm/configs/h7201_defconfig
--- a/arch/arm/configs/h7201_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/h7201_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -266,7 +266,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/h7202_defconfig b/arch/arm/configs/h7202_defconfig
--- a/arch/arm/configs/h7202_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/h7202_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -265,7 +265,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/hackkit_defconfig b/arch/arm/configs/hackkit_defconfig
--- a/arch/arm/configs/hackkit_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/hackkit_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -300,7 +300,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
--- a/arch/arm/configs/integrator_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/integrator_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -317,7 +317,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/iq31244_defconfig b/arch/arm/configs/iq31244_defconfig
--- a/arch/arm/configs/iq31244_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/iq31244_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -293,7 +293,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/iq80321_defconfig b/arch/arm/configs/iq80321_defconfig
--- a/arch/arm/configs/iq80321_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/iq80321_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -292,7 +292,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/iq80331_defconfig b/arch/arm/configs/iq80331_defconfig
--- a/arch/arm/configs/iq80331_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/iq80331_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -296,7 +296,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/iq80332_defconfig b/arch/arm/configs/iq80332_defconfig
--- a/arch/arm/configs/iq80332_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/iq80332_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -296,7 +296,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/ixdp2400_defconfig b/arch/arm/configs/ixdp2400_defconfig
--- a/arch/arm/configs/ixdp2400_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/arm/configs/ixdp2400_defconfig	2005-09-27 10:17:47.000000000 -0700
@@ -365,7 +365,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/ixdp2401_defconfig b/arch/arm/configs/ixdp2401_defconfig
--- a/arch/arm/configs/ixdp2401_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/arm/configs/ixdp2401_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -365,7 +365,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/ixdp2800_defconfig b/arch/arm/configs/ixdp2800_defconfig
--- a/arch/arm/configs/ixdp2800_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/arm/configs/ixdp2800_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -365,7 +365,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/ixdp2801_defconfig b/arch/arm/configs/ixdp2801_defconfig
--- a/arch/arm/configs/ixdp2801_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/arm/configs/ixdp2801_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -365,7 +365,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
--- a/arch/arm/configs/ixp4xx_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/ixp4xx_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -303,7 +303,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
--- a/arch/arm/configs/jornada720_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/jornada720_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -305,7 +305,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
--- a/arch/arm/configs/lart_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/lart_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -289,7 +289,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/lpd7a400_defconfig b/arch/arm/configs/lpd7a400_defconfig
--- a/arch/arm/configs/lpd7a400_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/lpd7a400_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -268,7 +268,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/lpd7a404_defconfig b/arch/arm/configs/lpd7a404_defconfig
--- a/arch/arm/configs/lpd7a404_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/lpd7a404_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -269,7 +269,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/lubbock_defconfig b/arch/arm/configs/lubbock_defconfig
--- a/arch/arm/configs/lubbock_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/lubbock_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -288,7 +288,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/lusl7200_defconfig b/arch/arm/configs/lusl7200_defconfig
--- a/arch/arm/configs/lusl7200_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/lusl7200_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -184,7 +184,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/mainstone_defconfig b/arch/arm/configs/mainstone_defconfig
--- a/arch/arm/configs/mainstone_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/mainstone_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -277,7 +277,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/mx1ads_defconfig b/arch/arm/configs/mx1ads_defconfig
--- a/arch/arm/configs/mx1ads_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/mx1ads_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -259,7 +259,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
--- a/arch/arm/configs/neponset_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/neponset_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -317,7 +317,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
--- a/arch/arm/configs/netwinder_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/netwinder_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -215,7 +215,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/omap_h2_1610_defconfig b/arch/arm/configs/omap_h2_1610_defconfig
--- a/arch/arm/configs/omap_h2_1610_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/arm/configs/omap_h2_1610_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -334,7 +334,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/pleb_defconfig b/arch/arm/configs/pleb_defconfig
--- a/arch/arm/configs/pleb_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/pleb_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -301,7 +301,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  # CONFIG_IOSCHED_CFQ is not set
diff -urN a/arch/arm/configs/pxa255-idp_defconfig b/arch/arm/configs/pxa255-idp_defconfig
--- a/arch/arm/configs/pxa255-idp_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/pxa255-idp_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -273,7 +273,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
--- a/arch/arm/configs/rpc_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/rpc_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -209,7 +209,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
--- a/arch/arm/configs/s3c2410_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/arm/configs/s3c2410_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -399,7 +399,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/shannon_defconfig b/arch/arm/configs/shannon_defconfig
--- a/arch/arm/configs/shannon_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/shannon_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -293,7 +293,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/shark_defconfig b/arch/arm/configs/shark_defconfig
--- a/arch/arm/configs/shark_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/shark_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -218,7 +218,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/simpad_defconfig b/arch/arm/configs/simpad_defconfig
--- a/arch/arm/configs/simpad_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/simpad_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -304,7 +304,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/smdk2410_defconfig b/arch/arm/configs/smdk2410_defconfig
--- a/arch/arm/configs/smdk2410_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/smdk2410_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -276,7 +276,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
--- a/arch/arm/configs/versatile_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/arm/configs/versatile_defconfig	2005-09-27 10:17:48.000000000 -0700
@@ -279,7 +279,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/cris/defconfig b/arch/cris/defconfig
--- a/arch/cris/defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/cris/defconfig	2005-09-27 10:39:14.000000000 -0700
@@ -288,7 +288,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/frv/defconfig b/arch/frv/defconfig
--- a/arch/frv/defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/frv/defconfig	2005-09-27 10:39:19.000000000 -0700
@@ -155,7 +155,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/h8300/defconfig b/arch/h8300/defconfig
--- a/arch/h8300/defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/h8300/defconfig	2005-09-27 10:38:28.000000000 -0700
@@ -166,7 +166,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  # CONFIG_IOSCHED_CFQ is not set
diff -urN a/arch/i386/defconfig b/arch/i386/defconfig
--- a/arch/i386/defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/i386/defconfig	2005-09-26 20:18:12.000000000 -0700
@@ -30,7 +30,6 @@
  CONFIG_KALLSYMS=y
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ia64/configs/bigsur_defconfig b/arch/ia64/configs/bigsur_defconfig
--- a/arch/ia64/configs/bigsur_defconfig	2005-09-26 19:17:59.000000000 -0700
+++ b/arch/ia64/configs/bigsur_defconfig	2005-09-27 10:18:05.000000000 -0700
@@ -290,7 +290,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ia64/configs/sim_defconfig b/arch/ia64/configs/sim_defconfig
--- a/arch/ia64/configs/sim_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ia64/configs/sim_defconfig	2005-09-27 10:18:05.000000000 -0700
@@ -29,7 +29,6 @@
  # CONFIG_KALLSYMS_ALL is not set
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ia64/configs/sn2_defconfig b/arch/ia64/configs/sn2_defconfig
--- a/arch/ia64/configs/sn2_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/ia64/configs/sn2_defconfig	2005-09-27 10:18:05.000000000 -0700
@@ -279,7 +279,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ia64/configs/tiger_defconfig b/arch/ia64/configs/tiger_defconfig
--- a/arch/ia64/configs/tiger_defconfig	2005-09-26 19:17:59.000000000 -0700
+++ b/arch/ia64/configs/tiger_defconfig	2005-09-27 10:18:05.000000000 -0700
@@ -299,7 +299,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ia64/configs/zx1_defconfig b/arch/ia64/configs/zx1_defconfig
--- a/arch/ia64/configs/zx1_defconfig	2005-09-26 19:17:59.000000000 -0700
+++ b/arch/ia64/configs/zx1_defconfig	2005-09-27 10:18:05.000000000 -0700
@@ -314,7 +314,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ia64/defconfig b/arch/ia64/defconfig
--- a/arch/ia64/defconfig	2005-09-26 19:17:59.000000000 -0700
+++ b/arch/ia64/defconfig	2005-09-27 10:39:02.000000000 -0700
@@ -303,7 +303,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m32r/defconfig b/arch/m32r/defconfig
--- a/arch/m32r/defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m32r/defconfig	2005-09-27 10:39:08.000000000 -0700
@@ -167,7 +167,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m32r/m32700ut/defconfig.m32700ut.smp b/arch/m32r/m32700ut/defconfig.m32700ut.smp
--- a/arch/m32r/m32700ut/defconfig.m32700ut.smp	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m32r/m32700ut/defconfig.m32700ut.smp	2005-09-27 10:36:33.000000000 -0700
@@ -171,7 +171,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m32r/m32700ut/defconfig.m32700ut.up b/arch/m32r/m32700ut/defconfig.m32700ut.up
--- a/arch/m32r/m32700ut/defconfig.m32700ut.up	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m32r/m32700ut/defconfig.m32700ut.up	2005-09-27 10:36:33.000000000 -0700
@@ -167,7 +167,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m32r/mappi/defconfig.nommu b/arch/m32r/mappi/defconfig.nommu
--- a/arch/m32r/mappi/defconfig.nommu	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m32r/mappi/defconfig.nommu	2005-09-27 10:35:55.000000000 -0700
@@ -164,7 +164,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m32r/mappi/defconfig.smp b/arch/m32r/mappi/defconfig.smp
--- a/arch/m32r/mappi/defconfig.smp	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m32r/mappi/defconfig.smp	2005-09-27 10:35:55.000000000 -0700
@@ -235,7 +235,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m32r/mappi/defconfig.up b/arch/m32r/mappi/defconfig.up
--- a/arch/m32r/mappi/defconfig.up	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m32r/mappi/defconfig.up	2005-09-27 10:35:55.000000000 -0700
@@ -230,7 +230,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m32r/mappi2/defconfig.vdec2 b/arch/m32r/mappi2/defconfig.vdec2
--- a/arch/m32r/mappi2/defconfig.vdec2	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m32r/mappi2/defconfig.vdec2	2005-09-27 10:36:00.000000000 -0700
@@ -163,7 +163,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m32r/mappi3/defconfig.smp b/arch/m32r/mappi3/defconfig.smp
--- a/arch/m32r/mappi3/defconfig.smp	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m32r/mappi3/defconfig.smp	2005-09-27 10:36:05.000000000 -0700
@@ -236,7 +236,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m32r/oaks32r/defconfig.nommu b/arch/m32r/oaks32r/defconfig.nommu
--- a/arch/m32r/oaks32r/defconfig.nommu	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m32r/oaks32r/defconfig.nommu	2005-09-27 10:36:13.000000000 -0700
@@ -151,7 +151,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m32r/opsput/defconfig.opsput b/arch/m32r/opsput/defconfig.opsput
--- a/arch/m32r/opsput/defconfig.opsput	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m32r/opsput/defconfig.opsput	2005-09-27 10:36:22.000000000 -0700
@@ -165,7 +165,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
--- a/arch/m68k/configs/amiga_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m68k/configs/amiga_defconfig	2005-09-27 10:23:17.000000000 -0700
@@ -154,7 +154,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
--- a/arch/m68k/configs/apollo_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m68k/configs/apollo_defconfig	2005-09-27 10:23:17.000000000 -0700
@@ -139,7 +139,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
--- a/arch/m68k/configs/atari_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m68k/configs/atari_defconfig	2005-09-27 10:23:17.000000000 -0700
@@ -147,7 +147,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
--- a/arch/m68k/configs/bvme6000_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m68k/configs/bvme6000_defconfig	2005-09-27 10:23:17.000000000 -0700
@@ -139,7 +139,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
--- a/arch/m68k/configs/hp300_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m68k/configs/hp300_defconfig	2005-09-27 10:23:17.000000000 -0700
@@ -140,7 +140,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
--- a/arch/m68k/configs/mac_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m68k/configs/mac_defconfig	2005-09-27 10:23:17.000000000 -0700
@@ -141,7 +141,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
--- a/arch/m68k/configs/mvme147_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m68k/configs/mvme147_defconfig	2005-09-27 10:23:17.000000000 -0700
@@ -139,7 +139,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
--- a/arch/m68k/configs/mvme16x_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m68k/configs/mvme16x_defconfig	2005-09-27 10:23:17.000000000 -0700
@@ -139,7 +139,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
--- a/arch/m68k/configs/q40_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m68k/configs/q40_defconfig	2005-09-27 10:23:17.000000000 -0700
@@ -143,7 +143,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
--- a/arch/m68k/configs/sun3_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m68k/configs/sun3_defconfig	2005-09-27 10:23:17.000000000 -0700
@@ -127,7 +127,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
--- a/arch/m68k/configs/sun3x_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m68k/configs/sun3x_defconfig	2005-09-27 10:23:17.000000000 -0700
@@ -138,7 +138,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m68k/defconfig b/arch/m68k/defconfig
--- a/arch/m68k/defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/m68k/defconfig	2005-09-27 10:38:56.000000000 -0700
@@ -132,7 +132,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/m68knommu/defconfig b/arch/m68knommu/defconfig
--- a/arch/m68knommu/defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/m68knommu/defconfig	2005-09-27 10:37:48.000000000 -0700
@@ -310,7 +310,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  # CONFIG_IOSCHED_CFQ is not set
diff -urN a/arch/mips/configs/atlas_defconfig b/arch/mips/configs/atlas_defconfig
--- a/arch/mips/configs/atlas_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/atlas_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -210,7 +210,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/capcella_defconfig b/arch/mips/configs/capcella_defconfig
--- a/arch/mips/configs/capcella_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/capcella_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -208,7 +208,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/cobalt_defconfig b/arch/mips/configs/cobalt_defconfig
--- a/arch/mips/configs/cobalt_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/cobalt_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -198,7 +198,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/db1000_defconfig b/arch/mips/configs/db1000_defconfig
--- a/arch/mips/configs/db1000_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/db1000_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -214,7 +214,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/db1100_defconfig b/arch/mips/configs/db1100_defconfig
--- a/arch/mips/configs/db1100_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/db1100_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -212,7 +212,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/db1500_defconfig b/arch/mips/configs/db1500_defconfig
--- a/arch/mips/configs/db1500_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/db1500_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -299,7 +299,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/db1550_defconfig b/arch/mips/configs/db1550_defconfig
--- a/arch/mips/configs/db1550_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/db1550_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -302,7 +302,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/ddb5476_defconfig b/arch/mips/configs/ddb5476_defconfig
--- a/arch/mips/configs/ddb5476_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/ddb5476_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -202,7 +202,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/ddb5477_defconfig b/arch/mips/configs/ddb5477_defconfig
--- a/arch/mips/configs/ddb5477_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/ddb5477_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -198,7 +198,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
--- a/arch/mips/configs/decstation_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/decstation_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -192,7 +192,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/e55_defconfig b/arch/mips/configs/e55_defconfig
--- a/arch/mips/configs/e55_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/e55_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -201,7 +201,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/ev64120_defconfig b/arch/mips/configs/ev64120_defconfig
--- a/arch/mips/configs/ev64120_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/ev64120_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -206,7 +206,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/ev96100_defconfig b/arch/mips/configs/ev96100_defconfig
--- a/arch/mips/configs/ev96100_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/ev96100_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -200,7 +200,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
--- a/arch/mips/configs/ip22_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/ip22_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -202,7 +202,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
--- a/arch/mips/configs/ip27_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/ip27_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -218,7 +218,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
--- a/arch/mips/configs/ip32_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/ip32_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -207,7 +207,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/it8172_defconfig b/arch/mips/configs/it8172_defconfig
--- a/arch/mips/configs/it8172_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/it8172_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -267,7 +267,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/ivr_defconfig b/arch/mips/configs/ivr_defconfig
--- a/arch/mips/configs/ivr_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/ivr_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -203,7 +203,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/jaguar-atx_defconfig b/arch/mips/configs/jaguar-atx_defconfig
--- a/arch/mips/configs/jaguar-atx_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/jaguar-atx_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -204,7 +204,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
--- a/arch/mips/configs/jmr3927_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/jmr3927_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -196,7 +196,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/lasat200_defconfig b/arch/mips/configs/lasat200_defconfig
--- a/arch/mips/configs/lasat200_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/lasat200_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -278,7 +278,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
--- a/arch/mips/configs/malta_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/malta_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -212,7 +212,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/mpc30x_defconfig b/arch/mips/configs/mpc30x_defconfig
--- a/arch/mips/configs/mpc30x_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/mpc30x_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -208,7 +208,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/ocelot_3_defconfig b/arch/mips/configs/ocelot_3_defconfig
--- a/arch/mips/configs/ocelot_3_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/ocelot_3_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -212,7 +212,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/ocelot_c_defconfig b/arch/mips/configs/ocelot_c_defconfig
--- a/arch/mips/configs/ocelot_c_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/ocelot_c_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -202,7 +202,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/ocelot_defconfig b/arch/mips/configs/ocelot_defconfig
--- a/arch/mips/configs/ocelot_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/ocelot_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -197,7 +197,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/ocelot_g_defconfig b/arch/mips/configs/ocelot_g_defconfig
--- a/arch/mips/configs/ocelot_g_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/ocelot_g_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -205,7 +205,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/pb1100_defconfig b/arch/mips/configs/pb1100_defconfig
--- a/arch/mips/configs/pb1100_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/pb1100_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -286,7 +286,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/pb1500_defconfig b/arch/mips/configs/pb1500_defconfig
--- a/arch/mips/configs/pb1500_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/pb1500_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -227,7 +227,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/pb1550_defconfig b/arch/mips/configs/pb1550_defconfig
--- a/arch/mips/configs/pb1550_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/pb1550_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -227,7 +227,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/qemu_defconfig b/arch/mips/configs/qemu_defconfig
--- a/arch/mips/configs/qemu_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/qemu_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -277,7 +277,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  # CONFIG_IOSCHED_CFQ is not set
diff -urN a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
--- a/arch/mips/configs/rm200_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/rm200_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -258,7 +258,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/sb1250-swarm_defconfig b/arch/mips/configs/sb1250-swarm_defconfig
--- a/arch/mips/configs/sb1250-swarm_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/sb1250-swarm_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -235,7 +235,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/sead_defconfig b/arch/mips/configs/sead_defconfig
--- a/arch/mips/configs/sead_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/sead_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -187,7 +187,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/tb0226_defconfig b/arch/mips/configs/tb0226_defconfig
--- a/arch/mips/configs/tb0226_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/tb0226_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -200,7 +200,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/tb0229_defconfig b/arch/mips/configs/tb0229_defconfig
--- a/arch/mips/configs/tb0229_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/tb0229_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -212,7 +212,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/tb0287_defconfig b/arch/mips/configs/tb0287_defconfig
--- a/arch/mips/configs/tb0287_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/tb0287_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -317,7 +317,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
--- a/arch/mips/configs/workpad_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/workpad_defconfig	2005-09-27 10:17:58.000000000 -0700
@@ -201,7 +201,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/configs/yosemite_defconfig b/arch/mips/configs/yosemite_defconfig
--- a/arch/mips/configs/yosemite_defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/configs/yosemite_defconfig	2005-09-27 10:17:59.000000000 -0700
@@ -202,7 +202,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/mips/defconfig b/arch/mips/defconfig
--- a/arch/mips/defconfig	2005-09-26 19:17:42.000000000 -0700
+++ b/arch/mips/defconfig	2005-09-27 10:38:49.000000000 -0700
@@ -202,7 +202,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/parisc/configs/712_defconfig b/arch/parisc/configs/712_defconfig
--- a/arch/parisc/configs/712_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/parisc/configs/712_defconfig	2005-09-27 10:32:50.000000000 -0700
@@ -154,7 +154,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/parisc/configs/a500_defconfig b/arch/parisc/configs/a500_defconfig
--- a/arch/parisc/configs/a500_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/parisc/configs/a500_defconfig	2005-09-27 10:32:50.000000000 -0700
@@ -175,7 +175,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/parisc/configs/b180_defconfig b/arch/parisc/configs/b180_defconfig
--- a/arch/parisc/configs/b180_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/parisc/configs/b180_defconfig	2005-09-27 10:32:50.000000000 -0700
@@ -145,7 +145,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/parisc/configs/c3000_defconfig b/arch/parisc/configs/c3000_defconfig
--- a/arch/parisc/configs/c3000_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/parisc/configs/c3000_defconfig	2005-09-27 10:32:50.000000000 -0700
@@ -154,7 +154,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/parisc/defconfig b/arch/parisc/defconfig
--- a/arch/parisc/defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/parisc/defconfig	2005-09-27 10:38:03.000000000 -0700
@@ -29,7 +29,6 @@
  CONFIG_KALLSYMS=y
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
diff -urN a/arch/ppc/configs/ads8272_defconfig b/arch/ppc/configs/ads8272_defconfig
--- a/arch/ppc/configs/ads8272_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/ads8272_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -32,7 +32,6 @@
  # CONFIG_KALLSYMS is not set
  CONFIG_FUTEX=y
  # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/bamboo_defconfig b/arch/ppc/configs/bamboo_defconfig
--- a/arch/ppc/configs/bamboo_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/bamboo_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -197,7 +197,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/bubinga_defconfig b/arch/ppc/configs/bubinga_defconfig
--- a/arch/ppc/configs/bubinga_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/bubinga_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -30,7 +30,6 @@
  # CONFIG_KALLSYMS is not set
  CONFIG_FUTEX=y
  # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
diff -urN a/arch/ppc/configs/chestnut_defconfig b/arch/ppc/configs/chestnut_defconfig
--- a/arch/ppc/configs/chestnut_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/chestnut_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -285,7 +285,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/common_defconfig b/arch/ppc/configs/common_defconfig
--- a/arch/ppc/configs/common_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/common_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -402,7 +402,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/cpci405_defconfig b/arch/ppc/configs/cpci405_defconfig
--- a/arch/ppc/configs/cpci405_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/cpci405_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -30,7 +30,6 @@
  # CONFIG_KALLSYMS is not set
  CONFIG_FUTEX=y
  # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
diff -urN a/arch/ppc/configs/cpci690_defconfig b/arch/ppc/configs/cpci690_defconfig
--- a/arch/ppc/configs/cpci690_defconfig	2005-09-26 19:17:43.000000000 -0700
+++ b/arch/ppc/configs/cpci690_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -297,7 +297,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/ebony_defconfig b/arch/ppc/configs/ebony_defconfig
--- a/arch/ppc/configs/ebony_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/ebony_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -33,7 +33,6 @@
  # CONFIG_KALLSYMS_ALL is not set
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/ep405_defconfig b/arch/ppc/configs/ep405_defconfig
--- a/arch/ppc/configs/ep405_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/ep405_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -32,7 +32,6 @@
  CONFIG_KALLSYMS=y
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/ev64260_defconfig b/arch/ppc/configs/ev64260_defconfig
--- a/arch/ppc/configs/ev64260_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/ev64260_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -188,7 +188,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/ev64360_defconfig b/arch/ppc/configs/ev64360_defconfig
--- a/arch/ppc/configs/ev64360_defconfig	2005-09-26 19:17:43.000000000 -0700
+++ b/arch/ppc/configs/ev64360_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -365,7 +365,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/hdpu_defconfig b/arch/ppc/configs/hdpu_defconfig
--- a/arch/ppc/configs/hdpu_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/hdpu_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -278,7 +278,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/ibmchrp_defconfig b/arch/ppc/configs/ibmchrp_defconfig
--- a/arch/ppc/configs/ibmchrp_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/ibmchrp_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -33,7 +33,6 @@
  CONFIG_KALLSYMS=y
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/katana_defconfig b/arch/ppc/configs/katana_defconfig
--- a/arch/ppc/configs/katana_defconfig	2005-09-26 19:17:43.000000000 -0700
+++ b/arch/ppc/configs/katana_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -378,7 +378,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/lite5200_defconfig b/arch/ppc/configs/lite5200_defconfig
--- a/arch/ppc/configs/lite5200_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/lite5200_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -31,7 +31,6 @@
  # CONFIG_KALLSYMS_EXTRA_PASS is not set
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/lopec_defconfig b/arch/ppc/configs/lopec_defconfig
--- a/arch/ppc/configs/lopec_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/lopec_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -32,7 +32,6 @@
  CONFIG_KALLSYMS=y
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/luan_defconfig b/arch/ppc/configs/luan_defconfig
--- a/arch/ppc/configs/luan_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/luan_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -182,7 +182,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/mpc834x_sys_defconfig b/arch/ppc/configs/mpc834x_sys_defconfig
--- a/arch/ppc/configs/mpc834x_sys_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/mpc834x_sys_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -155,7 +155,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/mpc8540_ads_defconfig b/arch/ppc/configs/mpc8540_ads_defconfig
--- a/arch/ppc/configs/mpc8540_ads_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/mpc8540_ads_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -168,7 +168,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/mpc8548_cds_defconfig b/arch/ppc/configs/mpc8548_cds_defconfig
--- a/arch/ppc/configs/mpc8548_cds_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/mpc8548_cds_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -166,7 +166,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/mpc8555_cds_defconfig b/arch/ppc/configs/mpc8555_cds_defconfig
--- a/arch/ppc/configs/mpc8555_cds_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/mpc8555_cds_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -176,7 +176,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/mpc8560_ads_defconfig b/arch/ppc/configs/mpc8560_ads_defconfig
--- a/arch/ppc/configs/mpc8560_ads_defconfig	2005-09-26 19:17:43.000000000 -0700
+++ b/arch/ppc/configs/mpc8560_ads_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -253,7 +253,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/mpc86x_ads_defconfig b/arch/ppc/configs/mpc86x_ads_defconfig
--- a/arch/ppc/configs/mpc86x_ads_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/mpc86x_ads_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -181,7 +181,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/mpc885ads_defconfig b/arch/ppc/configs/mpc885ads_defconfig
--- a/arch/ppc/configs/mpc885ads_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/mpc885ads_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -174,7 +174,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  # CONFIG_IOSCHED_CFQ is not set
diff -urN a/arch/ppc/configs/mvme5100_defconfig b/arch/ppc/configs/mvme5100_defconfig
--- a/arch/ppc/configs/mvme5100_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/mvme5100_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -36,7 +36,6 @@
  # CONFIG_KALLSYMS_EXTRA_PASS is not set
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/ocotea_defconfig b/arch/ppc/configs/ocotea_defconfig
--- a/arch/ppc/configs/ocotea_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/ocotea_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -33,7 +33,6 @@
  # CONFIG_KALLSYMS_ALL is not set
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/pmac_defconfig b/arch/ppc/configs/pmac_defconfig
--- a/arch/ppc/configs/pmac_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/pmac_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -448,7 +448,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/power3_defconfig b/arch/ppc/configs/power3_defconfig
--- a/arch/ppc/configs/power3_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/power3_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -32,7 +32,6 @@
  CONFIG_KALLSYMS=y
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/pplus_defconfig b/arch/ppc/configs/pplus_defconfig
--- a/arch/ppc/configs/pplus_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/pplus_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -30,7 +30,6 @@
  CONFIG_KALLSYMS=y
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
diff -urN a/arch/ppc/configs/prpmc750_defconfig b/arch/ppc/configs/prpmc750_defconfig
--- a/arch/ppc/configs/prpmc750_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/prpmc750_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -32,7 +32,6 @@
  # CONFIG_KALLSYMS is not set
  CONFIG_FUTEX=y
  # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/prpmc800_defconfig b/arch/ppc/configs/prpmc800_defconfig
--- a/arch/ppc/configs/prpmc800_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/prpmc800_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -32,7 +32,6 @@
  # CONFIG_KALLSYMS is not set
  CONFIG_FUTEX=y
  # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/radstone_ppc7d_defconfig b/arch/ppc/configs/radstone_ppc7d_defconfig
--- a/arch/ppc/configs/radstone_ppc7d_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/radstone_ppc7d_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -349,7 +349,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/redwood5_defconfig b/arch/ppc/configs/redwood5_defconfig
--- a/arch/ppc/configs/redwood5_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/redwood5_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -30,7 +30,6 @@
  # CONFIG_KALLSYMS is not set
  CONFIG_FUTEX=y
  # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
diff -urN a/arch/ppc/configs/redwood6_defconfig b/arch/ppc/configs/redwood6_defconfig
--- a/arch/ppc/configs/redwood6_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/redwood6_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -30,7 +30,6 @@
  # CONFIG_KALLSYMS is not set
  CONFIG_FUTEX=y
  # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
diff -urN a/arch/ppc/configs/rpx8260_defconfig b/arch/ppc/configs/rpx8260_defconfig
--- a/arch/ppc/configs/rpx8260_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/rpx8260_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -32,7 +32,6 @@
  # CONFIG_KALLSYMS is not set
  CONFIG_FUTEX=y
  # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/rpxcllf_defconfig b/arch/ppc/configs/rpxcllf_defconfig
--- a/arch/ppc/configs/rpxcllf_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/rpxcllf_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -160,7 +160,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/rpxlite_defconfig b/arch/ppc/configs/rpxlite_defconfig
--- a/arch/ppc/configs/rpxlite_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/rpxlite_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -160,7 +160,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/sandpoint_defconfig b/arch/ppc/configs/sandpoint_defconfig
--- a/arch/ppc/configs/sandpoint_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/sandpoint_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -32,7 +32,6 @@
  CONFIG_KALLSYMS=y
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/spruce_defconfig b/arch/ppc/configs/spruce_defconfig
--- a/arch/ppc/configs/spruce_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/spruce_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -32,7 +32,6 @@
  CONFIG_KALLSYMS=y
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/stx_gp3_defconfig b/arch/ppc/configs/stx_gp3_defconfig
--- a/arch/ppc/configs/stx_gp3_defconfig	2005-09-26 19:17:59.000000000 -0700
+++ b/arch/ppc/configs/stx_gp3_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -191,7 +191,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc/configs/sycamore_defconfig b/arch/ppc/configs/sycamore_defconfig
--- a/arch/ppc/configs/sycamore_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/sycamore_defconfig	2005-09-27 10:18:11.000000000 -0700
@@ -30,7 +30,6 @@
  # CONFIG_KALLSYMS is not set
  CONFIG_FUTEX=y
  # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
diff -urN a/arch/ppc/configs/walnut_defconfig b/arch/ppc/configs/walnut_defconfig
--- a/arch/ppc/configs/walnut_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc/configs/walnut_defconfig	2005-09-27 10:18:12.000000000 -0700
@@ -32,7 +32,6 @@
  # CONFIG_KALLSYMS is not set
  CONFIG_FUTEX=y
  # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc64/configs/bpa_defconfig b/arch/ppc64/configs/bpa_defconfig
--- a/arch/ppc64/configs/bpa_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/ppc64/configs/bpa_defconfig	2005-09-27 10:18:14.000000000 -0700
@@ -328,7 +328,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc64/configs/g5_defconfig b/arch/ppc64/configs/g5_defconfig
--- a/arch/ppc64/configs/g5_defconfig	2005-09-26 19:17:43.000000000 -0700
+++ b/arch/ppc64/configs/g5_defconfig	2005-09-27 10:18:14.000000000 -0700
@@ -323,7 +323,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc64/configs/iSeries_defconfig b/arch/ppc64/configs/iSeries_defconfig
--- a/arch/ppc64/configs/iSeries_defconfig	2005-09-26 19:17:43.000000000 -0700
+++ b/arch/ppc64/configs/iSeries_defconfig	2005-09-27 10:18:14.000000000 -0700
@@ -309,7 +309,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc64/configs/maple_defconfig b/arch/ppc64/configs/maple_defconfig
--- a/arch/ppc64/configs/maple_defconfig	2005-09-26 19:17:43.000000000 -0700
+++ b/arch/ppc64/configs/maple_defconfig	2005-09-27 10:18:14.000000000 -0700
@@ -246,7 +246,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc64/configs/pSeries_defconfig b/arch/ppc64/configs/pSeries_defconfig
--- a/arch/ppc64/configs/pSeries_defconfig	2005-09-26 19:17:43.000000000 -0700
+++ b/arch/ppc64/configs/pSeries_defconfig	2005-09-27 10:18:14.000000000 -0700
@@ -348,7 +348,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/ppc64/defconfig b/arch/ppc64/defconfig
--- a/arch/ppc64/defconfig	2005-09-26 19:17:43.000000000 -0700
+++ b/arch/ppc64/defconfig	2005-09-27 10:38:22.000000000 -0700
@@ -350,7 +350,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/s390/defconfig b/arch/s390/defconfig
--- a/arch/s390/defconfig	2005-09-26 19:17:43.000000000 -0700
+++ b/arch/s390/defconfig	2005-09-27 10:38:41.000000000 -0700
@@ -310,7 +310,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sh/configs/adx_defconfig b/arch/sh/configs/adx_defconfig
--- a/arch/sh/configs/adx_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/adx_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -204,7 +204,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sh/configs/cqreek_defconfig b/arch/sh/configs/cqreek_defconfig
--- a/arch/sh/configs/cqreek_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/cqreek_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -199,7 +199,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sh/configs/dreamcast_defconfig b/arch/sh/configs/dreamcast_defconfig
--- a/arch/sh/configs/dreamcast_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/dreamcast_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -237,7 +237,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sh/configs/hp680_defconfig b/arch/sh/configs/hp680_defconfig
--- a/arch/sh/configs/hp680_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/hp680_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -206,7 +206,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sh/configs/microdev_defconfig b/arch/sh/configs/microdev_defconfig
--- a/arch/sh/configs/microdev_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/microdev_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -213,7 +213,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sh/configs/rts7751r2d_defconfig b/arch/sh/configs/rts7751r2d_defconfig
--- a/arch/sh/configs/rts7751r2d_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/rts7751r2d_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -224,7 +224,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sh/configs/se7300_defconfig b/arch/sh/configs/se7300_defconfig
--- a/arch/sh/configs/se7300_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/se7300_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -200,7 +200,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  # CONFIG_IOSCHED_CFQ is not set
diff -urN a/arch/sh/configs/se73180_defconfig b/arch/sh/configs/se73180_defconfig
--- a/arch/sh/configs/se73180_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/se73180_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -206,7 +206,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  # CONFIG_IOSCHED_CFQ is not set
diff -urN a/arch/sh/configs/se7705_defconfig b/arch/sh/configs/se7705_defconfig
--- a/arch/sh/configs/se7705_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/se7705_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -282,7 +282,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  # CONFIG_IOSCHED_DEADLINE is not set
  # CONFIG_IOSCHED_CFQ is not set
diff -urN a/arch/sh/configs/se7750_defconfig b/arch/sh/configs/se7750_defconfig
--- a/arch/sh/configs/se7750_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/se7750_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -280,7 +280,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sh/configs/se7751_defconfig b/arch/sh/configs/se7751_defconfig
--- a/arch/sh/configs/se7751_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/se7751_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -293,7 +293,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
--- a/arch/sh/configs/sh03_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/sh03_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -233,7 +233,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sh/configs/snapgear_defconfig b/arch/sh/configs/snapgear_defconfig
--- a/arch/sh/configs/snapgear_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/snapgear_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -216,7 +216,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sh/configs/systemh_defconfig b/arch/sh/configs/systemh_defconfig
--- a/arch/sh/configs/systemh_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh/configs/systemh_defconfig	2005-09-27 10:22:48.000000000 -0700
@@ -218,7 +218,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sh64/configs/cayman_defconfig b/arch/sh64/configs/cayman_defconfig
--- a/arch/sh64/configs/cayman_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sh64/configs/cayman_defconfig	2005-09-27 10:35:40.000000000 -0700
@@ -184,7 +184,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sparc/defconfig b/arch/sparc/defconfig
--- a/arch/sparc/defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sparc/defconfig	2005-09-27 10:38:11.000000000 -0700
@@ -31,7 +31,6 @@
  # CONFIG_KALLSYMS_ALL is not set
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/sparc64/defconfig b/arch/sparc64/defconfig
--- a/arch/sparc64/defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/sparc64/defconfig	2005-09-27 10:38:14.000000000 -0700
@@ -246,7 +246,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/um/defconfig b/arch/um/defconfig
--- a/arch/um/defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/um/defconfig	2005-09-27 10:39:23.000000000 -0700
@@ -146,7 +146,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/v850/configs/rte-ma1-cb_defconfig b/arch/v850/configs/rte-ma1-cb_defconfig
--- a/arch/v850/configs/rte-ma1-cb_defconfig	2005-09-26 19:17:43.000000000 -0700
+++ b/arch/v850/configs/rte-ma1-cb_defconfig	2005-09-27 10:35:32.000000000 -0700
@@ -253,7 +253,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  # CONFIG_IOSCHED_CFQ is not set
diff -urN a/arch/v850/configs/rte-me2-cb_defconfig b/arch/v850/configs/rte-me2-cb_defconfig
--- a/arch/v850/configs/rte-me2-cb_defconfig	2005-09-26 19:17:43.000000000 -0700
+++ b/arch/v850/configs/rte-me2-cb_defconfig	2005-09-27 10:35:32.000000000 -0700
@@ -198,7 +198,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  # CONFIG_IOSCHED_CFQ is not set
diff -urN a/arch/v850/configs/sim_defconfig b/arch/v850/configs/sim_defconfig
--- a/arch/v850/configs/sim_defconfig	2005-09-26 19:17:43.000000000 -0700
+++ b/arch/v850/configs/sim_defconfig	2005-09-27 10:35:32.000000000 -0700
@@ -193,7 +193,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  # CONFIG_IOSCHED_CFQ is not set
diff -urN a/arch/x86_64/defconfig b/arch/x86_64/defconfig
--- a/arch/x86_64/defconfig	2005-09-26 19:17:59.000000000 -0700
+++ b/arch/x86_64/defconfig	2005-09-27 10:37:55.000000000 -0700
@@ -354,7 +354,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/xtensa/configs/common_defconfig b/arch/xtensa/configs/common_defconfig
--- a/arch/xtensa/configs/common_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/xtensa/configs/common_defconfig	2005-09-27 10:34:13.000000000 -0700
@@ -154,7 +154,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  CONFIG_IOSCHED_AS=y
  CONFIG_IOSCHED_DEADLINE=y
  CONFIG_IOSCHED_CFQ=y
diff -urN a/arch/xtensa/configs/iss_defconfig b/arch/xtensa/configs/iss_defconfig
--- a/arch/xtensa/configs/iss_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ b/arch/xtensa/configs/iss_defconfig	2005-09-27 10:34:13.000000000 -0700
@@ -143,7 +143,6 @@
  #
  # IO Schedulers
  #
-CONFIG_IOSCHED_NOOP=y
  # CONFIG_IOSCHED_AS is not set
  # CONFIG_IOSCHED_DEADLINE is not set
  # CONFIG_IOSCHED_CFQ is not set
diff -urN a/drivers/block/Kconfig.iosched b/drivers/block/Kconfig.iosched
--- a/drivers/block/Kconfig.iosched	2005-08-28 16:41:01.000000000 -0700
+++ b/drivers/block/Kconfig.iosched	2005-09-26 20:14:06.000000000 -0700
@@ -1,16 +1,6 @@

  menu "IO Schedulers"

-config IOSCHED_NOOP
-	bool
-	default y
-	---help---
-	  The no-op I/O scheduler is a minimal scheduler that does basic merging
-	  and sorting. Its main uses include non-disk based block devices like
-	  memory devices, and specialised software or hardware environments
-	  that do their own scheduling and require only minimal assistance from
-	  the kernel.
-
  config IOSCHED_AS
  	tristate "Anticipatory I/O scheduler"
  	default y
diff -urN a/drivers/block/Makefile b/drivers/block/Makefile
--- a/drivers/block/Makefile	2005-08-28 16:41:01.000000000 -0700
+++ b/drivers/block/Makefile	2005-09-26 20:15:58.000000000 -0700
@@ -13,9 +13,8 @@
  # kblockd threads
  #

-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
+obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o noop-iosched.o

-obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
  obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
  obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o
  obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o
