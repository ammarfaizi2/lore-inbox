Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUATAMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbUATALj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:11:39 -0500
Received: from mail.kroah.org ([65.200.24.183]:21164 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265110AbUATAAE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:04 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567571488@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:17 -0800
Message-Id: <1074556757661@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.2, 2004/01/14 11:09:15-08:00, khali@linux-fr.org

[PATCH] I2C: documentation update

> > They should be converted.  From module.h:
> > 	/* DEPRECATED: Do not use. */
> > 	#define MODULE_PARM(var,type) 	\
> > 	...
>
> Note that realistically, it's not going away in 2.6, so mass migration
> doesn't really win anything.  However, I never implemented mixing old
> and new style in the same module, so if you're adding a parameter, it
> makes sense to convert them all.

OK, I don't have much time for a mass conversion anyway. Greg, could you
please apply the following patch to the "porting-clients" document so
that at least the new drivers don't need to be converted afterwards?


 Documentation/i2c/porting-clients |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)


diff -Nru a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
--- a/Documentation/i2c/porting-clients	Mon Jan 19 15:33:17 2004
+++ b/Documentation/i2c/porting-clients	Mon Jan 19 15:33:17 2004
@@ -92,7 +92,10 @@
   i2c_get_clientdata(client) instead.
 
 * [Interface] Init function should not print anything. Make sure
-  there is a MODULE_LICENSE() line.
+  there is a MODULE_LICENSE() line. MODULE_PARM() is replaced
+  by module_param(). Note that module_param has a third parameter,
+  that you should set to 0 by default. See include/linux/moduleparam.h
+  for details.
 
 Coding policy:
 

