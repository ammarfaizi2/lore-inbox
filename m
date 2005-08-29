Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbVH2XEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbVH2XEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVH2XEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:04:44 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:20824 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751327AbVH2XEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:04:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=r5k3nBD2tKg1CovPHhkdQFnkF5TZhp3H4D7GA2JsiYdY2b7fQZkn3GNhC82eq36yDv8lHyjiNHqqikCY46kDzJPUek+AGYLOK4ijl70XidMhpN4krhNTM6PNXhibTXJFiRFDvAB0PQec5vPBg95pjI44UYTH630s5ATt7/3fmdU=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [PATCH] isdn_v110 warning fix
Date: Tue, 30 Aug 2005 01:05:43 +0200
User-Agent: KMail/1.8.2
Cc: Thomas Pfeiffer <pfeiffer@pds.de>, isdn4linux@listserv.isdn4linux.de,
       Karsten Keil <kkeil@suse.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508300105.44247.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Warning fix :
 drivers/isdn/i4l/isdn_v110.c:523: warning: `ret' might be used uninitialized in this function

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/isdn/i4l/isdn_v110.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.13-orig/drivers/isdn/i4l/isdn_v110.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/drivers/isdn/i4l/isdn_v110.c	2005-08-30 00:59:34.000000000 +0200
@@ -516,11 +516,11 @@
 }
 
 int
-isdn_v110_stat_callback(int idx, isdn_ctrl * c)
+isdn_v110_stat_callback(int idx, isdn_ctrl *c)
 {
 	isdn_v110_stream *v = NULL;
 	int i;
-	int ret;
+	int ret = 0;
 
 	if (idx < 0)
 		return 0;
