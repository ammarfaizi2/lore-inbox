Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291471AbSCMA6o>; Tue, 12 Mar 2002 19:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291477AbSCMA6e>; Tue, 12 Mar 2002 19:58:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:34177 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291471AbSCMA6a>;
	Tue, 12 Mar 2002 19:58:30 -0500
Date: Tue, 12 Mar 2002 16:56:09 -0800 (PST)
Message-Id: <20020312.165609.18574402.davem@redhat.com>
To: beezly@beezly.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dropped packets on SUN GEM
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1015979767.2652.77.camel@monkey>
In-Reply-To: <1015978127.2653.49.camel@monkey>
	<20020312.161057.18308390.davem@redhat.com>
	<1015979767.2652.77.camel@monkey>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Beezly <beezly@beezly.org.uk>
   Date: 13 Mar 2002 00:36:07 +0000

   Sorry to be vague,

No problem.  If you add this patch below does it make Pause get
negotiated on?  Please print everything the driver says from module
load to the time the link comes up.

Thank you.

--- drivers/net/sungem.c.~1~	Tue Mar 12 09:35:37 2002
+++ drivers/net/sungem.c	Tue Mar 12 16:53:44 2002
@@ -1792,7 +1792,7 @@
 		 */
 		val = readl(gp->regs + PCS_MIIADV);
 		val |= (PCS_MIIADV_FD | PCS_MIIADV_HD |
-			PCS_MIIADV_SP);
+			PCS_MIIADV_SP | PCS_MIIADV_AP);
 		writel(val, gp->regs + PCS_MIIADV);
 
 		/* Enable and restart auto-negotiation, disable wrapback/loopback,

