Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbUKEAuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbUKEAuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbUKEAsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:48:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:31966 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262514AbUKEAsp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:48:45 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <10996157054012@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 4 Nov 2004 16:48:25 -0800
Message-Id: <10996157051968@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2449.2.9, 2004/11/04 11:59:39-08:00, greg@kroah.com

kevent: fix build error if CONFIG_KOBJECT_UEVENT is not selected.

Thanks to Serge Hallyn <serue@us.ibm.com> for pointing this out.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/kobject_uevent.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-11-04 16:30:17 -08:00
+++ b/lib/kobject_uevent.c	2004-11-04 16:30:17 -08:00
@@ -168,7 +168,7 @@
 
 #else
 static inline int send_uevent(const char *signal, const char *obj,
-			      const void *buf, int buflen, int gfp_mask)
+			      char **envp, int gfp_mask)
 {
 	return 0;
 }

