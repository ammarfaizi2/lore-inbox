Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVJZTxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVJZTxu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 15:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbVJZTxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 15:53:50 -0400
Received: from pip250.ish.de ([80.69.98.250]:16686 "EHLO mail01.ish.de")
	by vger.kernel.org with ESMTP id S964899AbVJZTxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 15:53:49 -0400
Message-ID: <435FDECB.5090803@crypto.rub.de>
Date: Wed, 26 Oct 2005 21:53:47 +0200
From: Marcel Selhorst <selhorst@crypto.rub.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051026)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kylene Jo Hall <kjhall@us.ibm.com>
Subject: Re: [PATCH] Infineon TPM: move infineon driver off pci_dev
References: <435FB8A5.803@crypto.rub.de> <435FBFC4.5060508@free.fr>
In-Reply-To: <435FBFC4.5060508@free.fr>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-14; AVE: 6.32.0.8; VDF: 6.32.0.118; host: mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthieu,

>> +    /* read IO-ports through PnP */
>> +    if (pnp_port_valid(dev, 0) &&
>> +        !(pnp_port_flags(dev, 0) & IORESOURCE_DISABLED)) {
>> +        TPM_INF_ADDR = pnp_port_start(dev, 0);
>> +        TPM_INF_DATA = (TPM_INF_ADDR + 1);
>> +        TPM_INF_BASE = pnp_port_start(dev, 1);
> 
> You should add a pnp_port_valid(dev, 1) check.
> If you are paranoid, you could also check the port len.
> 
> I don't remember if it is done somewhere, but a request_region should be
> used.

Thanks for that good hint, I'll take care of that tomorrow
and submit a new patch here.

Marcel Selhorst
