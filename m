Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265769AbUATT4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbUATT4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:56:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:1972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265769AbUATT4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:56:38 -0500
Date: Tue, 20 Jan 2004 11:57:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: linux@brodo.de, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: limit-timer_pm-printk-storms.patch
Message-Id: <20040120115751.5e4441bc.akpm@osdl.org>
In-Reply-To: <20040120212514.43e31237.bonganilinux@mweb.co.za>
References: <20040120212514.43e31237.bonganilinux@mweb.co.za>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bongani Hlope <bonganilinux@mweb.co.za> wrote:
>
> This patch has been inspired by the limit-IO-error-printk-storms patch. On my PII when I enable 
> CONFIG_X86_PM_TIMER this gets called a lot of times, I guess my VIA chipset is too broken to play with this.
> 
> <example>
> ...
> Jan 19 04:21:46 bongani kernel: bad pmtmr read: (15567390, 15567423, 15567393)
> Jan 19 04:21:46 bongani kernel: bad pmtmr read: (1746710, 1746719, 1746713)
> Jan 19 04:21:47 bongani kernel: bad pmtmr read: (2239982, 2239999, 2239986)

Does the PM timer actually do the right thing once these printk's are
suppressed?

If not, it would be better to recover somehow - presumably by blacklisting
this machine or by falling back to a different time source.  Possible?


