Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTISTsj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTISTrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:47:32 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:33444 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261697AbTISTrY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:47:24 -0400
Subject: [PATCH 3/5] Remove a not necessary #ifdef CONFIG_PROC_FS/#endif in input.c
In-Reply-To: <10640008352019@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 21:47:15 +0200
Message-Id: <1064000835630@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1352, 2003-09-19 13:25:06+02:00, lcapitulino@prefeitura.sp.gov.br
  input: Remove a not necessary #ifdef CONFIG_PROC_FS/#endif in input.c


 input.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Fri Sep 19 14:12:49 2003
+++ b/drivers/input/input.c	Fri Sep 19 14:12:49 2003
@@ -737,11 +737,10 @@
 
 static void __exit input_exit(void)
 {
-#ifdef CONFIG_PROC_FS
 	remove_proc_entry("devices", proc_bus_input_dir);
 	remove_proc_entry("handlers", proc_bus_input_dir);
 	remove_proc_entry("input", proc_bus);
-#endif
+
 	devfs_remove("input");
 	unregister_chrdev(INPUT_MAJOR, "input");
 	class_unregister(&input_class);

