Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWAUUSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWAUUSv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 15:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWAUUSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 15:18:51 -0500
Received: from mail.suse.de ([195.135.220.2]:14491 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932315AbWAUUSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 15:18:51 -0500
Date: Sat, 21 Jan 2006 21:18:48 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Manuel Estrada Sainz <ranty@debian.org>
Subject: [PATCH] IPW2100 fails to load firmware when booting on battery
Message-ID: <20060121201848.GA19221@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We carry this patch around since a while. Is it safe to increase the
timeout also in mainline?

References: https://bugzilla.novell.com/show_bug.cgi?id=74526

IPW2100 fails to load firmware when booting on battery; increasing the
timeout solves the problem.


diff -urNp linux-2.6.12/drivers/base/firmware_class.c linux-2.6.12.SUSE/drivers/base/firmware_class.c
--- linux-2.6.12/drivers/base/firmware_class.c	2005-08-05 11:36:43.908851520 +0200
+++ linux-2.6.12.SUSE/drivers/base/firmware_class.c	2005-08-05 11:41:23.737311128 +0200
@@ -30,7 +30,7 @@ enum {
 	FW_STATUS_READY,
 };
 
-static int loading_timeout = 10;	/* In seconds */
+static int loading_timeout = 30;	/* In seconds */
 
 /* fw_lock could be moved to 'struct firmware_priv' but since it is just
  * guarding for corner cases a global lock should be OK */

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
