Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbUJ1KRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUJ1KRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbUJ1KPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:15:38 -0400
Received: from sd291.sivit.org ([194.146.225.122]:44182 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262882AbUJ1KHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:07:25 -0400
Date: Thu, 28 Oct 2004 12:08:51 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 5/8] sonypi: make CONFIG_SONYPI depend on CONFIG_INPUT
Message-ID: <20041028100851.GF3893@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20041028100525.GA3893@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028100525.GA3893@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2195, 2004-10-28 10:23:13+02:00, stelian@popies.net
  sonypi: make CONFIG_SONYPI depend on CONFIG_INPUT since the latter is no more optional.

  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	2004-10-28 11:09:18 +02:00
+++ b/drivers/char/Kconfig	2004-10-28 11:09:18 +02:00
@@ -835,7 +835,7 @@
 
 config SONYPI
 	tristate "Sony Vaio Programmable I/O Control Device support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && X86 && PCI && !64BIT
+	depends on EXPERIMENTAL && X86 && PCI && INPUT && !64BIT
 	---help---
 	  This driver enables access to the Sony Programmable I/O Control
 	  Device which can be found in many (all ?) Sony Vaio laptops.
