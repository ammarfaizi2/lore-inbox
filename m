Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbTEIXk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbTEIXk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:40:28 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:50893 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263582AbTEIXk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:40:26 -0400
Date: Fri, 9 May 2003 16:54:11 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver core changes for 2.5.69
Message-ID: <20030509235411.GC3517@kroah.com>
References: <20030509235142.GA3506@kroah.com> <20030509235346.GA3517@kroah.com> <20030509235359.GB3517@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509235359.GB3517@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1098, 2003/05/09 16:26:48-07:00, greg@kroah.com

[PATCH] driver core: remove unneeded line in class code.

Thanks to Jonathan Corbet for pointing this out.


 drivers/base/class.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Fri May  9 16:40:17 2003
+++ b/drivers/base/class.c	Fri May  9 16:40:17 2003
@@ -259,7 +259,6 @@
 
 	/* first, register with generic layer. */
 	strncpy(class_dev->kobj.name, class_dev->class_id, KOBJ_NAME_LEN);
-	kobj_set_kset_s(class_dev, class_subsys);
 	kobj_set_kset_s(class_dev, class_obj_subsys);
 	if (parent)
 		class_dev->kobj.parent = &parent->subsys.kset.kobj;
