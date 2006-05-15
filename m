Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWEOV4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWEOV4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWEOV4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:56:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:63106 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965007AbWEOV4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:56:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mRpGbhoc/Vc4qK3niiK27VKQOFiKjNqH1tPq7BSdr4AwgbdPZJwOb5ADWP5q07HKUpel7qN/e5I+zXawJTeeBNR7DRMhU20osGJuHaam+3BSr2tGpdbIxeqb9FssD4Y6+K9zWbB4gKh530K6cfG2LByvuxgxO/61JxLQddvpKBA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] moxa: remove pointless check of 'tty' argument vs NULL
Date: Mon, 15 May 2006 23:57:35 +0200
User-Agent: KMail/1.9.1
Cc: Moxa Technologies <support@moxa.com.tw>, Alan Cox <alan@redhat.com>,
       Martin Mares <mj@ucw.cz>, Alexey Dobriyan <adobriyan@gmail.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152357.36018.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove pointless check of 'tty' argument vs NULL from moxa driver.

(applies on top of patch 1/3)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/char/mxser.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc4-mm1/drivers/char/mxser.c.1	2006-05-15 22:33:49.000000000 +0200
+++ linux-2.6.17-rc4-mm1/drivers/char/mxser.c	2006-05-15 22:34:38.000000000 +0200
@@ -1081,7 +1081,7 @@ static int mxser_write(struct tty_struct
 	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
-	if (!tty || !info->xmit_buf)
+	if (!info->xmit_buf)
 		return (0);
 
 	while (1) {
@@ -1117,7 +1117,7 @@ static void mxser_put_char(struct tty_st
 	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
-	if (!tty || !info->xmit_buf)
+	if (!info->xmit_buf)
 		return;
 
 	if (info->xmit_cnt >= SERIAL_XMIT_SIZE - 1)



