Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265605AbUAGQ4n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265611AbUAGQ4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:56:43 -0500
Received: from users.ccur.com ([208.248.32.211]:10935 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S265605AbUAGQ4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:56:42 -0500
Date: Wed, 7 Jan 2004 11:56:08 -0500
From: Joe Korty <joe.korty@ccur.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: seperator error in __mask_snprintf_len
Message-ID: <20040107165607.GA11483@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against 2.6.1-rc1.

--- base/lib/mask.c	2004-01-07 11:40:07.000000000 -0500
+++ new/lib/mask.c	2004-01-07 11:51:26.000000000 -0500
@@ -96,7 +96,7 @@
 	while (i >= 1 && wordp[i] == 0)
 		i--;
 	while (i >= 0) {
-		len += snprintf(buf+len, buflen-len, "%s%x", sep, wordp[i]);
+		len += snprintf(buf+len, buflen-len, "%x%s", wordp[i], sep);
 		sep = ",";
 		i--;
 	}

