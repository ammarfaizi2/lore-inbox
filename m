Return-Path: <linux-kernel-owner+w=401wt.eu-S933239AbWLaWXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933239AbWLaWXQ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 17:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933240AbWLaWXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 17:23:16 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:38128 "HELO
	smtp101.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933239AbWLaWXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 17:23:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:Subject:Date:User-Agent:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=QhxHNOoaIWnlbKqEdd8GwvwPedq9ovH9g+TULYw6qzxpwxMjOC3Znc34sNDuT9sxIKJxv9OSI21W62WnZPVGf4Dl6AnNTPZEcbRopA2EsUoOyxcXxODlPzgMloPNHIGQPnfE7/8uBrEVONmcEd5x1lBdei5h97rCKjX09Nw1bIE=  ;
X-YMail-OSG: 4tyCfsIVM1l2kD6ygSHAG5GtG.IxYT_EsEpHsqJpVynMlY01gjwePWWxGC2tYkWd6nNKZaUkjry5Up7RcCC0OeJ13yEE9QhxC59hqAUdQj9l.qGd1N8FFqcMlT5gmfbynrWXeej0IdWAmq8-
From: David Brownell <david-b@pacbell.net>
Subject: Fwd: [patch 2.6.19-rc1] rtc-at91rm9200 build fix
Date: Sun, 31 Dec 2006 14:23:13 -0800
User-Agent: KMail/1.7.1
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: rtc-linux@googlegroups.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612311423.13502.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch still needs merging ...

BTW, glad to see googlegroups finally returns rtc-linux when
I search for it ... :)

----------  Forwarded Message  ----------

Subject: [patch 2.6.19-rc1] rtc-at91rm9200 build fix
Date: Saturday 16 December 2006 3:38 pm
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Andrew Victor <andrew@sanpeople.com>

The at91rm9200 RTC driver needs some assistance to build, because of
recent header file rearrangement.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: at91/drivers/rtc/rtc-at91rm9200.c
===================================================================
--- at91.orig/drivers/rtc/rtc-at91rm9200.c	2006-12-15 10:13:47.000000000 -0800
+++ at91/drivers/rtc/rtc-at91rm9200.c	2006-12-15 13:06:02.000000000 -0800
@@ -33,6 +33,8 @@
 
 #include <asm/mach/time.h>
 
+#include <asm/arch/at91_rtc.h>
+
 
 #define AT91_RTC_FREQ		1
 #define AT91_RTC_EPOCH		1900UL	/* just like arch/arm/common/rtctime.c */


-------------------------------------------------------
