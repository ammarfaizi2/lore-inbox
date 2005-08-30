Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVH3Rpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVH3Rpl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVH3Rpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:45:41 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:64877 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932233AbVH3Rpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:45:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:content-disposition:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:message-id;
        b=DAN1azNTw2lVTaISaoXdeKwApsV9/q/5QfTBskSK0jFrcTE+W0U8sJvknpsoRNdL1RWmQHl1Er5eBDJjHMlPqHQqmETVGniUO+EPfKyeuRh9CAyOM8469awNM6KYPvx58U+QcncQNDkV7rvmEUIUs57noS5DwVJOmlV6T/x8qoQ=
Content-Disposition: inline
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Fwd: [PATCH] isdn_v110 warning fix
Date: Tue, 30 Aug 2005 19:46:33 +0200
User-Agent: KMail/1.8.2
Cc: Thomas Pfeiffer <pfeiffer@pds.de>, isdn4linux@listserv.isdn4linux.de,
       Karsten Keil <kkeil@suse.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508301946.34405.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here's a small warning fix for drivers/isdn/i4l/isdn_v110.c
 drivers/isdn/i4l/isdn_v110.c:523: warning: `ret' might be used uninitialized in this function


In addition to Karsten Keil signing off on the patch, Thomas Pfeiffer also 
commented on the patch, saying 
"initializing ret with the value zero is correct and should be done."

Please apply.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Karsten Keil <kkeil@suse.de>
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


