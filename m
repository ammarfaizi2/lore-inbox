Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUKRD6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUKRD6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 22:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbUKRD6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 22:58:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:26526 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262451AbUKRD5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 22:57:44 -0500
Date: Wed, 17 Nov 2004 19:57:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/video/gbefb.c
Message-Id: <20041117195724.672f3793.akpm@osdl.org>
In-Reply-To: <1100735917.7866.11.camel@localhost>
References: <1100735917.7866.11.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org> wrote:
>
> The current gbefb.c source cannot be compiled as module because of a
>  small typo where "option" was written instead of "options" in two
>  places.
> 
>  Here is a small patch that fixes it. May anyone apply it?

Yup, I can take care of that, thanks.

In future, please use `diff -u' to generate `patch -p1' form patches.  Like
this:

--- 25/drivers/video/gbefb.c
+++ 25-akpm/drivers/video/gbefb.c
@@ -1084,9 +1084,9 @@ int __init gbefb_init(void)
 	int i, ret = 0;
 
 #ifndef MODULE
-	char *option = NULL;
+	char *options = NULL;
 
-	if (fb_get_options("gbefb", &option))
+	if (fb_get_options("gbefb", &options))
 		return -ENODEV;
 	gbefb_setup(options);
 #endif
_

