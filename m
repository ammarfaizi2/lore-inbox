Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTIZL5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 07:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTIZL5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 07:57:18 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:45306 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262061AbTIZL5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 07:57:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: s390 patches: descriptions.
Date: Fri, 26 Sep 2003 13:51:38 +0200
User-Agent: KMail/1.5.3
Cc: Pete Zaitcev <zaitcev@redhat.com>
X-PRIORITY: 2 (High)
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309261347.25861.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Pete,
> 
> > Are you going to submit zfcp and zcrypt and if yes, when?
> 
> The zfcp rework is going well but isn't quite finished yet.
> It's up to Heiko when he consideres the driver to be in state
> for inclusion into 2.6. For the zcrypt driver the news aren't
> so good. It very likely won't make it for 2.6.0.

Actually, the latest z90crypt driver for 2.4.21 compiles on 2.6
with only one trivial patch (see below). The chances are good
that it works just as much as on older kernels. It's mostly
just a matter of style and the fact that there is no standard
API for linux hardware crypto driver yet that keeps us from
submitting the driver.

	Arnd <><

diff -u ../linux-2.3/drivers/s390/misc/z90main.c drivers/s390/misc/z90main.c
--- ../linux-2.3/drivers/s390/misc/z90main.c	2003-08-18 18:51:14.000000000 +0200
+++ drivers/s390/misc/z90main.c	2003-09-26 13:15:49.000000000 +0200
@@ -567,7 +567,6 @@
 	int result,nresult;
 	struct proc_dir_entry * entry;
 
-	EXPORT_NO_SYMBOLS;
 	PDEBUG("init_module -> PID %d\n", PID());
 
 	//

