Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWIXL7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWIXL7x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 07:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWIXL7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 07:59:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:14304 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751211AbWIXL7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 07:59:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KPGgEhKR6GAEXk8L/js5f48Bt3tRVKgZMwd7SByYRJ8a53h1PzepJrNf2OHGeDbQM97K3iLtXgFoAu/Tuxff9FK5INXB6ZlrlyHxdLd2f1NrJDDV67CW5Dbo2KiJfTUQ5jH4UHmCSmjvzIbroaz2C2rYfFwRuwnpvhhcNVeONqw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add distclean info to 'make help' and more details for 'clean'.
Date: Sun, 24 Sep 2006 14:01:08 +0200
User-Agent: KMail/1.9.4
Cc: trivial@kernel.org, sam@ravnborg.org, jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609241401.08395.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add distclean info, that was previously missing, to 'make help'.
Also add a few more details to the 'make clean' help text.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Makefile |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.18-git2-orig/Makefile	2006-09-24 13:01:38.000000000 +0200
+++ linux-2.6.18-git2/Makefile	2006-09-24 13:56:23.000000000 +0200
@@ -1057,8 +1057,10 @@ boards := $(notdir $(boards))
 
 help:
 	@echo  'Cleaning targets:'
-	@echo  '  clean		  - remove most generated files but keep the config'
+	@echo  '  clean		  - remove most generated files but keep the config and'
+	@echo  '                    enough to build external modules'
 	@echo  '  mrproper	  - remove all generated files + config + various backup files'
+	@echo  '  distclean       - remove editor backup files, patch leftover files and the like'
 	@echo  ''
 	@echo  'Configuration targets:'
 	@$(MAKE) -f $(srctree)/scripts/kconfig/Makefile help


