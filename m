Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbUKIFuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbUKIFuT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUKIFtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:49:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:61086 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261382AbUKIFY6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:24:58 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778564020@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:16 -0800
Message-Id: <10999778564013@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.13, 2004/11/05 13:49:29-08:00, greg@kroah.com

W1: fix build warnings due to msleep changes.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1_family.c |    1 +
 drivers/w1/w1_int.c    |    1 +
 2 files changed, 2 insertions(+)


diff -Nru a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- a/drivers/w1/w1_family.c	2004-11-08 18:55:22 -08:00
+++ b/drivers/w1/w1_family.c	2004-11-08 18:55:22 -08:00
@@ -21,6 +21,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/delay.h>
 
 #include "w1_family.h"
 
diff -Nru a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c	2004-11-08 18:55:22 -08:00
+++ b/drivers/w1/w1_int.c	2004-11-08 18:55:22 -08:00
@@ -21,6 +21,7 @@
 
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/delay.h>
 
 #include "w1.h"
 #include "w1_log.h"

