Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVGSKVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVGSKVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 06:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVGSKVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 06:21:41 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:46937 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261479AbVGSKVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 06:21:40 -0400
Message-ID: <42DCD445.6080102@gentoo.org>
Date: Tue, 19 Jul 2005 11:21:57 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?TWFydGluIFBvdm9sbsO9?= <martin.povolny@solnet.cz>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Promise TX4200 support?
References: <42DBFC9E.1040607@gentoo.org> <42DC0A99.2010304@solnet.cz> <42DC2F44.7000708@gentoo.org> <42DC835E.7030301@solnet.cz>
In-Reply-To: <42DC835E.7030301@solnet.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Povolný wrote:
> For me it works with 20319, but I don't understand the difference
> between different settings.

20319 is 4 port SATA.
2037x is 2 port SATA, optionally with 1 PATA port
20619 is 4 port PATA

So I believe 20319 is the correct option.

Jeff, the chip on the TX4200 is actually a PDC40519 but it meets the 
description of the 20319. Is something like the patch below ok, or should we 
add a new board_ entry?

> *** sata_promise.c	2005-05-11 21:22:20.000000000 +0200
> --- sata_promise_new.c	2005-05-11 21:22:02.000000000 +0200
> ***************
> *** 164,171 ****
> --- 164,173 ----
>   	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>   	  board_20319 },
>   	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>   	  board_20319 },
> + 	{ PCI_VENDOR_ID_PROMISE, 0x3519, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> + 	  board_20319 },
>   	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>   	  board_20319 },
> 
>   	{ }	/* terminate list */


Thanks,
Daniel
