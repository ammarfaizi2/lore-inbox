Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTIPJo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 05:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTIPJo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 05:44:28 -0400
Received: from f13.mail.ru ([194.67.57.43]:26632 "EHLO f13.mail.ru")
	by vger.kernel.org with ESMTP id S261819AbTIPJo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 05:44:26 -0400
From: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	<adobriyan@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to build tgafb.c in 2.6.0-test5 due to undefined color_table
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [193.124.225.253]
Date: Tue, 16 Sep 2003 13:44:25 +0400
Reply-To: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	  <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19zCNl-000I6m-00.adobriyan-mail-ru@f13.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was trying to compile the tga framebuffer driver but there was a > compiler error saying that color_table was not defined. I grepped 
> through the drivers/video and include/video directories and did not > find a declaration. Was there a header file not included or code 
> missing from the driver?

This should fix the problem.

Alexey

diff -urN a/drivers/video/tgafb.c b/drivers/video/tgafb.c
--- a/drivers/video/tgafb.c	2003-09-08 23:50:16.000000000 +0400
+++ b/drivers/video/tgafb.c	2003-09-16 13:46:46.000000000 +0400
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/fb.h>
+#include <linux/selection.h>
 #include <linux/pci.h>
 #include <asm/io.h>
 #include <video/tgafb.h>

