Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268706AbUH3R41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268706AbUH3R41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268707AbUH3RwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:52:23 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:31910 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S268706AbUH3RtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:49:25 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
Date: Mon, 30 Aug 2004 17:49:24 +0000 (UTC)
Organization: Cistron Group
Message-ID: <cgvpb4$ljq$1@news.cistron.nl>
References: <200408021602.34320.swsnyder@insightbb.com> <20040804120633.4dca57b3.akpm@osdl.org> <411ABF85.2080200@techsource.com> <41336CB1.6030105@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1093888164 22138 62.216.29.200 (30 Aug 2004 17:49:24 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <41336CB1.6030105@techsource.com>,
Timothy Miller  <miller@techsource.com> wrote:
>Timothy Miller wrote:
>> Hey, that rings a bell.  I have a 3ware 7000-2 controller with two 
>> WD1200JB drives in RAID1.  I find that if I dd from the disk, I get 
>> exactly the read throughput that is the max for the drives (47MB/sec). 
>> However, if I do a WRITE test, the performance is miserable.
>> 
>> I have been going back and forth with 3ware for months, and what's odd 
>> is that my drives with my controller in any machine other than the 
>> primary box get great write throughput, BUT on my main box with 1G of 
>> RAM, I get MISERABLE write throughput.  When I should be getting 
>> 36MB/sec or faster, I get 8 to 12 MB/sec.
>> 
>> Now, I have tried limiting the memory with a mem= boot option, but that 
>> doesn't change the performance any.
>
>Scratch all this.  Even if I physically remove half the memory, I STILL 
>get the performance problem.

3ware eh?

Try setting /sys/block/sda/queue/nr_requests to twice the number
in /sys/block/sda/device/queue_depth

Mike.
-- 
"In times of universal deceit, telling the truth becomes
 a revolutionary act." -- George Orwell.

