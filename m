Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262870AbVGKWJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbVGKWJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbVGKWGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:06:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:65244 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262887AbVGKWDy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:03:54 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Clarify the usage of i2c-dev.h
In-Reply-To: <11211193771329@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 11 Jul 2005 15:02:57 -0700
Message-Id: <1121119377583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Clarify the usage of i2c-dev.h

Upon suggestion by Nils Roeder, here is an update to the i2c
documentation to clarify which header files user-space applications
relying on the i2c-dev interface should include.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 1d772e2587da3c8b0fb8610fcc1c91fd82f87e52
tree 816702c0b2b1a37f772b8884ce2177b88af4ab73
parent a68e2f4895070f3a449bfe5ae1174b73cc900642
author Jean Delvare <khali@linux-fr.org> Sat, 25 Jun 2005 11:37:40 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:37 -0700

 Documentation/i2c/dev-interface |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
--- a/Documentation/i2c/dev-interface
+++ b/Documentation/i2c/dev-interface
@@ -14,9 +14,12 @@ C example
 =========
 
 So let's say you want to access an i2c adapter from a C program. The
-first thing to do is `#include <linux/i2c.h>" and "#include <linux/i2c-dev.h>. 
-Yes, I know, you should never include kernel header files, but until glibc 
-knows about i2c, there is not much choice.
+first thing to do is "#include <linux/i2c-dev.h>". Please note that
+there are two files named "i2c-dev.h" out there, one is distributed
+with the Linux kernel and is meant to be included from kernel
+driver code, the other one is distributed with lm_sensors and is
+meant to be included from user-space programs. You obviously want
+the second one here.
 
 Now, you have to decide which adapter you want to access. You should
 inspect /sys/class/i2c-dev/ to decide this. Adapter numbers are assigned
@@ -78,7 +81,7 @@ Full interface description
 ==========================
 
 The following IOCTLs are defined and fully supported 
-(see also i2c-dev.h and i2c.h):
+(see also i2c-dev.h):
 
 ioctl(file,I2C_SLAVE,long addr)
   Change slave address. The address is passed in the 7 lower bits of the

