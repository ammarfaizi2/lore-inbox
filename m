Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWHUVw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWHUVw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 17:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWHUVw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 17:52:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28635 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751218AbWHUVwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 17:52:55 -0400
Subject: Re: [Patch] Signedness issue in drivers/net/3c515.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
In-Reply-To: <20060821140558.4cfee23c.akpm@osdl.org>
References: <1156009077.18374.1.camel@alice>
	 <20060821140558.4cfee23c.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Aug 2006 23:13:25 +0100
Message-Id: <1156198406.18887.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-21 am 14:05 -0700, ysgrifennodd Andrew Morton:
> 	/* Wait for the stall to complete. */
> 	for (i = 20; i >= 0; i--)
> 		if ((inw(ioaddr + EL3_STATUS) & CmdInProgress) == 0) 
> 			break;
> 
> Your fix will convert this indefinit wait into a bounded one.  It might
> cause the driver to malfunction.

The change is correct. The docs guarantee it can't take that long.

