Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbVIZBMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbVIZBMK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 21:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbVIZBMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 21:12:10 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:41046 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751593AbVIZBMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 21:12:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vaUgdwDvrVGXew9OtdoenhXN61dey71mtLMg6sFzUIqCerIuhxSisk0U/lREi1yn1R7BqaNWHS1WkSr+9sVU9PWwR27Ag9Rukg/2o7kMVzEHeGur3Wi/ErAvxtL2i3g8TUc54pVkFAfyP3vYiHnU2VmtD3Y8XCCmwBxKioQagQo=  ;
Message-ID: <43374AC6.8070805@yahoo.com.au>
Date: Mon, 26 Sep 2005 11:11:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
CC: Tejun Heo <htejun@gmail.com>, zwane@linuxpower.ca, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6 04/04] brsem: convert cpucontrol to brsem
References: <20050925064218.E7558977@htj.dyndns.org> <20050925064218.642A9DFD@htj.dyndns.org> <4336542D.4000102@yahoo.com.au> <20050925234603.GA3577@otto>
In-Reply-To: <20050925234603.GA3577@otto>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch wrote:

>Nick Piggin wrote:
>
>>
>>Note that I happen to also think the idea (brsems) have merit, and
>>that cpucontrol may be one of the places where a sane implementation
>>would actually be useful... but at least when you're introducing
>>this kind of complexity anywhere, you *really* need to be able to
>>back it up with numbers.
>>
>
>The only performance-related complaint with cpu hotplug of which I'm
>aware -- that taking a cpu down on a large system can be painfully
>slow -- resides in the "write side" of the code, which is not the case
>that the brsem implementation optimizes.  I think this patch would
>make that case even worse.  So I don't think it's appropriate to use a
>brsem for cpu hotplug, especially without trying rwsem first.
>
>

I'm not sure that a brsem would make a noticable difference.

It isn't that cpu hotplug semaphore is a performance problem
now, but that it isn't being used in as many cases as it could
be due to its unscalable nature. For example, a while back I
wanted to use it in the fork() path in the scheduler but
couldn't.

Anyway, as I said, you need to be able to back it up with
numbers ;)

Nick


Send instant messages to your online friends http://au.messenger.yahoo.com 
