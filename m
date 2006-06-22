Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751899AbWFVWGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbWFVWGx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWFVWGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:06:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:47817 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751899AbWFVWGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:06:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DXnuLW7C0SwFQc4GVAj3fXGV24QAOqXqlC41+xogC87IUltwPHUfzYGgTAWMqnDCMVnTvRLlJN0FPXl5J7eAvQGfNAU/lZ0EZ+xy2lEbqlmf5oC21pWLCa0M9jT67NoSqbt5YutWG2/8ZDN3hgAbMX2qE7RpIx2MNWitLYNw1jE=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix implicit function declarations in kernel/power/main.c
Date: Fri, 23 Jun 2006 00:07:59 +0200
User-Agent: KMail/1.9.3
Cc: Patrick Mochel <mochel@osdl.org>,
       Patrick Mochel <mochelp@infinity.powertie.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606230007.59183.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes two warnings about implicitly declared functions
in kernel/power/main.c : 
  kernel/power/main.c: In function `suspend_prepare':
  kernel/power/main.c:89: warning: implicit declaration of function `suspend_console'
  kernel/power/main.c: In function `suspend_finish':
  kernel/power/main.c:137: warning: implicit declaration of function `resume_console'


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 kernel/power/main.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.17-git4-orig/kernel/power/main.c	2006-06-22 23:45:28.000000000 +0200
+++ linux-2.6.17-git4/kernel/power/main.c	2006-06-23 00:01:04.000000000 +0200
@@ -10,6 +10,7 @@
 
 #include <linux/suspend.h>
 #include <linux/kobject.h>
+#include <linux/console.h>
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/errno.h>


