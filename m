Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752014AbWJWVYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbWJWVYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbWJWVYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:24:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:9895 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752014AbWJWVYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:24:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Q7OjERu0e+bsOyYxINCudQ9KIDSaX4HNwcfHCLSo7lAIWymukMxd2j3fe5fqeLF9zNDzmgCKl3lQhrnlZAESWllRMnOBCwsk2c4BmkPNqGPJFd6xx/ftyo4ciintQ0NfoVY/7j49LGDUfdC0dAzzAITeb3vW3BHkfLphFHLqTP8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix use of uninitialized variable in drivers/video/sis/init301.c::SiS_DDC2Delay()
Date: Mon, 23 Oct 2006 23:26:11 +0200
User-Agent: KMail/1.9.4
Cc: Thomas Winischhofer <thomas@winischhofer.net>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232326.11288.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'j' is used uninitialized in the loop. Fix by initializing it to zero.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/video/sis/init301.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sis/init301.c b/drivers/video/sis/init301.c
index f13fadd..f65bedb 100644
--- a/drivers/video/sis/init301.c
+++ b/drivers/video/sis/init301.c
@@ -445,7 +445,8 @@ #endif
 void
 SiS_DDC2Delay(struct SiS_Private *SiS_Pr, unsigned int delaytime)
 {
-   unsigned int i, j;
+   unsigned int i
+   unsigned int j = 0;
 
    for(i = 0; i < delaytime; i++) {
       j += SiS_GetReg(SiS_Pr->SiS_P3c4,0x05);


