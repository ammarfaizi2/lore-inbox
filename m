Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269313AbUINLkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269313AbUINLkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269299AbUINLih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:38:37 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:10164 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S269313AbUINLhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:37:23 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Date: Tue, 14 Sep 2004 07:37:22 -0400
User-Agent: KMail/1.7
Cc: Jens Axboe <axboe@suse.de>, "C.Y.M." <syphir@syphir.sytes.net>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
References: <20040914060628.GC2336@suse.de> <20040914070649.GI2336@suse.de> <20040914071555.GJ2336@suse.de>
In-Reply-To: <20040914071555.GJ2336@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409140737.22408.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.51.156] at Tue, 14 Sep 2004 06:37:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 September 2004 03:15, Jens Axboe wrote:
>On Tue, Sep 14 2004, Jens Axboe wrote:
>> They do support it, they just don't flag the support in the
>> capability flags. And of course some don't support it at all, you
>> can try this on your drives if you want to know for sure.
>
>Forgot to attach the code, here it is...
Handy tool, thanks.
[...]

Running 2.6.9-rc1-mm5 ATM.

This code returns, hdd is a new 200GB WD:
[root@coyote src]# ./cache-flush-test /dev/hdd
issuing FLUSH_CACHE: worked
issuing FLUSH_CACHE_EXT: worked

And hda is an older 120GB Maxtor
[root@coyote src]# ./cache-flush-test /dev/hda
issuing FLUSH_CACHE: worked
issuing FLUSH_CACHE_EXT: failed 0x51/0x4!

Is this the real cause of my aborted journal on / 3 or 4 days ago?  I 
was running -rc1-mm2 at the time.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
