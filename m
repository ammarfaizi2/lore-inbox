Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267663AbUBTBnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUBTBnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:43:21 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:14810 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267663AbUBTBkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:40:46 -0500
Message-ID: <40356599.3080001@cyberone.com.au>
Date: Fri, 20 Feb 2004 12:40:41 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: miquels@cistron.nl, axboe@suse.de, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, thornber@redhat.com
Subject: Re: [PATCH] per process request limits (was Re: IO scheduler, queue
 depth, nr_requests)
References: <20040216133047.GA9330@suse.de>	<20040217145716.GE30438@traveler.cistron.net>	<20040218235243.GA30621@drinkel.cistron.nl>	<20040218172622.52914567.akpm@osdl.org>	<20040219021159.GE30621@drinkel.cistron.nl>	<20040218182628.7eb63d57.akpm@osdl.org>	<20040219101519.GG30621@drinkel.cistron.nl>	<20040219101915.GJ27190@suse.de>	<20040219205907.GE32263@drinkel.cistron.nl>	<40353E30.6000105@cyberone.com.au>	<20040219235303.GI32263@drinkel.cistron.nl>	<40355F03.9030207@cyberone.com.au> <20040219172656.77c887cf.akpm@osdl.org>
In-Reply-To: <20040219172656.77c887cf.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>Even with this patch, it might still be a good idea to allow
>>pdflush to disregard the limits...
>>
>
>Has it been confirmed that pdflush is blocking in get_request_wait()?  I
>guess that can happen very occasionally because we don't bother with any
>locking around there but if it's happening a lot then something is bust.
>
>

Miquel's analysis is pretty plausible, but I'm not sure if
he's confirmed it or not, Miquel? Even if it isn't happening
a lot, and something isn't bust it might be a good idea to
do this.


