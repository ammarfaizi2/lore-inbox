Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161189AbWFVSwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbWFVSwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161188AbWFVSwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:52:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:61397 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161182AbWFVSwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:52:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ja8qFTatlDwFwTYuQc7TkEjcAejO44uRzp5cRpPkRApQQVcod3QMgE194BouKp3xc1el0xDkrekcyHylNPowgvD8GFk8oC6a9uFwpL6FAXovdoD8kcKlY4y7y+9PgFqX6TAFMm9HF+mb8+ZDb6LgECikN6Lz91PX8bkZH5JZoZM=
Message-ID: <449AE6D6.5090406@gmail.com>
Date: Thu, 22 Jun 2006 12:52:06 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch -mm1 06/11 ] gpio-patchset-fixups:  no static init
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff.13-fix-static-no-init

static vars don't need to be initialized.

Signed-off-by:   Jim Cromie <jim.cromie@gmail.com>

---

diff -ruNp -X dontdiff -X exclude-diffs 17-mm-pre0/drivers/char/pc8736x_gpio.c 13/drivers/char/pc8736x_gpio.c
--- 17-mm-pre0/drivers/char/pc8736x_gpio.c	2006-06-20 20:42:39.000000000 -0600
+++ 13/drivers/char/pc8736x_gpio.c	2006-06-21 10:31:31.000000000 -0600
@@ -28,7 +28,7 @@ MODULE_AUTHOR("Jim Cromie <jim.cromie@gm
 MODULE_DESCRIPTION("NatSemi PC-8736x GPIO Pin Driver");
 MODULE_LICENSE("GPL");
 
-static int major = 0;		/* default to dynamic major */
+static int major;		/* default to dynamic major */
 module_param(major, int, 0);
 MODULE_PARM_DESC(major, "Major device number");
 


