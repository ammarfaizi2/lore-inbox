Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263043AbTHVHct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 03:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbTHVHbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 03:31:31 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:20751 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262990AbTHVG7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 02:59:22 -0400
Date: Fri, 22 Aug 2003 03:58:39 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Kai Germaschewski <kkeil@suse.de>
Subject: [PATCH][resend] 3/13 2.4.22-rc2 fix __FUNCTION__ warnings
 drivers/isdn/hisax
Message-Id: <20030822035839.5ddc8e81.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

 st5481.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.4.22-rc2/drivers/isdn/hisax/st5481.h	2003-06-13 11:51:34.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/isdn/hisax/st5481.h	2003-08-21 00:08:28.000000000 -0300
@@ -219,13 +219,13 @@
 #define L1_EVENT_COUNT (EV_TIMER3 + 1)
 
 #define ERR(format, arg...) \
-printk(KERN_ERR __FILE__ ": " __FUNCTION__ ": " format "\n" , ## arg)
+printk(KERN_ERR __FILE__ ": %s: " format "\n" , __FUNCTION__ , ## arg)
 
 #define WARN(format, arg...) \
-printk(KERN_WARNING __FILE__ ": " __FUNCTION__ ": " format "\n" , ## arg)
+printk(KERN_WARNING __FILE__ ": %s: " format "\n" , __FUNCTION__ , ## arg)
 
 #define INFO(format, arg...) \
-printk(KERN_INFO __FILE__ ": " __FUNCTION__ ": " format "\n" , ## arg)
+printk(KERN_INFO __FILE__ ": %s: " format "\n" , __FUNCTION__ , ## arg)
 
 #include "isdnhdlc.h"
 #include "fsm.h"

ciao,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
