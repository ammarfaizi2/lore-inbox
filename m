Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbUL0TUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbUL0TUG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 14:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbUL0TUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 14:20:06 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:25714 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261940AbUL0TTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 14:19:49 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [bk patches] Long delayed input update
Date: Mon, 27 Dec 2004 14:19:43 -0500
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, torvalds@osld.org, akpm@osdl.org
References: <20041227142821.GA5309@ucw.cz>
In-Reply-To: <20041227142821.GA5309@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412271419.46143.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 December 2004 09:28 am, Vojtech Pavlik wrote:
> ChangeSet@1.1957.1.21, 2004-10-21 23:52:36-05:00, dtor_core@ameritech.net
> ? Input: i8042 - allow turning debugging on and off "on-fly"
> ? ? ? ? ?so people do not have to recompile their kernels to
> ? ? ? ? ?provide debug info.
> ? 
> ? ? ? ? ?Adds new parameter i8042.debug also accessible through
> ? ? ? ? ?sysfs. 
> ? 
> ? Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Hi,

This one needs the patch below to correct permissions braindamage.

-- 
Dmitry


===================================================================


ChangeSet@1.1968, 2004-11-25 00:33:20-05:00, dtor_core@ameritech.net
  Input: i8042 - fix "debug" parameter sysfs permissions.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 i8042.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-11-25 01:27:15 -05:00
+++ b/drivers/input/serio/i8042.c	2004-11-25 01:27:15 -05:00
@@ -68,7 +68,7 @@
 #define DEBUG
 #ifdef DEBUG
 static int i8042_debug;
-module_param_named(debug, i8042_debug, bool, 600);
+module_param_named(debug, i8042_debug, bool, 0600);
 MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
 #endif
 
