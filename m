Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbVJWAZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVJWAZu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 20:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVJWAZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 20:25:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40396 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751320AbVJWAZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 20:25:50 -0400
Date: Sat, 22 Oct 2005 17:25:28 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Joel Schopp <jschopp@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, serue@us.ibm.com,
       Paul Jackson <pj@sgi.com>, Damir Perisa <damir.perisa@solnet.ch>
Message-Id: <20051023002528.19449.18538.sendpatchset@sam.engr.sgi.com>
Subject: [PATCH *-mm] Serial disable jsm in ppc64 defconfig
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes to the serial driver to remove flip buffers have broken the
serial jsm driver.  It doesn't even compile anymore.  The jsm driver
was enabled in only one defconfig - ppc64.  In order to keep defconfigs
building, disable CONFIG_SERIAL_JSM for the time being.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 arch/ppc64/defconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.14-rc4-mm1.orig/arch/ppc64/defconfig	2005-10-22 16:52:34.000000000 -0700
+++ 2.6.14-rc4-mm1/arch/ppc64/defconfig	2005-10-22 16:53:46.000000000 -0700
@@ -824,7 +824,7 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_PMACZILOG is not set
 CONFIG_SERIAL_ICOM=m
-CONFIG_SERIAL_JSM=m
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
