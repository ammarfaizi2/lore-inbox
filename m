Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263514AbUCTTYS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 14:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263515AbUCTTYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 14:24:18 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:64010 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263514AbUCTTYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 14:24:15 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.5-rc2] fs/proc/proc_tty.c cosmetic fix
Date: Sat, 20 Mar 2004 20:23:45 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403202023.45860@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BpJXAUs2Iv3IAPb"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_BpJXAUs2Iv3IAPb
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Linus, Andrew,

The comment of proc_tty_register_driver has "register_tty_driver()" which is 
"tty_register_driver()" in all drivers.

The comment of proc_tty_unregister_driver has "unregister_tty_driver()" which 
is "tty_unregister_driver()" in all drivers too.

Spelling error "Thsi" is obviously "This" ;)

Please apply.

ciao, Marc

--Boundary-00=_BpJXAUs2Iv3IAPb
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="cosmetic-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cosmetic-fix.patch"

# proc_tty.c |    4 ++--
# 1 files changed, 2 insertions(+), 2 deletions(-)

--- old/fs/proc/proc_tty.c	2004-03-17 13:42:09.000000000 +0100
+++ wolk-for-2.6/fs/proc/proc_tty.c	2004-03-09 13:33:35.000000000 +0100
@@ -181,7 +181,7 @@ static int tty_ldiscs_read_proc(char *pa
 }
 
 /*
- * Thsi function is called by register_tty_driver() to handle
+ * This function is called by tty_register_driver() to handle
  * registering the driver's /proc handler into /proc/tty/driver/<foo>
  */
 void proc_tty_register_driver(struct tty_driver *driver)
@@ -205,7 +205,7 @@ void proc_tty_register_driver(struct tty
 }
 
 /*
- * This function is called by unregister_tty_driver()
+ * This function is called by tty_unregister_driver()
  */
 void proc_tty_unregister_driver(struct tty_driver *driver)
 {

--Boundary-00=_BpJXAUs2Iv3IAPb--
