Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264229AbUFVRxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUFVRxW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbUFVRxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:53:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:52917 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265089AbUFVRnn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:43 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261122143@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:53 -0700
Message-Id: <10879261122864@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.111.26, 2004/06/14 09:45:55-07:00, greg@kroah.com

I2C: sparse cleanups again, based on comments from lkml

This is more like the original code.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/it87.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Tue Jun 22 09:46:48 2004
+++ b/drivers/i2c/chips/it87.c	Tue Jun 22 09:46:48 2004
@@ -170,11 +170,8 @@
 static int DIV_TO_REG(int val)
 {
 	int answer = 0;
-	val >>= 1;
-	while (val) {
+	while ((val >>= 1) != 0)
 		answer++;
-		val >>= 1;
-	}
 	return answer;
 }
 #define DIV_FROM_REG(val) (1 << (val))

