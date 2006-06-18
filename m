Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWFRPtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWFRPtH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWFRPtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:49:06 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3219 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751201AbWFRPsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:48:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=YIWtcGKdOpkRJkvF5cRF90KnjDzU9KSImk4bRe6VfgoawhE8nSNUxn4CkfM/40t+s337cKmGaEd53Xr4fH1w5lL6jwemzRXUZKOCIb+imU7XkivT/tR5Y730dH9sAMNIKRdX1T0ysZwdZ+aHWBG+x4CTJKi0z1vKdVb/0Gy0W9s=
Message-ID: <4495732A.3000407@gmail.com>
Date: Sun, 18 Jun 2006 23:37:14 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, Helge Deller <deller@gmx.de>
Subject: [PATCH 9/9] VT binding: Make sticon support binding
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not mark sticon_startup() as __init

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/sticon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index fd5940f..45c4f22 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -75,7 +75,7 @@ static inline void cursor_undrawn(void)
     cursor_drawn = 0;
 }
 
-static const char *__init sticon_startup(void)
+static const char *sticon_startup(void)
 {
     return "STI console";
 }

