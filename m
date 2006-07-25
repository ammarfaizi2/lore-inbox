Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWGYUQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWGYUQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWGYUQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:16:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:39726 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964854AbWGYUQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:16:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RBua6732UQECkOvyz7XdnTYTwhaHQFLZB77HfUgRuWagXSjomY3SRQXOVEg4wyTi7wnwcrFQ1SmPAIWOaBfAOpg2aNuWi2HPoKtGGwsK4aSQdM+MzZ1JXSHt/warKwd8l6ki7XIC6xtVir19b0aitQI5owITwX7RTOyt4devr30=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] update I/O sched Kconfig help texts - CFQ is now default, not AS.
Date: Tue, 25 Jul 2006 22:18:01 +0200
User-Agent: KMail/1.9.3
Cc: Jens Axboe <axboe@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607252218.01663.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change I/O scheduler description to correctly show CFQ as being the default
scheduler and not the anticipatory scheduler that previously was default.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 block/Kconfig.iosched |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6.18-rc2-git5-orig/block/Kconfig.iosched	2006-07-18 18:46:18.000000000 +0200
+++ linux-2.6.18-rc2-git5/block/Kconfig.iosched	2006-07-25 22:12:08.000000000 +0200
@@ -15,10 +15,10 @@ config IOSCHED_AS
 	tristate "Anticipatory I/O scheduler"
 	default y
 	---help---
-	  The anticipatory I/O scheduler is the default disk scheduler. It is
-	  generally a good choice for most environments, but is quite large and
-	  complex when compared to the deadline I/O scheduler, it can also be
-	  slower in some cases especially some database loads.
+	  The anticipatory I/O scheduler is generally a good choice for most
+	  environments, but is quite large and complex when compared to the
+	  deadline I/O scheduler, it can also be slower in some cases
+	  especially some database loads.
 
 config IOSCHED_DEADLINE
 	tristate "Deadline I/O scheduler"
@@ -37,6 +37,7 @@ config IOSCHED_CFQ
 	  The CFQ I/O scheduler tries to distribute bandwidth equally
 	  among all processes in the system. It should provide a fair
 	  working environment, suitable for desktop systems.
+	  This is the default I/O scheduler.
 
 choice
 	prompt "Default I/O scheduler"


