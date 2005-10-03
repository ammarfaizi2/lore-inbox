Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVJCQpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVJCQpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVJCQpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:45:09 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:63711 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S932430AbVJCQpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:45:07 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Dave Hansen <haveblue@us.ibm.com>,
       Magnus Damm <magnus@valinux.co.jp>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <93300000.1128354870@[10.10.2.4]>
References: dlang@dlang.diginsite.com <Pine.LNX.4.62.0510030802090.11541@qynat.qvtvafvgr.pbz> <83890000.1128352138@[10.10.2.4]> <Pine.LNX.4.62.0510030810290.11541@qynat.qvtvafvgr.pbz> <86300000.1128353125@[10.10.2.4]> <Pine.LNX.4.62.0510030831550.11541@qynat.qvtvafvgr.pbz> <93300000.1128354870@[10.10.2.4]>
Date: Mon, 3 Oct 2005 09:44:26 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [PATCH 00/07][RFC] i386: NUMA emulation
In-Reply-To: <93300000.1128354870@[10.10.2.4]>
Message-ID: <Pine.LNX.4.62.0510030942551.11541@qynat.qvtvafvgr.pbz>
References: dlang@dlang.diginsite.com <Pine.LNX.4.62.0510030802090.11541@qynat.qvtvafvgr.pbz>
 <83890000.1128352138@[10.10.2.4]> <Pine.LNX.4.62.0510030810290.11541@qynat.qvtvafvgr.pbz>
 <86300000.1128353125@[10.10.2.4]> <Pine.LNX.4.62.0510030831550.11541@qynat.qvtvafvgr.pbz>
 <93300000.1128354870@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Martin J. Bligh wrote:

>>>>>
>>>>> Not noticed that, and I can't see why it should be the case in general,
>>>>> though I suppose some machines might be odd. Got any numbers?
>>>>
>>>> just the fact that the system boot memory test takes 3-4 times as long with 8G or ram then with 4G of ram. I then boot a 64 bit kernel on the system and never use PAE mode again :-)
>>>>
>>>> if you can point me at a utility that will test the speed of the memory in different chunks I'll do some testing on the Opteron systems I have available. unfortunantly I don't have any Xeon systems to test this on.
>>>
>>> Mmm. 64-bit uniproc systems, with > 4GB of RAM, running a 32 bit kernel
>>> don't really strike me as a huge market segment ;-)
>>
>> true, but there are a lot of 32-bit uniproc systems sold by Intel that have (or can have) more then 4G of ram. These are the machines I was thinking of.
>
> Does your opteron box have more than 1 socket? that'd explain it.

yes, but I see the same 4G breakpoint no matter what the memory config 
(including one dual proc machine with 16G, if it was a matter of hitting 
memory connected to the other socket I would expect the slowdown at 8G, 
not at 4G)

> Anyway, it shouldn't happen on any normal platform. Until we get
> numbers that prove that it does (and understand why), I don't think
> we need NUMA for PAE.

Ok, if nobody else is seeing any slowdown.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
