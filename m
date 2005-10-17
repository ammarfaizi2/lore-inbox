Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVJQJa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVJQJa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVJQJa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:30:59 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:34458 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932224AbVJQJa6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:30:58 -0400
Message-ID: <43536E01.8030203@cosmosbay.com>
Date: Mon, 17 Oct 2005 11:25:21 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: dipankar@in.ibm.com, Jean Delvare <khali@linux-fr.org>, torvalds@osdl.org,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017091422.GA18882@infradead.org>
In-Reply-To: <20051017091422.GA18882@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 17 Oct 2005 11:25:22 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig a écrit :
> On Mon, Oct 17, 2005 at 11:10:04AM +0200, Eric Dumazet wrote:
> 
>>Dont take me wrong : I really *need* the file RCU stuff added in 2.6.14.
> 
> 
> how so? and why should we care?  I'd rather see a 2.6.14 soon with
> the changes backed out so we can have a proper release that more or
> less sticks to the release schedule we agreed on at kernel summit.
> You'll have four weeks time to sort out the issue afterwards.
> -

Christoph,

You can try to hide the forest by killing some trees.

Are you sure that RCU 'file structs' is the only problem lying around ?

For instance, I think other RCU freeing problem are dormant (see maxbatch=10 
and think about the number of routes a busy router (or DOS attack) can handle...

Of course, a 'test program' is more difficult to write than a

while (1) close(open("/dev/null", 3));

Eric

