Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVK0Qcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVK0Qcl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 11:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVK0Qcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 11:32:41 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:55482 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1751103AbVK0Qck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 11:32:40 -0500
Message-ID: <4389DFA1.7000105@shadowconnect.com>
Date: Sun, 27 Nov 2005 17:32:33 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/message/i2o/pci.c: fix a NULL pointer dereference
References: <20051126233705.GD3988@stusta.de>
In-Reply-To: <20051126233705.GD3988@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Adrian Bunk wrote:
> The Coverity checker spotted this obvious NULL pointer dereference.
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com

> This patch was already sent on:
> - 23 Nov 2005
> - 21 Nov 2005

Sorry, didn't know i have to answer to it. Next time i will respond earlier.

Thank you very much for this patch!

> --- linux-2.6.15-rc1-mm2-full/drivers/message/i2o/pci.c.old	2005-11-20 21:50:45.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/message/i2o/pci.c	2005-11-20 21:51:08.000000000 +0100
> @@ -421,8 +421,8 @@
>  	i2o_pci_free(c);
>  
>        free_controller:
> -	i2o_iop_free(c);
>  	put_device(c->device.parent);
> +	i2o_iop_free(c);
>  
>        disable:
>  	pci_disable_device(pdev);
