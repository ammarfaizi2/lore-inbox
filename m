Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbUCJWxm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUCJWvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:51:50 -0500
Received: from smtpq2.home.nl ([213.51.128.197]:15835 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S262866AbUCJWtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:49:46 -0500
Message-ID: <404F9B6B.10102@keyaccess.nl>
Date: Wed, 10 Mar 2004 23:49:15 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] 8139too assertions
Content-Type: multipart/mixed;
 boundary="------------030101000602010608080303"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030101000602010608080303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

current placements of these asserts seems unhelpful; we've already oopsed.

Incremental to IFG patch only for line-numbers.

Rene.


--------------030101000602010608080303
Content-Type: text/plain;
 name="linux-2.6.4-rc2-mm1_8139too-assert.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.4-rc2-mm1_8139too-assert.diff"

--- linux-2.6.4-rc2-mm1/drivers/net/8139too.c~	2004-03-10 22:58:52.000000000 +0100
+++ linux-2.6.4-rc2-mm1/drivers/net/8139too.c	2004-03-10 23:00:49.000000000 +0100
@@ -974,12 +974,11 @@
 	if (i < 0)
 		return i;
 
+	assert (dev != NULL);
 	tp = dev->priv;
+	assert (tp != NULL);
 	ioaddr = tp->mmio_addr;
-
 	assert (ioaddr != NULL);
-	assert (dev != NULL);
-	assert (tp != NULL);
 
 	addr_len = read_eeprom (ioaddr, 0, 8) == 0x8129 ? 8 : 6;
 	for (i = 0; i < 3; i++)

--------------030101000602010608080303--

