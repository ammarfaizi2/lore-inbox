Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUDNWd3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUDNWc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:32:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:31135 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261932AbUDNWYl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:24:41 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814513668@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:11 -0700
Message-Id: <10819814513603@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.18, 2004/04/08 14:12:39-07:00, akpm@osdl.org

[PATCH] I2C: i2c-ali1563.c section fix

ali1563_shutdown() is called from __init ali1563_probe() and hence cannot be
marked __init.


 drivers/i2c/busses/i2c-ali1563.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	Wed Apr 14 15:13:27 2004
+++ b/drivers/i2c/busses/i2c-ali1563.c	Wed Apr 14 15:13:27 2004
@@ -343,7 +343,7 @@
 	return -ENODEV;
 }
 
-static void __exit ali1563_shutdown(struct pci_dev * dev)
+static void ali1563_shutdown(struct pci_dev *dev)
 {
 	release_region(ali1563_smba,ALI1563_SMB_IOSIZE);
 }

