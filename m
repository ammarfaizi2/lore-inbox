Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbUL0BB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUL0BB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 20:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUL0BBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 20:01:25 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:39062 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261462AbUL0BBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 20:01:19 -0500
Message-ID: <41CF5EDB.5010806@drzeus.cx>
Date: Mon, 27 Dec 2004 02:01:15 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-20139-1104109347-0001-2"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH] Fix warning in wbsd
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-20139-1104109347-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Cleanup that fixes a warning in the wbsd module.

--=_hades.drzeus.cx-20139-1104109347-0001-2
Content-Type: text/x-patch; name="wbsd-warning-fix.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wbsd-warning-fix.patch"

Index: linux-wbsd/drivers/mmc/wbsd.c
===================================================================
--- linux-wbsd/drivers/mmc/wbsd.c	(revision 109)
+++ linux-wbsd/drivers/mmc/wbsd.c	(working copy)
@@ -205,8 +205,6 @@
 
 static inline void wbsd_init_sg(struct wbsd_host* host, struct mmc_data* data)
 {
-	struct request* req = data->req;
-	
 	/*
 	 * Get info. about SG list from data structure.
 	 */

--=_hades.drzeus.cx-20139-1104109347-0001-2--
