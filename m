Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVGYF71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVGYF71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 01:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVGYF5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:57:43 -0400
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:33407 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261699AbVGYFzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:55:43 -0400
Message-Id: <20050725054531.866901000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:34:58 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 09/24] input.c section fix
Content-Disposition: inline; filename=input-section-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Input: cannot refer to __exit from within __init.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -588,7 +588,7 @@ static int __init input_proc_init(void)
 	return -ENOMEM;
 }
 
-static void __exit input_proc_exit(void)
+static void input_proc_exit(void)
 {
 	remove_proc_entry("devices", proc_bus_input_dir);
 	remove_proc_entry("handlers", proc_bus_input_dir);

