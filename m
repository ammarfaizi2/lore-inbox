Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVCEPjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVCEPjr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbVCEPiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:38:09 -0500
Received: from coderock.org ([193.77.147.115]:44963 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262021AbVCEPft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:35:49 -0500
Subject: [patch 07/12] Re: radio-sf16fmi cleanup
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, sebek64@post.cz
From: domen@coderock.org
Date: Sat, 05 Mar 2005 16:35:28 +0100
Message-Id: <20050305153529.5430B1F203@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is small cleanup of radio-sf16fmi driver.

Signed-off-by: Marcel Sebek <sebek64@post.cz>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/Documentation/kernel-parameters.txt |    3 ---
 kj-domen/drivers/media/radio/radio-sf16fmi.c |   10 ----------
 2 files changed, 13 deletions(-)

diff -puN Documentation/kernel-parameters.txt~kill_kernel_parameter-sf16fm Documentation/kernel-parameters.txt
--- kj/Documentation/kernel-parameters.txt~kill_kernel_parameter-sf16fm	2005-03-05 16:11:31.000000000 +0100
+++ kj-domen/Documentation/kernel-parameters.txt	2005-03-05 16:11:31.000000000 +0100
@@ -1148,9 +1148,6 @@ running once the system is up.
 
 	serialnumber	[BUGS=IA-32]
 
-	sf16fm=		[HW] SF16FMI radio driver for Linux
-			Format: <io>
-
 	sg_def_reserved_size=
 			[SCSI]
  
diff -puN drivers/media/radio/radio-sf16fmi.c~kill_kernel_parameter-sf16fm drivers/media/radio/radio-sf16fmi.c
--- kj/drivers/media/radio/radio-sf16fmi.c~kill_kernel_parameter-sf16fm	2005-03-05 16:11:31.000000000 +0100
+++ kj-domen/drivers/media/radio/radio-sf16fmi.c	2005-03-05 16:11:31.000000000 +0100
@@ -326,13 +326,3 @@ static void __exit fmi_cleanup_module(vo
 
 module_init(fmi_init);
 module_exit(fmi_cleanup_module);
-
-#ifndef MODULE
-static int __init fmi_setup_io(char *str)
-{
-	get_option(&str, &io);
-	return 1;
-}
-
-__setup("sf16fm=", fmi_setup_io);
-#endif
_
