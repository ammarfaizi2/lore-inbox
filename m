Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbVJaLOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVJaLOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVJaLOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:14:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22790 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932320AbVJaLN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:13:58 -0500
Date: Mon, 31 Oct 2005 12:13:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>, linux-kernel@vger.kernel.org
Subject: [-mm patch] DLM must depend on SYSFS
Message-ID: <20051031111354.GH8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DLM=y and CONFIG_SYSFS=n results in the following compile error:

<--  snip  -->

...
  LD      vmlinux
drivers/built-in.o:(.data+0x282340): undefined reference to `kernel_subsys'
make: *** [vmlinux] Error 1

<--  snip  -->

This patch was already ACK'ed by David Teigland.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 22 Aug 2005

--- linux-2.6.13-rc6-mm1-full/drivers/dlm/Kconfig.old	2005-08-22 01:56:18.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/drivers/dlm/Kconfig	2005-08-22 01:56:38.000000000 +0200
@@ -3,6 +3,7 @@
 
 config DLM
 	tristate "Distributed Lock Manager (DLM)"
+	depends on SYSFS
 	depends on IPV6 || IPV6=n
 	select IP_SCTP
 	select CONFIGFS_FS

