Return-Path: <linux-kernel-owner+w=401wt.eu-S964996AbXASW0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbXASW0h (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 17:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbXASW0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 17:26:37 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:43346 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964996AbXASW0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 17:26:36 -0500
Date: Fri, 19 Jan 2007 23:26:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Noah Watkins <nwatkins@ittc.ku.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include linux/fs.h in linux/cdev.h for struct inode
In-Reply-To: <11692328473797-git-send-email-nwatkins@ittc.ku.edu>
Message-ID: <Pine.LNX.4.61.0701192324250.18606@yvahk01.tjqt.qr>
References: <11692328473797-git-send-email-nwatkins@ittc.ku.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1503481456-1169245577=:18606"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1503481456-1169245577=:18606
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


>Subject: [PATCH] include linux/fs.h in linux/cdev.h for struct inode

NAK.

Better is this:

Add missing struct predeclarations, otherwise we may get

x.c:2: warning: ‘struct inode’ declared inside parameter list
x.c:2: warning: its scope is only this definition or declaration, which is
probably not what you want

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.20-rc5/include/linux/cdev.h
===================================================================
--- linux-2.6.20-rc5.orig/include/linux/cdev.h
+++ linux-2.6.20-rc5/include/linux/cdev.h
@@ -6,6 +6,10 @@
 #include <linux/kdev_t.h>
 #include <linux/list.h>
 
+struct file_operations;
+struct inode;
+struct module;
+
 struct cdev {
 	struct kobject kobj;
 	struct module *owner;


--1283855629-1503481456-1169245577=:18606--
