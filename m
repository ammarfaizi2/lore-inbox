Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSJRAhn>; Thu, 17 Oct 2002 20:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262397AbSJRAhn>; Thu, 17 Oct 2002 20:37:43 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:54667 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262360AbSJRAhl>; Thu, 17 Oct 2002 20:37:41 -0400
Message-Id: <5.1.0.14.2.20021017172739.05568260@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 17 Oct 2002 17:38:01 -0700
To: Linus Torvalds <torvalds@transmeta.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: [BK] Minor 2.5.x Bluetooth related fixes
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Here is some more Bluetooth updates. Diffstat looks kinda long but it's actually
just bunch of oneliners that fix arch specific default config files. 

Please pull from
        bk://linux-bt.bkbits.net/bt-2.5

This will update the following files:

 net/bluetooth/bnep/crc32.c                        |   59 ----------------------
 net/bluetooth/bnep/crc32.h                        |   10 ---
 arch/alpha/defconfig                              |    2 
 arch/arm/def-configs/adi_evb                      |    2 
 arch/arm/def-configs/adsbitsy                     |    2 
 arch/arm/def-configs/anakin                       |    2 
 arch/arm/def-configs/assabet                      |    2 
 arch/arm/def-configs/badge4                       |   10 +--
 arch/arm/def-configs/cerfcube                     |    2 
 arch/arm/def-configs/cerfpda                      |   10 +--
 arch/arm/def-configs/cerfpod                      |    2 
 arch/arm/def-configs/epxa10db                     |    2 
 arch/arm/def-configs/flexanet                     |    2 
 arch/arm/def-configs/fortunet                     |    2 
 arch/arm/def-configs/graphicsclient               |    2 
 arch/arm/def-configs/graphicsmaster               |    2 
 arch/arm/def-configs/h3600                        |    2 
 arch/arm/def-configs/iq80310                      |    2 
 arch/arm/def-configs/jornada720                   |    2 
 arch/arm/def-configs/lart                         |    2 
 arch/arm/def-configs/lubbock                      |    2 
 arch/arm/def-configs/neponset                     |    2 
 arch/arm/def-configs/pangolin                     |    2 
 arch/arm/def-configs/pleb                         |    2 
 arch/arm/def-configs/shannon                      |    2 
 arch/arm/def-configs/shark                        |    2 
 arch/arm/def-configs/stork                        |    2 
 arch/arm/def-configs/system3                      |    2 
 arch/i386/defconfig                               |    2 
 arch/ia64/defconfig                               |    2 
 arch/ia64/sn/configs/sn1/defconfig-bigsur-mp      |    2 
 arch/ia64/sn/configs/sn1/defconfig-bigsur-sp      |    2 
 arch/ia64/sn/configs/sn1/defconfig-sn1-mp         |    2 
 arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules |    2 
 arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0  |    2 
 arch/ia64/sn/configs/sn1/defconfig-sn1-sp         |    2 
 arch/ia64/sn/configs/sn2/defconfig-sn2-mp         |    2 
 arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules |    2 
 arch/ia64/sn/configs/sn2/defconfig-sn2-sp         |    2 
 arch/ppc/configs/FADS_defconfig                   |    2 
 arch/ppc/configs/IVMS8_defconfig                  |    2 
 arch/ppc/configs/SM850_defconfig                  |    2 
 arch/ppc/configs/SPD823TS_defconfig               |    2 
 arch/ppc/configs/TQM823L_defconfig                |    2 
 arch/ppc/configs/TQM850L_defconfig                |    2 
 arch/ppc/configs/TQM860L_defconfig                |    2 
 arch/ppc/configs/adir_defconfig                   |    2 
 arch/ppc/configs/apus_defconfig                   |    2 
 arch/ppc/configs/ash_defconfig                    |    2 
 arch/ppc/configs/bseip_defconfig                  |    2 
 arch/ppc/configs/cedar_defconfig                  |    2 
 arch/ppc/configs/common_defconfig                 |    2 
 arch/ppc/configs/cpci405_defconfig                |    2 
 arch/ppc/configs/ep405_defconfig                  |    2 
 arch/ppc/configs/est8260_defconfig                |    2 
 arch/ppc/configs/ev64260_defconfig                |    2 
 arch/ppc/configs/gemini_defconfig                 |    2 
 arch/ppc/configs/iSeries_defconfig                |    2 
 arch/ppc/configs/ibmchrp_defconfig                |    2 
 arch/ppc/configs/k2_defconfig                     |    2 
 arch/ppc/configs/lopec_defconfig                  |    2 
 arch/ppc/configs/mbx_defconfig                    |    2 
 arch/ppc/configs/mcpn765_defconfig                |    2 
 arch/ppc/configs/menf1_defconfig                  |    2 
 arch/ppc/configs/oak_defconfig                    |    2 
 arch/ppc/configs/pmac_defconfig                   |    2 
 arch/ppc/configs/power3_defconfig                 |    2 
 arch/ppc/configs/pplus_defconfig                  |    2 
 arch/ppc/configs/prpmc750_defconfig               |    2 
 arch/ppc/configs/prpmc800_defconfig               |    2 
 arch/ppc/configs/redwood5_defconfig               |    2 
 arch/ppc/configs/redwood_defconfig                |    2 
 arch/ppc/configs/rpxcllf_defconfig                |    2 
 arch/ppc/configs/rpxlite_defconfig                |    2 
 arch/ppc/configs/sandpoint_defconfig              |    2 
 arch/ppc/configs/spruce_defconfig                 |    2 
 arch/ppc/configs/walnut_defconfig                 |    2 
 arch/ppc/configs/zx4500_defconfig                 |    2 
 arch/ppc/defconfig                                |    2 
 arch/ppc64/defconfig                              |    2 
 arch/sparc/defconfig                              |    2 
 arch/sparc64/defconfig                            |   34 ++++++------
 arch/x86_64/defconfig                             |    2 
 drivers/bluetooth/Makefile                        |    2 
 lib/Makefile                                      |    1 
 net/bluetooth/Config.in                           |    8 +-
 net/bluetooth/Makefile                            |    4 -
 net/bluetooth/bnep/Makefile                       |    2 
 net/bluetooth/bnep/Makefile.lib                   |    1 
 net/bluetooth/bnep/bnep.h                         |    5 -
 net/bluetooth/bnep/core.c                         |    4 -
 91 files changed, 117 insertions(+), 189 deletions(-)

through these ChangeSets:

<marcel@holtmann.org> (02/10/17 1.791.1.1)
   Use kernel crc32 for BlueZ BNEP
   
   This patch modifies the BlueZ BNEP layer to use the CRC32 code from
   the lib/ directory.

<maxk@qualcomm.com> (02/10/16 1.792)
   Fix files that escaped CONFIG_BLUEZ_XXX -> CONFIG_BT_XXX cleanup.
   Mostly arch specific default configs.


Max

http://bluez.sf.net
http://vtun.sf.net

