Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTJUAIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 20:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbTJUAIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 20:08:22 -0400
Received: from [65.172.181.6] ([65.172.181.6]:50138 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263007AbTJUAIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 20:08:16 -0400
Subject: Compile changes between -test7 and -test8
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1066694892.3614.9.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 20 Oct 2003 17:08:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Between -test7 and -test8, 23 warnings were fixed, but 17 warnings were
introduced.  The new warnings were basically re-introduced as drivers
were enabled and were mostly flagging deprecated interfaces....which
still need to be fixed.

Summary:
   New warnings = 17
   New errors = 0
   Fixed warnings = 23
   Fixed errors = 0

New warnings:
-------------
drivers/char/applicom.c:522:2: warning: #warning "Je suis stupide. DW. -
copy*user in cli"
drivers/media/common/saa7146_vbi.c:6: warning: `vbi_workaround' defined
but not used
drivers/net/3c515.c:610: warning: `init_etherdev' is deprecated
(declared at include/linux/etherdevice.h:44)
drivers/net/arcnet/arc-rimi.c:319: warning: `dev_alloc' is deprecated
(declared at include/linux/netdevice.h:517)
drivers/net/arcnet/com20020-isa.c:152: warning: `dev_alloc' is
deprecated (declared at include/linux/netdevice.h:517)
drivers/net/arcnet/com20020-pci.c:71: warning: `dev_alloc' is deprecated
(declared at include/linux/netdevice.h:517)
drivers/net/arcnet/com90io.c:385: warning: `dev_alloc' is deprecated
(declared at include/linux/netdevice.h:517)
drivers/net/arcnet/com90xx.c:412: warning: `dev_alloc' is deprecated
(declared at include/linux/netdevice.h:517)
drivers/net/arcnet/com90xx.c:609: warning: `dev_alloc' is deprecated
(declared at include/linux/netdevice.h:517)
drivers/net/atp.c:299: warning: `init_etherdev' is deprecated (declared
at include/linux/etherdevice.h:44)
drivers/net/lance.c:452: warning: `init_etherdev' is deprecated
(declared at include/linux/etherdevice.h:44)
drivers/net/wireless/arlan-main.c:1099: warning: `init_etherdev' is
deprecated (declared at include/linux/etherdevice.h:44)
drivers/net/znet.c:390: warning: `init_etherdev' is deprecated (declared
at include/linux/etherdevice.h:44)
sound/oss/msnd.c:74: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
sound/oss/msnd.c:95: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:494)
sound/oss/msnd_pinnacle.c:1123: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:118)
sound/oss/msnd_pinnacle.c:1811: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:118)

Fixed warnings:
---------------
arch/i386/kernel/cpu/cpufreq/longhaul.h:237: warning:
`nehemiah_clock_ratio' defined but not used
arch/i386/kernel/cpu/cpufreq/longhaul.h:273: warning: `nehemiah_eblcr'
defined but not used
drivers/atm/fore200e.c:1074: warning: unused variable `i'
drivers/char/applicom.c:260:2: warning: #warning "LEAK"
drivers/char/applicom.c:524:2: warning: #warning "Je suis stupide. DW. -
copy*user in cli"
sound/oss/ad1889.c:766: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
sound/oss/ad1889.c:773: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:494)
sound/oss/ad1889.c:795: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
sound/oss/ad1889.c:801: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:494)
sound/oss/cs4281/cs4281m.c:2591: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
sound/oss/cs4281/cs4281m.c:2606: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:494)
sound/oss/cs4281/cs4281m.c:3610: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:494)
sound/oss/cs4281/cs4281m.c:3620: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:494)
sound/oss/cs4281/cs4281m.c:3700: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
sound/oss/cs4281/cs4281m.c:3721: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
sound/oss/cs4281/cs4281m.c:4032: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
sound/oss/cs4281/cs4281m.c:4083: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:494)
sound/oss/cs46xx.c:1893: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
sound/oss/cs46xx.c:1929: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:494)
sound/oss/cs46xx.c:3373: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
sound/oss/cs46xx.c:3460: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:494)
sound/oss/cs46xx.c:4108: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
sound/oss/cs46xx.c:4139: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:494)

John



