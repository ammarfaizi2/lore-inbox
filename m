Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbVI0WBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbVI0WBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbVI0WBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:01:24 -0400
Received: from mail.dvmed.net ([216.237.124.58]:50140 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965179AbVI0WBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:01:23 -0400
Message-ID: <4339C12C.5020004@pobox.com>
Date: Tue, 27 Sep 2005 18:01:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <4339440C.6090107@adaptec.com>	 <20050927131959.GA30329@infradead.org>  <43395ED0.6070504@adaptec.com> <1127836380.4814.36.camel@mulgrave> <43399F17.4090004@adaptec.com> <4339ACDA.3090801@pobox.com> <4339BD58.7060300@adaptec.com>
In-Reply-To: <4339BD58.7060300@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> The driver and the infrastructure needs to go in.
> 
> Give it exposure to the people, let people play with it.

Merging into the upstream kernel is not necessary for exposure.

Historically, saying "no" to a single vendor pushing really hard -- as 
you are doing -- has resulted in a superior solution.


> If we start "fixing" SCSI Core now (this in itself is JB red
> herring), how long before it is "fixed" and we can "rest"?
> And how long then before the driver and infrastructure
> makes it in?

Just follow the recipe Christoph outlined.  It's not difficult, just 
requires some work.


> At the end of the day the driver is not in, and business
> suffers.  And its not like the driver is using 
> static struct file_operations megasas_mgmt_fops, ;-)
> IOCTLs or other char dev for management...
> 
> The driver does _not_ alter anything in the kernel, it only
> integrates with it.
> 
> There needs to be a "passing gate":
> Linus, let the driver and transport layer in, as is and then
> patches "fixing SCSI Core" would start coming, naturally.
>>From people, from me, from everybody.

So far, this is an Adaptec-only solution.

It does an end run around 90% of the SCSI core.  You might as well make 
it a block driver, if you're going to do that.

	Jeff


