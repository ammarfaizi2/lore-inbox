Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266054AbUFPBNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbUFPBNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 21:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266055AbUFPBNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 21:13:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54267 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266054AbUFPBNP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 21:13:15 -0400
Date: Tue, 15 Jun 2004 18:13:11 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Export pm_suspend
Message-ID: <20040616011311.GA9256@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow modules to request system suspend via the in-kernel interface, if
desired.

--- linux-2.6.7-rc3-orig/kernel/power/main.c	2004-06-09 12:30:50.000000000 -0700
+++ linux-2.6.7-rc3-pm/kernel/power/main.c	2004-06-15 17:08:43.321439984 -0700
@@ -257,3 +257,5 @@
 }
 
 core_initcall(pm_init);
+
+EXPORT_SYMBOL(pm_suspend);


From: Dmitry Vorobiev <dvorobiev@ru.mvista.com>
Signed-off-by: Todd Poynor <tpoynor@mvista.com>
