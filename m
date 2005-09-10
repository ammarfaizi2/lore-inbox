Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVIJU4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVIJU4m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVIJU4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:56:41 -0400
Received: from mail.dvmed.net ([216.237.124.58]:2453 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932296AbVIJU4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:56:40 -0400
Message-ID: <43234883.7090806@pobox.com>
Date: Sat, 10 Sep 2005 16:56:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 4/10] drivers/char: pci_find_device remove (drivers/char/rocket.c)
References: <200509101221.j8ACL9ad017242@localhost.localdomain>
In-Reply-To: <200509101221.j8ACL9ad017242@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
> --- a/drivers/char/rocket.c
> +++ b/drivers/char/rocket.c
> @@ -2234,7 +2234,7 @@ static int __init init_PCI(int boards_fo
>  	int count = 0;
>  
>  	/*  Work through the PCI device list, pulling out ours */
> -	while ((dev = pci_find_device(PCI_VENDOR_ID_RP, PCI_ANY_ID, dev))) {
> +	while ((dev = pci_get_device(PCI_VENDOR_ID_RP, PCI_ANY_ID, dev))) {
>  		if (register_PCI(count + boards_found, dev))
>  			count++;

convert to PCI probing, rather than this

	Jeff



