Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbUCCEdx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUCCEdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:33:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:38786 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262367AbUCCEWD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:22:03 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4-rc1
In-Reply-To: <107828739888@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 2 Mar 2004 20:16:38 -0800
Message-Id: <10782873982895@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1612.17.2, 2004/02/26 16:31:27-08:00, akpm@osdl.org

[PATCH] fix x86_64 build for sys_device_register rename

fix x86_64 build for sys_device_register rename


 arch/x86_64/kernel/mce.c  |    2 +-
 arch/x86_64/kernel/time.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/arch/x86_64/kernel/mce.c b/arch/x86_64/kernel/mce.c
--- a/arch/x86_64/kernel/mce.c	Tue Mar  2 19:51:20 2004
+++ b/arch/x86_64/kernel/mce.c	Tue Mar  2 19:51:20 2004
@@ -448,7 +448,7 @@
 		return -EIO;
 	err = sysdev_class_register(&mce_sysclass);
 	if (!err)
-		err = sys_device_register(&device_mce);
+		err = sysdev_register(&device_mce);
 	if (!err) { 
 		/* could create per CPU objects, but is not worth it. */
 		sysdev_create_file(&device_mce, &attr_disabled_banks); 
diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	Tue Mar  2 19:51:20 2004
+++ b/arch/x86_64/kernel/time.c	Tue Mar  2 19:51:20 2004
@@ -788,7 +788,7 @@
 {
 	int error = sysdev_class_register(&pit_sysclass);
 	if (!error)
-		error = sys_device_register(&device_i8253);
+		error = sysdev_register(&device_i8253);
 	return error;
 }
 

