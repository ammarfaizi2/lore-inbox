Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269441AbUINPrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269441AbUINPrA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269438AbUINPny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:43:54 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:19352 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S269416AbUINPlA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:41:00 -0400
Message-ID: <414710AA.80706@rtr.ca>
Date: Tue, 14 Sep 2004 11:39:22 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net> <20040914060628.GC2336@suse.de> <1095156346.16572.2.camel@localhost.localdomain> <41470BBD.7060700@pobox.com> <20040914152509.GA27892@suse.de> <41470F3A.1060308@rtr.ca>
In-Reply-To: <41470F3A.1060308@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
>> Alan says it's unsafe for some of his flash cards, and I do believe they
>> say they have write caching enabled.
> 
> Flash cards should be detectable --> many of them will claim
> to implement the CFA feature set.

One obvious safeguard would be to never use FLUSH_CACHE on any
drive that lacks UDMA, unless the drive claims to support FLUSH_CACHE.

That will eliminate all current FLASH memory devices.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
