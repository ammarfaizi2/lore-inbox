Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267427AbUHWTIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267427AbUHWTIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267387AbUHWTGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:06:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:8132 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267285AbUHWSg5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:57 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860884059@kroah.com>
Date: Mon, 23 Aug 2004 11:34:48 -0700
Message-Id: <1093286088677@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.37, 2004/08/09 10:48:22-07:00, greg@kroah.com

[PATCH] W1: removed some unneeded global symbols from the w1_smem module.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1_smem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/w1/w1_smem.c b/drivers/w1/w1_smem.c
--- a/drivers/w1/w1_smem.c	2004-08-23 11:03:07 -07:00
+++ b/drivers/w1/w1_smem.c	2004-08-23 11:03:07 -07:00
@@ -104,12 +104,12 @@
 	.fops = &w1_smem_fops,
 };
 
-int __init w1_smem_init(void)
+static int __init w1_smem_init(void)
 {
 	return w1_register_family(&w1_smem_family);
 }
 
-void __exit w1_smem_fini(void)
+static void __exit w1_smem_fini(void)
 {
 	w1_unregister_family(&w1_smem_family);
 }

