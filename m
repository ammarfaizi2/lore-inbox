Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUIFG4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUIFG4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 02:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUIFG4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 02:56:08 -0400
Received: from asplinux.ru ([195.133.213.194]:49169 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S266879AbUIFGz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 02:55:59 -0400
Message-ID: <413C0CC5.4000807@sw.ru>
Date: Mon, 06 Sep 2004 11:07:49 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] removes unnessary print of space
Content-Type: multipart/mixed;
 boundary="------------040301090008070705070804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040301090008070705070804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes unnessary print of space in bust_spinlocks().
printk("") wakeups klogd as well, no need to print a space
and make a mess.

Kirill

--------------040301090008070705070804
Content-Type: text/plain;
 name="diff-oops-printk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-oops-printk"

--- ./arch/i386/mm/fault.c.printk	2004-08-14 14:54:46.000000000 +0400
+++ ./arch/i386/mm/fault.c	2004-09-06 11:02:32.730550352 +0400
@@ -51,7 +51,7 @@ void bust_spinlocks(int yes)
 	 * a poke.  Hold onto your hats...
 	 */
 	console_loglevel = 15;		/* NMI oopser may have shut the console up */
-	printk(" ");
+	printk("");
 	console_loglevel = loglevel_save;
 }
 

--------------040301090008070705070804--

