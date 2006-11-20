Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966445AbWKTTHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966445AbWKTTHJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966440AbWKTTHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:07:09 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:41693 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S966445AbWKTTHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:07:08 -0500
Message-ID: <4561FC26.6040505@oracle.com>
Date: Mon, 20 Nov 2006 11:04:06 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@serpentine.com>
CC: rdreier@cisco.com, lkml <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: ipath uses skb functions
References: <20061119125106.0ea9541e.randy.dunlap@oracle.com> <4561F9EA.1020402@serpentine.com>
In-Reply-To: <4561F9EA.1020402@serpentine.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan wrote:
> Randy Dunlap wrote:
>> but doesn't depends on NET (Networking).
> 
> Thanks.  One-liner patch attached.  Roland, please add this to your 
> for-2.6.19 or for-2.6.20 queue, as you see fit.
> 
>     <b

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

> ------------------------------------------------------------------------
> 
> IB/ipath - make Kconfig depend on CONFIG_NET
> 
> Spotted by Randy Dunlap.
> 
> Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>
> 
> diff -r 9769053d8f77 drivers/infiniband/hw/ipath/Kconfig
> --- a/drivers/infiniband/hw/ipath/Kconfig	Tue Nov 14 10:07:29 2006 -0800
> +++ b/drivers/infiniband/hw/ipath/Kconfig	Mon Nov 20 10:51:25 2006 -0800
> @@ -1,6 +1,6 @@ config INFINIBAND_IPATH
>  config INFINIBAND_IPATH
>  	tristate "QLogic InfiniPath Driver"
> -	depends on (PCI_MSI || HT_IRQ) && 64BIT && INFINIBAND
> +	depends on (PCI_MSI || HT_IRQ) && 64BIT && INFINIBAND && NET
>  	---help---
>  	This is a driver for QLogic InfiniPath host channel adapters,
>  	including InfiniBand verbs support.  This driver allows these


-- 
~Randy
