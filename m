Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965331AbWJ2TXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965331AbWJ2TXo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965328AbWJ2TUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:20:41 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:54350 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965329AbWJ2TUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:20:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=BRb8RPXhR/6Wh1H+/fuFujDrf3PPlU5q9VEQcbKA0MlpWqCL5CN8KLrDChLArwy+iplt8dOJk4WlhXj/9HwIYWCgHwhlRRlL5iKEPyuaqADODpImJQLMPcQuGoQm9Fnjlt7IsNeGlYLpifdi30SWvqzdpvjB37gf3BT6rTjvxCY=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 02/11] uml ubd driver: document some struct fields
Date: Sun, 29 Oct 2006 20:20:27 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029192026.12292.21143.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add documentation about some fields in struct ubd, whose meaning is non-obvious
due to struct names (should change names altogether, I agree).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 984b5da..e034ca4 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -150,8 +150,9 @@ #endif
 static struct openflags global_openflags = OPEN_FLAGS;
 
 struct cow {
-	/* This is the backing file, actually */
+	/* backing file name */
 	char *file;
+	/* backing file fd */
 	int fd;
 	unsigned long *bitmap;
 	unsigned long bitmap_len;
@@ -160,6 +161,8 @@ struct cow {
 };
 
 struct ubd {
+	/* name (and fd, below) of the file opened for writing, either the
+	 * backing or the cow file. */
 	char *file;
 	int count;
 	int fd;
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
