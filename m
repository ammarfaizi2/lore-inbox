Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269404AbUINPfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269404AbUINPfy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269422AbUINPfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:35:53 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:16280 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S269404AbUINPdh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:33:37 -0400
Message-ID: <41470EEF.8070005@rtr.ca>
Date: Tue, 14 Sep 2004 11:31:59 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
       "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net>	 <20040914060628.GC2336@suse.de> <1095156346.16572.2.camel@localhost.localdomain> <41470BBD.7060700@pobox.com>
In-Reply-To: <41470BBD.7060700@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That all looks pretty safe to me.  I wouldn't touch it.

But one could augment it with a check of the ATA revision code,
and possibly exclude drives that predate the *formal* introduction
of the FLUSH_CACHE command, unless their IDENTIFY data specifically
claims to include it.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
