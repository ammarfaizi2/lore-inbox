Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263569AbVBDTJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263569AbVBDTJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbVBDTFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:05:36 -0500
Received: from [205.233.219.253] ([205.233.219.253]:46736 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S261945AbVBDTBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 14:01:25 -0500
Date: Fri, 4 Feb 2005 14:00:35 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Steffen Zieger <lkml@steffenspage.de>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       dan@dennedy.org
Subject: Re: [Patch] eth1394: Change KERN_ERR to KERN_INFO
Message-ID: <20050204190035.GG21958@conscoop.ottawa.on.ca>
References: <200502031528.51523.lkml@steffenspage.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502031528.51523.lkml@steffenspage.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 03:28:41PM +0100, Steffen Zieger wrote:
> Hello list,
> 
> on boot eth1394 prints the following message to KERN_ERR, but I think it is 
> better printing to KERN_INFO, because it _is_ an informational message only 
> (or: I think so).
> This is the message I mean:
> eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
> 
> The patch should apply against kernel 2.6.11-rc2 cleanly

1. Please add Signed-off-by (see Documentation/SubmittingPatches ).

2. Please produce patches that apply -p1.

3. Please cc linux1394-devel@lists.sourceforge.net.

I made a new patch that applies to linux1394 SVN.  Dan, if you agree with
this change, please apply.

Thanks,
Jody

> 
> HAND,
> Steffen
> -- 
> Freiheit ist die Freiheit zu sagen, dass zwei und zwei gleich vier ist.
> Sobald das gew?hrleistet ist, ergibt sich alles andere von selbst.
> 1984 - George Orwell

> --- drivers/ieee1394/eth1394.c.orig	2005-02-03 08:48:34.884410376 +0100
> +++ drivers/ieee1394/eth1394.c	2005-02-03 08:48:58.948752040 +0100
> @@ -626,7 +626,7 @@
>  		goto out;
>  	}
>  
> -	ETH1394_PRINT (KERN_ERR, dev->name, "IEEE-1394 IPv4 over 1394 Ethernet (fw-host%d)\n",
> +	ETH1394_PRINT (KERN_INFO, dev->name, "IEEE-1394 IPv4 over 1394 Ethernet (fw-host%d)\n",
>  		       host->id);
>  
>  	hi->host = host;



Change the initialization message for eth1394 to KERN_INFO, requested by
Steffen Zieger <lkml@steffenspage.de>

Signed-off-by: Jody McIntyre <scjody@modernduck.com>

Index: ieee1394/eth1394.c
===================================================================
--- ieee1394.orig/eth1394.c	2005-02-04 13:50:52.549918592 -0500
+++ ieee1394/eth1394.c	2005-02-04 13:53:04.648836504 -0500
@@ -625,7 +625,7 @@ static void ether1394_add_host (struct h
 		goto out;
 	}
 
-	ETH1394_PRINT (KERN_ERR, dev->name, "IEEE-1394 IPv4 over 1394 Ethernet (fw-host%d)\n",
+	ETH1394_PRINT (KERN_INFO, dev->name, "IEEE-1394 IPv4 over 1394 Ethernet (fw-host%d)\n",
 		       host->id);
 
 	hi->host = host;






