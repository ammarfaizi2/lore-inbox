Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVAGH2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVAGH2L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 02:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVAGH2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 02:28:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37297 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261296AbVAGH2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 02:28:06 -0500
Message-ID: <41DE3A01.8090905@pobox.com>
Date: Fri, 07 Jan 2005 02:28:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel/sys.c build fix
Content-Type: multipart/mixed;
 boundary="------------050000050100070407020608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050000050100070407020608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


On x86-64, the attached patch is required to fix

> kernel/sys.c: In function `sys_setsid':
> kernel/sys.c:1078: error: `tty_sem' undeclared (first use in this function)
> kernel/sys.c:1078: error: (Each undeclared identifier is reported only once
> kernel/sys.c:1078: error: for each function it appears in.)

kernel/sys.c needs the tty_sem declaration from linux/tty.h.

	Jeff




--------------050000050100070407020608
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== kernel/sys.c 1.101 vs edited =====
--- 1.101/kernel/sys.c	2005-01-04 13:47:32 -05:00
+++ edited/kernel/sys.c	2005-01-07 02:25:46 -05:00
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
+#include <linux/tty.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>

--------------050000050100070407020608--
