Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUEJEmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUEJEmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 00:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbUEJEmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 00:42:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:27798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264503AbUEJEmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 00:42:01 -0400
Date: Sun, 9 May 2004 21:39:55 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] use Kconfig.debug for all ARCHes
Message-Id: <20040509213955.0a9b8b56.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__9_May_2004_21_39_55_-0700_0wVM2g.gZC4m_M_j"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sun__9_May_2004_21_39_55_-0700_0wVM2g.gZC4m_M_j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


This patch consolidates most common DEBUG options from
arch/$ARCH/Kconfig into lib/Kconfig.debug.
It moves arch-specific debug options into
arch/$ARCH/Kconfig.debug.

It also contains several lines of whitespace cleanup.

Thanks to Bartlomiej Zolnierkiewicz for much of this work.

Patch is available at:
http://developer.osdl.org/rddunlap/patches/kconfig-debug-266.patch

or attached (gzipped).

--
~Randy


 arch/alpha/Kconfig           |  104 ---------------------------
 arch/alpha/Kconfig.debug     |   55 ++++++++++++++
 arch/arm/Kconfig             |  160 -------------------------------------------
 arch/arm/Kconfig.debug       |  114 ++++++++++++++++++++++++++++++
 arch/arm26/Kconfig           |  113 ------------------------------
 arch/arm26/Kconfig.debug     |   59 +++++++++++++++
 arch/cris/Kconfig            |   14 ---
 arch/cris/Kconfig.debug      |   16 ++++
 arch/h8300/Kconfig           |   72 -------------------
 arch/h8300/Kconfig.debug     |   69 ++++++++++++++++++
 arch/i386/Kconfig            |  125 ---------------------------------
 arch/i386/Kconfig.debug      |   16 ++++
 arch/ia64/Kconfig            |  114 ------------------------------
 arch/ia64/Kconfig.debug      |   65 +++++++++++++++++
 arch/m68k/Kconfig            |   38 ----------
 arch/m68k/Kconfig.debug      |    9 ++
 arch/m68knommu/Kconfig       |   55 --------------
 arch/m68knommu/Kconfig.debug |   43 +++++++++++
 arch/mips/Kconfig            |  119 -------------------------------
 arch/mips/Kconfig.debug      |   68 ++++++++++++++++++
 arch/parisc/Kconfig          |   49 -------------
 arch/parisc/Kconfig.debug    |    6 +
 arch/ppc/Kconfig             |  129 +---------------------------------
 arch/ppc/Kconfig.debug       |   68 ++++++++++++++++++
 arch/ppc64/Kconfig           |   80 ---------------------
 arch/ppc64/Kconfig.debug     |   28 +++++++
 arch/s390/Kconfig            |   57 ---------------
 arch/s390/Kconfig.debug      |    6 +
 arch/sh/Kconfig              |  140 -------------------------------------
 arch/sh/Kconfig.debug        |  112 ++++++++++++++++++++++++++++++
 arch/sparc/Kconfig           |   72 -------------------
 arch/sparc/Kconfig.debug     |   13 +++
 arch/sparc64/Kconfig         |  104 ---------------------------
 arch/sparc64/Kconfig.debug   |   39 ++++++++++
 arch/um/Kconfig              |   60 ----------------
 arch/um/Kconfig.debug        |   36 +++++++++
 arch/v850/Kconfig            |   29 -------
 arch/v850/Kconfig.debug      |   11 ++
 arch/x86_64/Kconfig          |  101 ---------------------------
 arch/x86_64/Kconfig.debug    |   48 ++++++++++++
 init/Kconfig                 |    8 --
 lib/Kconfig.debug            |  145 ++++++++++++++++++++++++++++++++++++++
 42 files changed, 1052 insertions(+), 1717 deletions(-)

--Multipart=_Sun__9_May_2004_21_39_55_-0700_0wVM2g.gZC4m_M_j
Content-Type: application/octet-stream;
 name="kconfig-debug-266.patch.gz"
Content-Disposition: attachment;
 filename="kconfig-debug-266.patch.gz"
Content-Transfer-Encoding: base64

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

--Multipart=_Sun__9_May_2004_21_39_55_-0700_0wVM2g.gZC4m_M_j--
