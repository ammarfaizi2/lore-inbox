Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264695AbUDUDrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264695AbUDUDrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 23:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUDUDrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 23:47:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:4031 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264695AbUDUDrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:47:39 -0400
Date: Tue, 20 Apr 2004 20:47:21 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] Kconfig.debug family
Message-Id: <20040420204721.06dee590.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Localizes kernel debug options in lib/Kconfig.debug.
Puts arch-specific debug options in $ARCH/Kconfig.debug.

updated for 2.6.6-rc2

http://developer.osdl.org/rddunlap/patches/kconf_debug_1file_266rc2.patch

 arch/alpha/Kconfig           |  104 ---------------------
 arch/alpha/Kconfig.debug     |   54 +++++++++++
 arch/arm/Kconfig             |  160 --------------------------------
 arch/arm/Kconfig.debug       |  113 +++++++++++++++++++++++
 arch/arm26/Kconfig           |  113 -----------------------
 arch/arm26/Kconfig.debug     |   58 +++++++++++
 arch/cris/Kconfig            |   14 --
 arch/cris/Kconfig.debug      |   14 ++
 arch/h8300/Kconfig           |   72 --------------
 arch/h8300/Kconfig.debug     |   66 +++++++++++++
 arch/i386/Kconfig            |  125 -------------------------
 arch/i386/Kconfig.debug      |   14 ++
 arch/ia64/Kconfig            |  114 -----------------------
 arch/ia64/Kconfig.debug      |   62 ++++++++++++
 arch/m68k/Kconfig            |   38 -------
 arch/m68k/Kconfig.debug      |    8 +
 arch/m68knommu/Kconfig       |   55 -----------
 arch/m68knommu/Kconfig.debug |   41 ++++++++
 arch/mips/Kconfig            |  119 ------------------------
 arch/mips/Kconfig.debug      |   66 +++++++++++++
 arch/parisc/Kconfig          |   49 ---------
 arch/parisc/Kconfig.debug    |    5 +
 arch/ppc/Kconfig             |  124 -------------------------
 arch/ppc/Kconfig.debug       |   71 ++++++++++++++
 arch/ppc64/Kconfig           |   80 ----------------
 arch/ppc64/Kconfig.debug     |   26 +++++
 arch/s390/Kconfig            |   56 -----------
 arch/s390/Kconfig.debug      |    6 +
 arch/sh/Kconfig              |  140 ----------------------------
 arch/sh/Kconfig.debug        |  110 ++++++++++++++++++++++
 arch/sparc/Kconfig           |   72 --------------
 arch/sparc/Kconfig.debug     |   13 ++
 arch/sparc64/Kconfig         |  104 ---------------------
 arch/sparc64/Kconfig.debug   |   37 +++++++
 arch/um/Kconfig              |   60 ------------
 arch/um/Kconfig.debug        |   34 ++++++
 arch/v850/Kconfig            |   29 -----
 arch/v850/Kconfig.debug      |    9 +
 arch/x86_64/Kconfig          |  101 --------------------
 arch/x86_64/Kconfig.debug    |   46 +++++++++
 init/Kconfig                 |    8 -
 lib/Kconfig.debug            |  211 +++++++++++++++++++++++++++++++++++++++++++
 42 files changed, 1084 insertions(+), 1717 deletions(-)

--
~Randy
