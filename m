Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbUKWWIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbUKWWIX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUKWWFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:05:53 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:39254 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261439AbUKWWE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:04:59 -0500
Message-ID: <41A3B408.80009@google.com>
Date: Tue, 23 Nov 2004 14:04:56 -0800
From: Edward Falk <efalk@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041008
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]  fix typo in cdrom.c
Content-Type: multipart/mixed;
 boundary="------------020508080006050104080008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020508080006050104080008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bug in dvd_read_manufact found by inspection.

	-ed falk

--------------020508080006050104080008
Content-Type: text/plain;
 name="patch-cdrom"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-cdrom"

--- linux.old/drivers/cdrom/cdrom.c	2004-09-30 16:21:41.000000000 -0700
+++ linux/drivers/cdrom/cdrom.c	2004-11-23 13:56:24.000000000 -0800
@@ -1763,7 +1763,7 @@ static int dvd_read_manufact(struct cdro
 	s->manufact.len = buf[0] << 8 | buf[1];
 	if (s->manufact.len < 0 || s->manufact.len > 2048) {
 		cdinfo(CD_WARNING, "Received invalid manufacture info length"
-				   " (%d)\n", s->bca.len);
+				   " (%d)\n", s->manufact.len);
 		ret = -EIO;
 	} else {
 		memcpy(s->manufact.value, &buf[4], s->manufact.len);

--------------020508080006050104080008--
