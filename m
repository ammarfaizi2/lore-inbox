Return-Path: <linux-kernel-owner+w=401wt.eu-S1030189AbWLOWT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWLOWT4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 17:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWLOWT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 17:19:56 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:58573 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030186AbWLOWTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 17:19:55 -0500
Message-ID: <45831F80.5060008@garzik.org>
Date: Fri, 15 Dec 2006 17:19:44 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@suse.de>,
       Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, Tejun Heo <htejun@gmail.com>
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
References: <20061204203410.6152efec.akpm@osdl.org>	<17780.63770.228659.234534@cse.unsw.edu.au>	<20061205061623.GA13749@amd64.of.nowhere>	<20061205062142.GA14784@amd64.of.nowhere>	<20061204224323.2e5d0494.akpm@osdl.org>	<20061205105928.GA6482@amd64.of.nowhere>	<17782.28505.303064.964551@cse.unsw.edu.au>	<20061215192146.GA3616@amd64.of.nowhere>	<17795.2681.523120.656367@cse.unsw.edu.au>	<20061215130552.95860b72.akpm@osdl.org>	<20061215133927.a8346372.akpm@osdl.org> <20061215220618.06f1873c@localhost.localdomain>
In-Reply-To: <20061215220618.06f1873c@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> On Fri, 15 Dec 2006 13:39:27 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
>> On Fri, 15 Dec 2006 13:05:52 -0800
>> Andrew Morton <akpm@osdl.org> wrote:
>>
>>> Jeff, I shall send all the sata patches which I have at you one single time
>>> and I shall then drop the lot.  So please don't flub them.
>>>
>>> I'll then do a rc1-mm2 without them.
>> hm, this is looking like a lot of work for not much gain.  Rafael, are
>> you able to do a quick chop and tell us whether these:
> 
> The md one and the long history of reports about parallel I/O causing
> problems sounds a lot more like the kmap stuff you were worried about
> Andrew. I'd be very intereste dto know if it happens on x86_32 built with
> a standard memory split and no highmem....

2.6.20-rc1 works, and 2.6.20-rc1 does not have the kmap_atomic() fix.

Upstream does kmap_atomic(KM_USER0) and -mm does kmap_atomic(KM_IRQ0)

	Jeff



