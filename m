Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbTDXXiu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTDXXic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:38:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:12738 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264501AbTDXXeH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:07 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280541047@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280542604@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:34 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1222, 2003/04/24 16:14:59-07:00, greg@kroah.com

[PATCH] tty: let tiocmset pass TIOCM_LOOP changes to the tty drivers.


 drivers/char/tty_io.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Thu Apr 24 16:18:55 2003
+++ b/drivers/char/tty_io.c	Thu Apr 24 16:18:55 2003
@@ -1700,8 +1700,8 @@
 			break;
 		}
 
-		set &= TIOCM_DTR|TIOCM_RTS|TIOCM_OUT1|TIOCM_OUT2;
-		clear &= TIOCM_DTR|TIOCM_RTS|TIOCM_OUT1|TIOCM_OUT2;
+		set &= TIOCM_DTR|TIOCM_RTS|TIOCM_OUT1|TIOCM_OUT2|TIOCM_LOOP;
+		clear &= TIOCM_DTR|TIOCM_RTS|TIOCM_OUT1|TIOCM_OUT2|TIOCM_LOOP;
 
 		retval = tty->driver->tiocmset(tty, file, set, clear);
 	}

