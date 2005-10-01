Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVJAAit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVJAAit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 20:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVJAAis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 20:38:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:26505 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750705AbVJAAis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 20:38:48 -0400
Message-ID: <433DDA8F.6050203@pobox.com>
Date: Fri, 30 Sep 2005 20:38:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       Patrick Mansfield <patmans@us.ibm.com>, ltuikov@yahoo.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org>	 <433D8542.1010601@adaptec.com> <1128113158.12267.29.camel@mulgrave> <433DB6BE.4020706@adaptec.com>
In-Reply-To: <433DB6BE.4020706@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> I'm sure you'll do whatever humanly possible to show
> that _your_ idea can be applied: you can do this now:
> just use a big if () { ... } else { ... } statement and
> you're done.

This is not how we do things in Linux.  You're doubling the maintenance 
burden.

If you really want to do this, at least don't fill up drivers/scsi/ with 
an additional, completely unrelated codepath.


> Furthermore I do not see the reasons to umbrella both
> "aic94xx and LSI cards" when they are _completely different_
> in architecture: MPT and open transport (ala USB Storage and SBP).

There is commonality between aic94xx and MPT/LSI stuff.  aic94xx SAS 
transport layer is a superset of MPT/LSI SAS transport:  it clearly 
needs far more management code.

We understand this.  The part you don't understand is that we want to 
emphasize the commonality, rather than let aic94xx and MPT/LSI go in 
completely different directions.

Read it again:  aic94xx/BCMxxx is a superset of functionality, not 
completely different.

	Jeff


