Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268346AbUHXD5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268346AbUHXD5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 23:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269001AbUHXD5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 23:57:07 -0400
Received: from relay.pair.com ([209.68.1.20]:36625 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268346AbUHXD5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 23:57:00 -0400
X-pair-Authenticated: 66.190.51.173
Message-ID: <412ABC8B.5080608@cybsft.com>
Date: Mon, 23 Aug 2004 22:56:59 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P8
References: <20040816040515.GA13665@elte.hu>	 <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>	 <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net>	 <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>	 <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu>	 <20040821140501.GA4189@elte.hu>  <20040823210151.GA10949@elte.hu> <1093312154.862.17.camel@krustophenia.net>
In-Reply-To: <1093312154.862.17.camel@krustophenia.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Mon, 2004-08-23 at 17:01, Ingo Molnar wrote:
> 
> 
>> - reduce netdev_max_backlog to 8 (Mark H Johnson)
>>
> 
> 
> On my system this setting has absolutely no effect on the skb related
> latencies.  I tested setting netdev_max_backlog to every power of two 
> between 1 and 128, and regardless of this setting, I can produce a
> 450-600 usec latency with:
> 
> ping -s 65507 -f $DEFAULT_GATEWAY
> 
> Looks like skb_checksum is the problem.  Here is one of the traces:
> 
> http://krustophenia.net/testresults.php?dataset=2.6.8.1-P8#/var/www/2.6.8.1-P8/trace14.txt
> 
> Lee
> 
> -

Setting netdev_max_backlog doesn't seem to have any effect for me either.

I get a similar latency when I try to reproduce your result above, ~612 
usec. However, my trace is very different than yours:

http://www.cybsft.com/testresults/2.6.8.1-P8/latency_trace3.txt

In fact most any network activity, with the POSSIBLE exception of 
already open connections, seem to be able to trigger higher latencies. 
As you can see here:

http://www.cybsft.com/testresults/2.6.8.1-P8/


kr


