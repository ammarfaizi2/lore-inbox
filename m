Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUDORrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbUDORrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:47:25 -0400
Received: from mail.kroah.org ([65.200.24.183]:23222 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263062AbUDORmI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:08 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <10820509131538@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:53 -0700
Message-Id: <10820509132751@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.17, 2004/04/09 11:51:13-07:00, hannal@us.ibm.com

[PATCH] Fix class support to istallion.c

Realized I put a / in the filename of this device too.

Here is the fix:


 drivers/char/istallion.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c	Thu Apr 15 10:20:13 2004
+++ b/drivers/char/istallion.c	Thu Apr 15 10:20:13 2004
@@ -5323,7 +5323,7 @@
 			       S_IFCHR | S_IRUSR | S_IWUSR,
 			       "staliomem/%d", i);
 		class_simple_device_add(istallion_class, MKDEV(STL_SIOMEMMAJOR, i), 
-				NULL, "staliomem/%d", i);
+				NULL, "staliomem%d", i);
 	}
 
 /*

