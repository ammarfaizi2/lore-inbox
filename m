Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266730AbUIEOJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266730AbUIEOJc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 10:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUIEOJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 10:09:31 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:9633 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S266730AbUIEOJH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 10:09:07 -0400
Message-ID: <413B1E91.2010905@drzeus.cx>
Date: Sun, 05 Sep 2004 16:11:29 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-27129-1094393365-0001-2"
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Split timer resources (AMD64)
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-27129-1094393365-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch splits timer resource from 0x40-0x5f to 0x40-0x43, 0x50-053 
for x86_64. A patch doing this for i386 was released earlier. Forgot 
that we have two x86 platforms.

--
Pierre Ossman


--=_hades.drzeus.cx-27129-1094393365-0001-2
Content-Type: text/x-patch; name="timer.x86_64.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="timer.x86_64.patch"

--- linux-2.6.9-rc1.orig/arch/x86_64/kernel/setup.c	2004-08-24 09:01:52.000000000 +0200
+++ linux-2.6.9-rc1/arch/x86_64/kernel/setup.c	2004-09-05 14:54:32.385922840 +0200
@@ -105,7 +105,8 @@ char command_line[COMMAND_LINE_SIZE];
 struct resource standard_io_resources[] = {
 	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY | IORESOURCE_IO },
 	{ "pic1", 0x20, 0x21, IORESOURCE_BUSY | IORESOURCE_IO },
-	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY | IORESOURCE_IO },
+	{ "timer0", 0x40, 0x43, IORESOURCE_BUSY | IORESOURCE_IO },
+	{ "timer1", 0x50, 0x53, IORESOURCE_BUSY | IORESOURCE_IO },
 	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY | IORESOURCE_IO },
 	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY | IORESOURCE_IO },
 	{ "pic2", 0xa0, 0xa1, IORESOURCE_BUSY | IORESOURCE_IO },

--=_hades.drzeus.cx-27129-1094393365-0001-2--
