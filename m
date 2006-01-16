Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWAPUrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWAPUrp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWAPUrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:47:45 -0500
Received: from h144-158.u.wavenet.pl ([217.79.144.158]:25236 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S1751169AbWAPUrp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:47:45 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: userland interface fix
Date: Mon, 16 Jan 2006 21:49:02 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601162149.02947.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Two functions in kernel/power/user.c should be static (thanks to Bartlomiej
for spotting this).

Please apply.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/user.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.15-mm4/kernel/power/user.c
===================================================================
--- linux-2.6.15-mm4.orig/kernel/power/user.c	2006-01-15 23:25:28.000000000 +0100
+++ linux-2.6.15-mm4/kernel/power/user.c	2006-01-16 21:16:48.000000000 +0100
@@ -36,7 +36,7 @@ static struct snapshot_data {
 
 static atomic_t device_available = ATOMIC_INIT(1);
 
-int snapshot_open(struct inode *inode, struct file *filp)
+static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
 
@@ -66,7 +66,7 @@ int snapshot_open(struct inode *inode, s
 	return 0;
 }
 
-int snapshot_release(struct inode *inode, struct file *filp)
+static int snapshot_release(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
 
