Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVG2WGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVG2WGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 18:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVG2WEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 18:04:22 -0400
Received: from smtp05.auna.com ([62.81.186.15]:27041 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S262881AbVG2WCc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 18:02:32 -0400
Date: Fri, 29 Jul 2005 22:02:29 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Bug in udev-064... and a question
To: Linux-Kernel Lista <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.3.4
Message-Id: <1122674549l.22860l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.211.177] Login:jamagallon@able.es Fecha:Sat, 30 Jul 2005 00:02:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Same old kinda bug ;)

--- cdsymlinks.c.orig	2005-07-29 23:42:53.000000000 +0200
+++ cdsymlinks.c	2005-07-29 23:46:48.000000000 +0200
@@ -301,8 +301,8 @@
           }
           else if (!strncmp (p.we_wordv[0], "NUMBERED_LINKS=", 15))
             numbered_links = atoi (p.we_wordv[0] + 15);
-          else if (!strncmp (p.we_wordv[0], "LINK_ZERO=", 15))
-            link_zero = atoi (p.we_wordv[0] + 15);
+          else if (!strncmp (p.we_wordv[0], "LINK_ZERO=", 10))
+            link_zero = atoi (p.we_wordv[0] + 10);
           break;
 	}
 	/* fall through */

Now the question...
Why does cdsymlinks do not spit links that already exist ?
This makes impossible to test if you have your links created.
I think that cdsymlinks should emit all possible links, and let the soft
after it decide if it forces the link or skips it...

Anyways, happy summer holydays. Mine begin tomorrow, so I'll be off the list
for a month or so. 
Goin to unsubsribe, to skip bounces....

by

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam12 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


