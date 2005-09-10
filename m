Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVIJU6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVIJU6z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVIJU6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:58:54 -0400
Received: from mail.dvmed.net ([216.237.124.58]:9877 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932301AbVIJU6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:58:54 -0400
Message-ID: <43234909.8040707@pobox.com>
Date: Sat, 10 Sep 2005 16:58:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 10/10] drivers/char: pci_find_device remove (drivers/char/watchdog/i8xx_tco.c)
References: <200509101221.j8ACLAOV017267@localhost.localdomain>
In-Reply-To: <200509101221.j8ACLAOV017267@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> diff --git a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
> --- a/drivers/char/watchdog/i8xx_tco.c
> +++ b/drivers/char/watchdog/i8xx_tco.c
> -	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
> +	for_each_pci_dev(dev)
>  		if (pci_match_id(i8xx_tco_pci_tbl, dev)) {
>  			i8xx_tco_pci = dev;
>  			break;
>  		}
> -	}


Surely there is a better way to handle bridge matching?

	Jeff


