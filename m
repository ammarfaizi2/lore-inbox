Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135284AbRECWmT>; Thu, 3 May 2001 18:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135328AbRECWmN>; Thu, 3 May 2001 18:42:13 -0400
Received: from sovereign.org ([209.180.91.170]:56243 "EHLO lux.homenet")
	by vger.kernel.org with ESMTP id <S135284AbRECWl4>;
	Thu, 3 May 2001 18:41:56 -0400
From: Jim Freeman <jfree@sovereign.org>
Date: Thu, 3 May 2001 16:42:06 -0600
To: linux-kernel@vger.kernel.org
Subject: iproute2, ETH_P_ECHO, linux/if_ether.h
Message-ID: <20010503164206.A19818@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iproute2 compiles against 2.4.4 die.


Documentation/Changes sez:

	Ip-route2 
	---------
	o  <ftp://ftp.inr.ac.ru/ip-routing/iproute2-2.2.4-now-ss991023.tar.gz>


But iproute2's lib/ll_proto.c  tries to use ETH_P_ECHO from
linux/if_ether.h, and that manifest constant has (recently ?)
been yanked?


--- linux-2.4.2/include/linux/if_ether.h	Fri Oct 27 12:03:14 2000
+++ linux-2.4.4/include/linux/if_ether.h	Thu Apr 19 09:38:50 2001
@@ -37,12 +37,14 @@
  */
 
 #define ETH_P_LOOP	0x0060		/* Ethernet Loopback packet	*/
-#define ETH_P_ECHO	0x0200		/* Ethernet Echo packet		*/
-#define ETH_P_PUP	0x0400		/* Xerox PUP packet		*/
+#define ETH_P_PUP	0x0200		/* Xerox PUP packet		*/
+#define ETH_P_PUPAT	0x0201		/* Xerox PUP Addr Trans packet	*/
 #define ETH_P_IP	0x0800		/* Internet Protocol packet	*/
...
