Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbVJSTnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVJSTnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 15:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVJSTnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 15:43:50 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:18018 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750880AbVJSTnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 15:43:49 -0400
Message-ID: <4356A1F5.5010200@gentoo.org>
Date: Wed, 19 Oct 2005 20:43:49 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] skge support for Marvell chips in Toshiba laptops
References: <200510191047.53212.jbarnes@virtuousgeek.org>
In-Reply-To: <200510191047.53212.jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

Jesse Barnes wrote:
> Here's a small patch to add the PCI ID and chip type of the chip in my 
> Toshiba laptop to the skge driver.  I haven't tested it much (just 
> insmoded it and run ethtool against the corresponding eth1 device), but 
> it doesn't crash my system, so unless this configuration has already 
> been tested and is known to have problems, it might be good to add this 
> patch.
> 
> I'll test some more with a real network when I get home.

The device ID you added (0x4351) is already claimed by the new sky2 driver.

Unless theres a mistake in sky2's device table, your laptop contains a 
Yukon-II adapter which is incompatible with the original Yukon chips (skge = 
Yukon, sky2 = Yukon-II).

On the other hand, I believe Stephen could do with some extra sky2 testing :)
You can find it in the latest -mm releases.

Daniel
