Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVCPNNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVCPNNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 08:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVCPNNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 08:13:55 -0500
Received: from khc.piap.pl ([195.187.100.11]:2052 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S262565AbVCPNNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 08:13:53 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11.4
References: <20050316002222.GA30602@kroah.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 16 Mar 2005 14:11:43 +0100
In-Reply-To: <20050316002222.GA30602@kroah.com> (Greg KH's message of "Tue,
 15 Mar 2005 16:22:22 -0800")
Message-ID: <m3u0nbybu8.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Greg KH <greg@kroah.com> writes:

> I've release 2.6.11.4 with two security fixes in it.  It can be found at
> the normal kernel.org places.

How about the N2/C101/PCI200SYN WAN driver fix (kernel panic on receive)?

Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>

-- 
Krzysztof Halasa

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=hdlc-skb-dev-only.patch

--- linux/drivers/net/wan/hd6457x.c	28 Oct 2004 06:16:08 -0000	1.15
+++ linux/drivers/net/wan/hd6457x.c	1 Mar 2005 00:58:08 -0000
@@ -315,7 +315,7 @@
 #endif
 	stats->rx_packets++;
 	stats->rx_bytes += skb->len;
-	skb->dev->last_rx = jiffies;
+	dev->last_rx = jiffies;
 	skb->protocol = hdlc_type_trans(skb, dev);
 	netif_rx(skb);
 }

--=-=-=--
