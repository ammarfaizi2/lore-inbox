Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUHWTAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUHWTAN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUHWS6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:58:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:11716 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267306AbUHWShE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:04 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860811751@kroah.com>
Date: Mon, 23 Aug 2004 11:34:42 -0700
Message-Id: <1093286082136@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1790.2.4, 2004/08/02 15:34:05-07:00, domen@coderock.org

[PATCH] PCI: use list_for_each() i386/pci/common.c

From: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/pci/common.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c	2004-08-23 11:08:33 -07:00
+++ b/arch/i386/pci/common.c	2004-08-23 11:08:33 -07:00
@@ -70,7 +70,7 @@
 	int i;
 
 	DBG("PCI: Scanning for ghost devices on bus %d\n", b->number);
-	for (ln=b->devices.next; ln != &b->devices; ln=ln->next) {
+	list_for_each(ln, &b->devices) {
 		d = pci_dev_b(ln);
 		if ((d->class >> 8) == PCI_CLASS_BRIDGE_HOST)
 			seen_host_bridge++;

