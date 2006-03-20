Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbWCTElD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWCTElD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 23:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWCTElB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 23:41:01 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:55311 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751497AbWCTEks
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 23:40:48 -0500
Date: Mon, 20 Mar 2006 04:40:17 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
       linux-ide@vger.kernel.org
Subject: [PATCH 7/12] [IDE] Set CFLAGS only for au1xxx-ide
Message-ID: <20060320044017.GG20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set CFLAGS only for au1xxx-ide since swarm does not reference any
include files from drivers/ide.  This brings drivers/ide/mips/Makefile
in sync with the linux-mips tree.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6/drivers/ide/mips/Makefile	2006-03-05 19:35:03.000000000 +0000
+++ mips.git/drivers/ide/mips/Makefile	2006-03-05 18:51:15.000000000 +0000
@@ -1,4 +1,4 @@
 obj-$(CONFIG_BLK_DEV_IDE_SWARM)		+= swarm.o
 obj-$(CONFIG_BLK_DEV_IDE_AU1XXX)	+= au1xxx-ide.o
 
-EXTRA_CFLAGS    := -Idrivers/ide
+CFLAGS_au1xxx-ide.o := -Idrivers/ide

-- 
Martin Michlmayr
http://www.cyrius.com/
