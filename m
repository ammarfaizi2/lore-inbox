Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291640AbSCMBR4>; Tue, 12 Mar 2002 20:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291745AbSCMBRp>; Tue, 12 Mar 2002 20:17:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:43393 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291640AbSCMBRb>;
	Tue, 12 Mar 2002 20:17:31 -0500
Date: Tue, 12 Mar 2002 17:15:09 -0800 (PST)
Message-Id: <20020312.171509.08315746.davem@redhat.com>
To: beezly@beezly.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dropped packets on SUN GEM
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1015981634.2652.82.camel@monkey>
In-Reply-To: <1015979767.2652.77.camel@monkey>
	<20020312.165609.18574402.davem@redhat.com>
	<1015981634.2652.82.camel@monkey>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Beezly <beezly@beezly.org.uk>
   Date: 13 Mar 2002 01:07:14 +0000
   
   It doesn't appear to :(
...   
   eth0: Pause is disabled

Some day I will learn how to program, you do have
Pause enabled I just don't know how to print that
our properly from the driver :-)

--- drivers/net/sungem.c.~2~	Tue Mar 12 16:53:44 2002
+++ drivers/net/sungem.c	Tue Mar 12 17:14:26 2002
@@ -1213,15 +1213,15 @@
 
 	if (netif_msg_link(gp)) {
 		if (pause) {
-			printk(KERN_INFO "%s: Pause is disabled\n",
-			       gp->dev->name);
-		} else {
 			printk(KERN_INFO "%s: Pause is enabled "
 			       "(rxfifo: %d off: %d on: %d)\n",
 			       gp->dev->name,
 			       gp->rx_fifo_sz,
 			       gp->rx_pause_off,
 			       gp->rx_pause_on);
+		} else {
+			printk(KERN_INFO "%s: Pause is disabled\n",
+			       gp->dev->name);
 		}
 	}
 
