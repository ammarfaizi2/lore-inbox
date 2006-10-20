Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946421AbWJTNhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946421AbWJTNhk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946422AbWJTNhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:37:39 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:19979 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1946421AbWJTNhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:37:39 -0400
Subject: [Patch] 2.6.19-rc2-mm2 warning fix for tty3270
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 15:37:33 +0200
Message-Id: <1161351453.3135.11.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the type of the termios parameter to conform with struct
tty_operations. This is trivial as tty3270_set_termios doesn't use it.

  CC      drivers/s390/char/tty3270.o
drivers/s390/char/tty3270.c:1755: warning: initialization from incompatible pointer type

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 tty3270.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/char/tty3270.c	2006-10-19 23:30:53.000000000 +0200
+++ b/drivers/s390/char/tty3270.c	2006-10-19 23:28:38.000000000 +0200
@@ -1659,7 +1659,7 @@ tty3270_flush_buffer(struct tty_struct *
  * Check for visible/invisible input switches
  */
 static void
-tty3270_set_termios(struct tty_struct *tty, struct termios *old)
+tty3270_set_termios(struct tty_struct *tty, struct ktermios *old)
 {
 	struct tty3270 *tp;
 	int new;


