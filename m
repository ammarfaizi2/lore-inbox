Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUAZUP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 15:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUAZUP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 15:15:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54426 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265136AbUAZUP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 15:15:28 -0500
Message-ID: <40157552.3040405@pobox.com>
Date: Mon, 26 Jan 2004 15:15:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       francis.wiran@hp.com
Subject: Re: [PATCH] cpqarray update
References: <200401262002.i0QK2iAH031857@hera.kernel.org>
In-Reply-To: <200401262002.i0QK2iAH031857@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1288, 2004/01/26 16:58:21-02:00, francis.wiran@hp.com
> 
> 	[PATCH] cpqarray update
> 	
> 	Yes, we should. I usually ask Mike Miller in our group to send my
> 	patches since he's been doing that and more known in the community, but
> 	since you already got a hold of it ...yes, please :)
> 	
> 	CHANGELOG:
> 	
> 	   * Fix for eisa card not detecting partitions properly
> 	   * Use pci_module_init instead of pci_register_device to handle hotplug
> 	     scenario and unregister if the driver can't find pci controller
> 	   * Add BLKSSZGET ioctl
[...]
> @@ -616,7 +623,7 @@
>  
>  	/* detect controllers */
>  	printk(DRIVER_NAME "\n");
> -	pci_register_driver(&cpqarray_pci_driver);
> +	pci_module_init(&cpqarray_pci_driver);
>  	cpqarray_eisa_detect();
>  
>  	for(i=0; i< MAX_CTLR; i++) {

You need to check the return value of pci_module_init() for errors.

	Jeff



