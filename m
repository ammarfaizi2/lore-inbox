Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUANWFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUANWFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:05:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:14814 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263107AbUANWFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:05:48 -0500
Date: Wed, 14 Jan 2004 14:06:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: aebr@win.tue.nl, 1@pervalidus.net, linux-kernel@vger.kernel.org
Subject: Re: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel
 2.6.1
Message-Id: <20040114140657.6173f102.akpm@osdl.org>
In-Reply-To: <20040114214212.GA2485@ucw.cz>
References: <200401111545.59290.murilo_pontes@yahoo.com.br>
	<20040111235025.GA832@ucw.cz>
	<Pine.LNX.4.58.0401120004110.601@pervalidus.dyndns.org>
	<20040112083647.GB2372@ucw.cz>
	<20040112135655.A980@pclin040.win.tue.nl>
	<20040114142445.GA28377@ucw.cz>
	<20040114182202.GA32081@ucw.cz>
	<20040114120136.0f3f92ca.akpm@osdl.org>
	<20040114214212.GA2485@ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> wrote:
>
> > Should the below patch be dropped, or is further resolution needed?
> 
> The patch below needs to be redone. I'll do it.

OK.  I'm also showing clashes with the below patch, so please incorporate
that too.


From: Vojtech Pavlik <vojtech@suse.cz>

Fix emulation of PrintScreen key and 103rd Euro key for XFree86.



---

 drivers/char/keyboard.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/char/keyboard.c~input-print-screen-emulation-fix drivers/char/keyboard.c
--- 25/drivers/char/keyboard.c~input-print-screen-emulation-fix	2004-01-11 13:48:41.000000000 -0800
+++ 25-akpm/drivers/char/keyboard.c	2004-01-11 13:48:41.000000000 -0800
@@ -941,8 +941,8 @@ static unsigned short x86_keycodes[256] 
 	 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
 	 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
 	 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
-	 80, 81, 82, 83, 84, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
-	284,285,309,311,312, 91,327,328,329,331,333,335,336,337,338,339,
+	 80, 81, 82, 83, 43, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
+	284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
 	367,288,302,304,350, 89,334,326,116,377,109,111,126,347,348,349,
 	360,261,262,263,298,376,100,101,321,316,373,286,289,102,351,355,
 	103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,

_

