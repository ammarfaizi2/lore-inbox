Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUHYAnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUHYAnc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 20:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUHYAnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 20:43:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40126 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267700AbUHYAmC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 20:42:02 -0400
Message-ID: <412BE04F.3050306@pobox.com>
Date: Tue, 24 Aug 2004 20:41:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bjorn.helgaas@hp.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] hp100.c: add missing pci_enable_device()
References: <200408242225.i7OMP5ak029691@hera.kernel.org>
In-Reply-To: <200408242225.i7OMP5ak029691@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> diff -Nru a/drivers/net/hp100.c b/drivers/net/hp100.c
> --- a/drivers/net/hp100.c	2004-08-24 15:25:16 -07:00
> +++ b/drivers/net/hp100.c	2004-08-24 15:25:16 -07:00
> @@ -2910,10 +2910,15 @@
>  	int ioaddr = pci_resource_start(pdev, 0);
>  	u_short pci_command;
>  	int err;
> -	
> +
>  	if (!dev)
>  		return -ENOMEM;
>  
> +	if (pci_enable_device(pdev)) {


_Obviously_ incomplete change.  Look above, and see pci_resource_start()

	Jeff


