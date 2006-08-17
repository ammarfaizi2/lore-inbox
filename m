Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbWHQPTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbWHQPTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWHQPTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:19:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:30953 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965131AbWHQPTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:19:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=KyyPoWK/Wjhw2Tr2y73fShyuyNUC14uLzxqQVt0qz+hdr7cG/S6aYDQVI2GrmsLfsCXDXeVsHF4xIGRe/YFCkQ9DdJTWCvMUYGb63u56dFfAGTduiWMMYwgxW/4a69Rn54XviDpM5rLhQiUwnHLCqRmgq/rrEst6jGhkIPh7mtQ=
Date: Thu, 17 Aug 2006 19:19:45 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [PATCH 1/6] IP100A, add end of pci id table
Message-ID: <20060817151945.GC5205@martell.zuzino.mipt.ru>
References: <1155841247.4532.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155841247.4532.6.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 03:00:47PM -0400, Jesse Huang wrote:
> Add "0," and "NULL," to sundance_pci_tbl and pci_id_table.

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

They are already properly terminated. You don't have to do anything.

