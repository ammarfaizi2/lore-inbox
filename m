Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSGYNcm>; Thu, 25 Jul 2002 09:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSGYNbF>; Thu, 25 Jul 2002 09:31:05 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:3837 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314459AbSGYNas>; Thu, 25 Jul 2002 09:30:48 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251448.g6PEm0k8010457@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 CS4281 is missing in sound/pci/Config.in
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:48:00 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/sound/pci/Config.in linux-2.5.28-ac1/sound/pci/Config.in
--- linux-2.5.28/sound/pci/Config.in	Thu Jul 25 10:51:01 2002
+++ linux-2.5.28-ac1/sound/pci/Config.in	Thu Jul 25 13:08:20 2002
@@ -8,6 +8,7 @@
 if [ "$CONFIG_SND_CS46XX" != "n" ]; then
   bool       '  Cirrus Logic (Sound Fusion) MMAP support for OSS' CONFIG_SND_CS46XX_ACCEPT_VALID
 fi
+dep_tristate 'Cirrus Logic (Sound Fusion) CS4281' CONFIG_SND_CS4281 $CONFIG_SND
 dep_tristate 'EMU10K1 (SB Live!, E-mu APS)' CONFIG_SND_EMU10K1 $CONFIG_SND
 dep_tristate 'Korg 1212 IO' CONFIG_SND_KORG1212 $CONFIG_SND
 dep_tristate 'NeoMagic NM256AV/ZX' CONFIG_SND_NM256 $CONFIG_SND
