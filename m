Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVJMCMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVJMCMy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 22:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVJMCMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 22:12:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:49550 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964863AbVJMCMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 22:12:16 -0400
Date: Wed, 12 Oct 2005 19:10:49 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org
Subject: [patch 5/8] input: export input_dev_class so that input drivers can use it.
Message-ID: <20051013021049.GF31732@kroah.com>
References: <20051013014147.235668000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="input-input_dev_class-export.patch"
In-Reply-To: <20051013020844.GA31732@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/input/input.c |    3 ++-
 include/linux/input.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/input/input.c
+++ gregkh-2.6/drivers/input/input.c
@@ -40,6 +40,7 @@ EXPORT_SYMBOL(input_accept_process);
 EXPORT_SYMBOL(input_flush_device);
 EXPORT_SYMBOL(input_event);
 EXPORT_SYMBOL(input_class);
+EXPORT_SYMBOL_GPL(input_dev_class);
 
 #define INPUT_DEVICES	256
 
@@ -724,7 +725,7 @@ static void input_dev_release(struct cla
 	module_put(THIS_MODULE);
 }
 
-static struct class input_dev_class = {
+struct class input_dev_class = {
 	.name			= "input_dev",
 	.release		= input_dev_release,
 	.class_dev_attrs	= input_dev_attrs,
--- gregkh-2.6.orig/include/linux/input.h
+++ gregkh-2.6/include/linux/input.h
@@ -1075,6 +1075,7 @@ static inline void input_set_abs_params(
 }
 
 extern struct class *input_class;
+extern struct class input_dev_class;
 
 #endif
 #endif

--
