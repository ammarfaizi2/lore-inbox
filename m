Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbRE3Abi>; Tue, 29 May 2001 20:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbRE3Ab2>; Tue, 29 May 2001 20:31:28 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:60430 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261493AbRE3AbS>; Tue, 29 May 2001 20:31:18 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105300032.CAA04448@green.mif.pg.gda.pl>
Subject: [PATCH]  Config of APM
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
Date: Wed, 30 May 2001 02:32:00 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   The following patch (against 2.4.5-ac4) fixes APM options to work
with xconfig.

--- arch/i386/config.in.old	Wed May 30 02:11:28 2001
+++ arch/i386/config.in	Wed May 30 02:11:54 2001
@@ -254,7 +254,7 @@
 fi
 
 dep_tristate '  Advanced Power Management BIOS support' CONFIG_APM $CONFIG_PM
-if [ "$CONFIG_APM" != "n" ]; then
+if [ "$CONFIG_APM" = "y" -o "$CONFIG_APM" = "m" ]; then
    bool '    Ignore USER SUSPEND' CONFIG_APM_IGNORE_USER_SUSPEND
    bool '    Enable PM at boot time' CONFIG_APM_DO_ENABLE
    bool '    Make CPU Idle calls when idle' CONFIG_APM_CPU_IDLE


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
