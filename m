Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbUCPBOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbUCPADO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:03:14 -0500
Received: from mail.kroah.org ([65.200.24.183]:1711 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262871AbUCPABy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:01:54 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <10793951472062@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:08 -0800
Message-Id: <10793951481021@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.9, 2004/03/11 13:21:13-08:00, greg@kroah.com

Kobject: add decl_subsys_name() macro for users who want to set the subsystem name


 include/linux/kobject.h |    8 ++++++++
 1 files changed, 8 insertions(+)


diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	Mon Mar 15 15:29:10 2004
+++ b/include/linux/kobject.h	Mon Mar 15 15:29:10 2004
@@ -151,6 +151,14 @@
 		.hotplug_ops =_hotplug_ops, \
 	} \
 }
+#define decl_subsys_name(_varname,_name,_type,_hotplug_ops) \
+struct subsystem _varname##_subsys = { \
+	.kset = { \
+		.kobj = { .name = __stringify(_name) }, \
+		.ktype = _type, \
+		.hotplug_ops =_hotplug_ops, \
+	} \
+}
 
 
 /**

