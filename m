Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280524AbRKGL47>; Wed, 7 Nov 2001 06:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280602AbRKGL4t>; Wed, 7 Nov 2001 06:56:49 -0500
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:42425 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S280524AbRKGL4m>; Wed, 7 Nov 2001 06:56:42 -0500
Date: Wed, 7 Nov 2001 17:26:12 +0530 (IST)
From: Manik Raina <manik@cisco.com>
To: arjanv@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] : fixed warnings in pdcraid.c
Message-ID: <Pine.LNX.4.21.0111071723390.6846-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-551152399-1005134172=:6846"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-551152399-1005134172=:6846
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

This patch fixes the warnings generated when compiling
2.4.14. It fixes the warnings which i have attached 
at the end of the mail .....

They're all unused variables.

Manik


diff -r -u /home/manik/linux/orig/linux/drivers/ide/pdcraid.c ./pdcraid.c
--- /home/manik/linux/orig/linux/drivers/ide/pdcraid.c	Tue Oct 16 01:57:42 2001
+++ ./pdcraid.c	Wed Nov  7 17:09:27 2001
@@ -96,7 +96,7 @@
 static int pdcraid_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	unsigned int minor;
-   	unsigned long sectors,*larg;
+  	unsigned long sectors;
 
 	
 
@@ -280,7 +280,6 @@
 	 */
 	return 1;
 
- outerr:
 	buffer_IO_error(bh);
 	return 0;
 }
@@ -547,7 +546,6 @@
 			   
 static __init int pdcraid_init_one(int device,int raidlevel)
 {
-	request_queue_t *q;
 	int i,count;
 
 	probedisk(0, device, raidlevel);
@@ -585,7 +583,7 @@
 
 static __init int pdcraid_init(void)
 {
-	int i,retval,device,count=0;
+	int retval,device,count=0;
 
 	do {
 	

--8323328-551152399-1005134172=:6846
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=X
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0111071726120.6846@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename=X

cGRjcmFpZC5jOiBJbiBmdW5jdGlvbiBgcGRjcmFpZF9pb2N0bCc6DQpwZGNy
YWlkLmM6OTk6IHdhcm5pbmc6IHVudXNlZCB2YXJpYWJsZSBgbGFyZycNCnBk
Y3JhaWQuYzogSW4gZnVuY3Rpb24gYHBkY3JhaWQwX21ha2VfcmVxdWVzdCc6
DQpwZGNyYWlkLmM6MjgzOiB3YXJuaW5nOiBsYWJlbCBgb3V0ZXJyJyBkZWZp
bmVkIGJ1dCBub3QgdXNlZA0KcGRjcmFpZC5jOiBJbiBmdW5jdGlvbiBgcGRj
cmFpZF9pbml0X29uZSc6DQpwZGNyYWlkLmM6NTUwOiB3YXJuaW5nOiB1bnVz
ZWQgdmFyaWFibGUgYHEnDQpwZGNyYWlkLmM6IEluIGZ1bmN0aW9uIGBwZGNy
YWlkX2luaXQnOg0KcGRjcmFpZC5jOjU4ODogd2FybmluZzogdW51c2VkIHZh
cmlhYmxlIGBpJw0K
--8323328-551152399-1005134172=:6846--
