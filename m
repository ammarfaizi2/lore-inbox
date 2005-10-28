Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbVJ1FYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbVJ1FYN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 01:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbVJ1FYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 01:24:12 -0400
Received: from pip251.ish.de ([80.69.98.251]:35006 "EHLO mail01.ish.de")
	by vger.kernel.org with ESMTP id S965101AbVJ1FYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 01:24:11 -0400
Message-ID: <4361B5E5.6090507@crypto.rub.de>
Date: Fri, 28 Oct 2005 07:23:49 +0200
From: Marcel Selhorst <selhorst@crypto.rub.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051026)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, castet.matthieu@free.fr, kjhall@us.ibm.com
Subject: Re: [PATCH] Infineon TPM: move infineon driver off pci_dev
References: <435FB8A5.803@crypto.rub.de>	<435FBFC4.5060508@free.fr>	<4360B889.1010502@crypto.rub.de> <20051027143332.08269850.akpm@osdl.org>
In-Reply-To: <20051027143332.08269850.akpm@osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-14; AVE: 6.32.0.8; VDF: 6.32.0.120; host: mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> This final return will leak the I/O region from request_region().
> If for some reason the leak is deliberate then a comment is needed.

yep, you're right, I'll fix that

> To reduce the chance of this happening again, please send a followup patch
> which prevents this function from having `return' statements sprinkled all
> over it.  An example would be drivers/net/8139cp.c:cp_init_one(), thanks.

I will send a follow-up patch including the comments of Matthieu.

Thanks for reviewing!

Marcel
