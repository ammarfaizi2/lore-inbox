Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUHWTAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUHWTAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267316AbUHWS6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:58:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:13252 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267313AbUHWShG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:06 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860894178@kroah.com>
Date: Mon, 23 Aug 2004 11:34:49 -0700
Message-Id: <1093286089386@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.40, 2004/08/09 14:39:20-07:00, rl@hellgate.ch

[PATCH] PCI: saved_config_space -> u32

Match what the functions working on it expect.

Signed-off-by: Roger Luethi <rl@hellgate.ch>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-08-23 11:02:50 -07:00
+++ b/include/linux/pci.h	2004-08-23 11:02:50 -07:00
@@ -536,7 +536,7 @@
 	unsigned int	is_enabled:1;	/* pci_enable_device has been called */
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	
-	unsigned int 	saved_config_space[16]; /* config space saved at suspend time */
+	u32		saved_config_space[16]; /* config space saved at suspend time */
 #ifdef CONFIG_PCI_NAMES
 #define PCI_NAME_SIZE	96
 #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */

