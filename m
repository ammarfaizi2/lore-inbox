Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTJTQrA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 12:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTJTQrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 12:47:00 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:14343 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S262674AbTJTQq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 12:46:58 -0400
To: linux-kernel@vger.kernel.org
Path: 127.0.0.1!nobody
From: Peter Matthias <espi@epost.de>
Newsgroups: linux.kernel
Subject: Re: ACM USB modem on Kernel 2.6.0-test
Date: Mon, 20 Oct 2003 18:54:56 +0200
Organization: Tiscali Germany
Message-ID: <0141nb.o9.ln@127.0.0.1>
References: <FwYB.Z9.25@gated-at.bofh.it> <HJ5m.2Eb.23@gated-at.bofh.it> <Inm6.60T.19@gated-at.bofh.it>
NNTP-Posting-Host: p62.246.77.223.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ulysses.news.tiscali.de 1066668231 95982 62.246.77.223 (20 Oct 2003 16:43:51 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Mon, 20 Oct 2003 16:43:51 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell schrieb:

>>>> In fact, here's a patch with that very change.  Does
>>>> it make current 2.6.0-test kernels work "out of the box"
>>>> again with your USB modems?
>>> 
>>> Yes, it works with ELSA Microlink USB. Thanks.
>> 
>> Hmm. Too early. I get either a "acm: probe of 3-3:2.1 failed with error
-5"
>> but it works or a 
>> Unable to handle kernel NULL pointer dereference at virtual address
00000008
>>  ...
>>  EIP:    0060:[usb_driver_claim_interface+67/112]    Tainted: P
>>  ...
> 
> Well, the "it works at all (without the sysfs write)" is
> what that patch was about -- so it's still a clear win!
> 
> But cdc-acm probe() is pretty broken, and I'm told it's
> had strange behavior in various other cases for a while,
> including some oopsing.  Like this; not a new bug.
> 
> Try this cdc-acm patch.  One user reported that it made
> oopsing go away, the bogus probe() errors stopped, and
> even the /proc/bus/usb/devices listings were finally
> right (both interfaces now claimed by cdc_acm).  Plus
> it should stop the pointless hotplugging of "cdc_acm"
> for Ethernet devices (including MSFT's RNDIS).

Yes, it works. I hope it will be integrated in 2.6.0.

Peter

