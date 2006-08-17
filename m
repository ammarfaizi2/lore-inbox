Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbWHQOpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWHQOpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWHQOpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:45:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:64177 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965062AbWHQOpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:45:18 -0400
Message-ID: <44E480FA.70806@pobox.com>
Date: Thu, 17 Aug 2006 10:45:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Jesse Huang <jesse@icplus.com.tw>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1/6] IP100A, add end of pci id table
References: <1155841247.4532.6.camel@localhost.localdomain>
In-Reply-To: <1155841247.4532.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Huang wrote:
> @@ -212,7 +212,7 @@ static const struct pci_device_id sundan
>  	{ 0x1186, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
>  	{ 0x13F0, 0x0201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5 },
>  	{ 0x13F0, 0x0200, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6 },
> -	{ }
> +	{ 0,}
>  };
>  MODULE_DEVICE_TABLE(pci, sundance_pci_tbl);
>  
> @@ -231,7 +231,7 @@ static const struct pci_id_info pci_id_t
>  	{"D-Link DL10050-based FAST Ethernet Adapter"},
>  	{"Sundance Technology Alta"},
>  	{"IC Plus Corporation IP100A FAST Ethernet Adapter"},
> -	{ }	/* terminate list. */
> +	{ NULL,}	/* terminate list. */

NAK.

An empty array element "{ }" implies NULL.  It is the kernel standard to 
prefer "{ }" over an explicit initialization.  Looks cleaner.

	Jeff


