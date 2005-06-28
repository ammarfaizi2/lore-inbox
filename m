Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVF1ODK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVF1ODK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVF1Nzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 09:55:36 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:53171 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261744AbVF1Nwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 09:52:33 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] net: add missing include to netdevice.h
Date: Tue, 28 Jun 2005 15:47:03 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, netdev@vger.kernel.org,
       Utz Bacher <utz.bacher@de.ibm.com>, linux-kernel@vger.kernel.org,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
References: <200506281528.08834.arnd@arndb.de>
In-Reply-To: <200506281528.08834.arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200506281547.04620.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux/etherdevice.h can't be included standalone at the moment, which
is required in order to sort the header files in the recommended
alphabetic order. This patch fixes that and is needed to build spider_net.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--- linux-cg.orig/include/linux/etherdevice.h	2005-05-31 07:48:50.044932320 -0400
+++ linux-cg/include/linux/etherdevice.h	2005-05-31 07:49:06.808914320 -0400
@@ -25,6 +25,7 @@
 #define _LINUX_ETHERDEVICE_H
 
 #include <linux/if_ether.h>
+#include <linux/netdevice.h>
 #include <linux/random.h>
 
 #ifdef __KERNEL__
