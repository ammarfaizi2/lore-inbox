Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269768AbUJSQp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269768AbUJSQp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269840AbUJSQot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:44:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:58308 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269803AbUJSQiu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:50 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982038201196@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:37:02 -0700
Message-Id: <10982038221929@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1991, 2004/09/29 13:12:09-07:00, akpm@osdl.org

[PATCH] module.h build fix

From: Ingo Molnar <mingo@elte.hu>

Forward-declare the structures before using them, rather than relying on
previous inclusions.

akpm: The breakage was introduced by bk-driver-core.patch

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/module.h |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)


diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	2004-10-19 09:20:46 -07:00
+++ b/include/linux/module.h	2004-10-19 09:20:46 -07:00
@@ -540,11 +540,14 @@
 {
 }
 
-static inline void module_add_driver(struct module *, struct device_driver *)
+struct device_driver;
+struct module;
+
+static inline void module_add_driver(struct module *module, struct device_driver *driver)
 {
 }
 
-static inline void module_remove_driver(struct device_driver *)
+static inline void module_remove_driver(struct device_driver *driver)
 {
 }
 

