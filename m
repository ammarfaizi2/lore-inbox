Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUCKSSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbUCKSSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:18:53 -0500
Received: from 69-90-55-107.fastdsl.ca ([69.90.55.107]:28802 "EHLO
	TMA-1.brad-x.com") by vger.kernel.org with ESMTP id S261638AbUCKSSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:18:45 -0500
Message-ID: <4050AEC2.8070000@brad-x.com>
Date: Thu, 11 Mar 2004 13:24:02 -0500
From: Brad Laue <brad@brad-x.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ksoftirqd using mysteriously high amounts of CPU time
References: <404F85A6.6070505@brad-x.com>	<20040310155712.7472e31c.akpm@osdl.org>	<4050271C.3070103@brad-x.com>	<40503120.9000008@brad-x.com> <20040311020832.1aa25177.akpm@osdl.org>
In-Reply-To: <20040311020832.1aa25177.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Brad Laue <brad@brad-x.com> wrote:
> 
>> Brad Laue wrote:
>> > Hopefully the attached shows some irregularity. If not, I'll have to 
>> > reply back in a few weeks when the problem recurs over the course of time.
>>
>> And without further ado, the attachment. It's been a long day. :)
> 
> 
> It beats me.  Something must be waking up ksoftirqd all the time.
> 
> If you have time, could you please apply the below, then wait for ksoftirqd
> to go bad again and then run:
> 
> 
> 	dmesg -c
> 	echo 1 > /proc/sys/debug/0 ; sleep 1; echo 0 > /proc/sys/debug/0
> 	dmesg -s 1000000 > /tmp/foo
> 
> and then send foo?

Will do. I think the profile output I generated was a bit premature. 
I'll wait a few days until the problem resurfaces in earnest and attach 
some more output then.

For now, it looks like the 'pppoe' process itself is waking up ksoftirqd 
the most according to the output of dmesg, but that may change with time.

Will keep you posted.

Brad
