Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbVITE5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVITE5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 00:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbVITE5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 00:57:48 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:48891 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932522AbVITE5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 00:57:47 -0400
Message-ID: <432F96C1.70303@nortel.com>
Date: Mon, 19 Sep 2005 22:57:37 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>	 <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com>	 <1127168232.24044.265.camel@tglx.tec.linutronix.de>	 <432F3E0F.1010002@nortel.com> <1127170488.24044.291.camel@tglx.tec.linutronix.de>
In-Reply-To: <1127170488.24044.291.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2005 04:57:39.0295 (UTC) FILETIME=[D35526F0:01C5BD9F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Mon, 2005-09-19 at 16:39 -0600, Christopher Friesen wrote:
> 
>>Thomas Gleixner wrote:

>>>We should rather ask glibc people why gettimeofday() / clock_getttime()
>>>is called inside the library code all over the place for non obvious
>>>reasons.

>>--flight-recorder style logs

> If you want to implement such stuff efficiently you rely on rdtscll() on
> x86 or other monotonic easy accessible time souces and not on a
> permanent call to gettimeofday.

Not portable across architectures, and doesn't work across all smp/numa 
environments.  Also not easy to compare with other nodes on the network, 
whereas with ntp-synch'd nodes you can use gettimeofday() for quite 
accurate correlations.

> Please beware me of red herrings. If application developers code with
> respect to random OS worst case behaviour then they should not complain
> that OS N is having an additional add instruction in one of the pathes.

Actually I'm not complaining about additional add instructions.  I was 
just suggesting some reasons why apps might reasonably want to know the 
time frequently.

Chris

