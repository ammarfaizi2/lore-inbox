Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269168AbUIRJ7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269168AbUIRJ7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 05:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269175AbUIRJ7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 05:59:09 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:26499 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S269173AbUIRJ6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 05:58:02 -0400
Message-ID: <414C06AC.4090501@drzeus.cx>
Date: Sat, 18 Sep 2004 11:58:04 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-18219-1095501503-0001-2"
To: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH 2/3] MMC compatibility fix - Power up delay
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-18219-1095501503-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds a 10 ms delay in the power up loop. Some cards fail to 
power up in time without it.

--=_hades.drzeus.cx-18219-1095501503-0001-2
Content-Type: text/x-patch; name="mmc-powerup.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-powerup.patch"

Index: linux-wbsd/drivers/mmc/mmc.c
===================================================================
--- linux-wbsd/drivers/mmc/mmc.c	(revision 58)
+++ linux-wbsd/drivers/mmc/mmc.c	(revision 59)
@@ -442,6 +442,8 @@
 			break;
 
 		err = MMC_ERR_TIMEOUT;
+		
+		mmc_delay(10);
 	}
 
 	if (rocr)

--=_hades.drzeus.cx-18219-1095501503-0001-2--
