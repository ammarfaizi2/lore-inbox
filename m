Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUDSQnF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUDSQmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:42:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34445 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261405AbUDSQkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:40:51 -0400
Message-ID: <40840106.80403@pobox.com>
Date: Mon, 19 Apr 2004 12:40:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Francois Romieu <romieu@fr.zoreil.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: rcpci45 dereference fix.
References: <20040416212342.GG25240@redhat.com> <20040416224506.A2769@electric-eye.fr.zoreil.com> <20040416215037.GV20937@redhat.com>
In-Reply-To: <20040416215037.GV20937@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, Apr 16, 2004 at 10:45:06PM +0200, Francois Romieu wrote:
> 
>  > rcpci45_init_one() must succeed in order for rcpci45_remove_one() to be
>  > issued.
>  > 
>  > If rcpci45_init_one() succeeds, dev can not be NULL.
>  > 
>  > So I'd rather see the "if (!dev) {" test removed instead of this change.
> 
> Sure.
> 
> 		Dave
> 
> --- drivers/net/rcpci45.c~	2004-04-16 22:22:22.000000000 +0100
> +++ drivers/net/rcpci45.c	2004-04-16 22:49:54.000000000 +0100
> @@ -131,12 +131,6 @@
>  	struct net_device *dev = pci_get_drvdata (pdev);
>  	PDPA pDpa = dev->priv;
>  
> -	if (!dev) {
> -		printk (KERN_ERR "%s: remove non-existent device\n",
> -				dev->name);
> -		return;
> -	}
> -


Manually applied, since it's not in standard "patch -sp1" format.

	Jeff



