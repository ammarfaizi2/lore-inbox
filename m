Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVA0NRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVA0NRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 08:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVA0NRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 08:17:18 -0500
Received: from ns.suse.de ([195.135.220.2]:27856 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262615AbVA0NRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 08:17:15 -0500
Date: Thu, 27 Jan 2005 14:17:14 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Hai-Pao Fan <haipao@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>
Subject: drivers/char/ite_gpio.c, GPIO_MINOR missing
Message-ID: <20050127131714.GA23935@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What is the minor number for this driver?
Its not referenced in the makefile, it has no official minor number.
2.4 has MISC_DYNAMIC_MINOR. Should 2.6 use the same?

2.6 driver came already broken.
http://linux.bkbits.net:8080/linux-2.5/gnupatch@3c603dd1pp70eWnkCkTN6Yif9vw14Q

--- ../linux-2.6.11-rc2/drivers/char/ite_gpio.c	2005-01-22 02:48:28.000000000 +0100
+++ ./drivers/char/ite_gpio.c	2005-01-27 14:12:08.418388476 +0100
@@ -370,10 +370,9 @@ static struct file_operations ite_gpio_f
 	.release	= ite_gpio_release,
 };
 
-/* GPIO_MINOR in include/linux/miscdevice.h */
 static struct miscdevice ite_gpio_miscdev =
 {
-	GPIO_MINOR,
+	MISC_DYNAMIC_MINOR,
 	"ite_gpio",
 	&ite_gpio_fops
 };
