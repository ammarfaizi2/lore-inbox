Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbUJaOsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbUJaOsR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 09:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbUJaOrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 09:47:05 -0500
Received: from baikonur.stro.at ([213.239.196.228]:63200 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261641AbUJaOpc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 09:45:32 -0500
Date: Sun, 31 Oct 2004 15:45:03 +0100
From: maximilian attems <janitor@sternwelten.at>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Margit Schubert-While <margitsw@t-online.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, hvr@gnu.org,
       mcgrof@studorgs.rutgers.edu, kernel-janitors@lists.osdl.org,
       netdev@oss.sgi.com, Domen Puncer <domen@coderock.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 4/6] char/shwdt remove duplicate msecs_to_jiffies()
Message-ID: <20041031144503.GE28667@stro.at>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Margit Schubert-While <margitsw@t-online.de>,
	Nishanth Aravamudan <nacc@us.ibm.com>, hvr@gnu.org,
	mcgrof@studorgs.rutgers.edu, kernel-janitors@lists.osdl.org,
	netdev@oss.sgi.com, Domen Puncer <domen@coderock.org>,
	linux-kernel@vger.kernel.org
References: <20040923221303.GB13244@us.ibm.com> <20040923221303.GB13244@us.ibm.com> <5.1.0.14.2.20040924074745.00b1cd40@pop.t-online.de> <415CD9D9.2000607@pobox.com> <20041030222228.GB1456@stro.at> <41841886.2080609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41841886.2080609@pobox.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



remove duplicate msecs_to_jiffies() definition.
add include <delay.h>.

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>


---

 linux-2.4.28-rc1-max/drivers/char/shwdt.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/char/shwdt.c~remove-msecs_to_jiffies-drivers_char_shwdt drivers/char/shwdt.c
--- linux-2.4.28-rc1/drivers/char/shwdt.c~remove-msecs_to_jiffies-drivers_char_shwdt	2004-10-31 13:40:49.000000000 +0100
+++ linux-2.4.28-rc1-max/drivers/char/shwdt.c	2004-10-31 13:42:05.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/reboot.h>
 #include <linux/notifier.h>
 #include <linux/ioport.h>
+#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -113,7 +114,6 @@
  */
 static int clock_division_ratio = WTCSR_CKS_4096;
 
-#define msecs_to_jiffies(msecs)	(jiffies + (HZ * msecs + 9999) / 10000)
 #define next_ping_period(cks)	msecs_to_jiffies(cks - 4)
 
 static unsigned long shwdt_is_open;
_
