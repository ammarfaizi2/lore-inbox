Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTEFWxn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTEFWwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:52:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:23226 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262032AbTEFWwm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:52:42 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10522624131723@kroah.com>
Subject: Re: [PATCH] PCI hotplug changes for 2.5.69
In-Reply-To: <10522624133520@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 16:06:53 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1083, 2003/05/06 15:35:34-07:00, greg@kroah.com

[PATCH] PCI Hotplug: fix compiler warning in ibm driver.


 drivers/hotplug/ibmphp_core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Tue May  6 15:55:54 2003
+++ b/drivers/hotplug/ibmphp_core.c	Tue May  6 15:55:54 2003
@@ -1417,7 +1417,7 @@
 
 	/* lock ourselves into memory with a module 
 	 * count of -1 so that no one can unload us. */
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 
 exit:
 	return rc;

