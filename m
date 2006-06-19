Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWFSM0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWFSM0w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWFSMZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13502 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932424AbWFSMZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:22 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 12/15] frv: ieee1394 is borken on frv
Date: Mon, 19 Jun 2006 13:25:10 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122509.10060.74673.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

The ieee1394 assumes it may make direct use of ->count in the semaphore
structure.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 drivers/ieee1394/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ieee1394/Kconfig b/drivers/ieee1394/Kconfig
index 39142e2..aac5cb2 100644
--- a/drivers/ieee1394/Kconfig
+++ b/drivers/ieee1394/Kconfig
@@ -4,7 +4,7 @@ menu "IEEE 1394 (FireWire) support"
 
 config IEEE1394
 	tristate "IEEE 1394 (FireWire) support"
-	depends on PCI || BROKEN
+	depends on (PCI || BROKEN) && (BROKEN || !FRV)
 	select NET
 	help
 	  IEEE 1394 describes a high performance serial bus, which is also

