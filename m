Return-Path: <linux-kernel-owner+w=401wt.eu-S932081AbXAHUwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbXAHUwY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbXAHUwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:52:23 -0500
Received: from terminus.zytor.com ([192.83.249.54]:44414 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbXAHUwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:52:22 -0500
Message-ID: <45A2AEE0.4090707@zytor.com>
Date: Mon, 08 Jan 2007 12:51:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: dean gaudet <dean@arctic.org>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] All Transmeta CPUs have constant TSCs
References: <200701050148.l051mHGM005275@terminus.zytor.com> <Pine.LNX.4.61.0701051524440.7813@yvahk01.tjqt.qr> <Pine.LNX.4.64.0701072358010.26307@twinlark.arctic.org> <Pine.LNX.4.61.0701082118370.23737@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0701082118370.23737@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> On Jan 8 2007 00:02, dean gaudet wrote:
>> On Fri, 5 Jan 2007, Jan Engelhardt wrote:
>>> On Jan 4 2007 17:48, H. Peter Anvin wrote:
>>>> [i386] All Transmeta CPUs have constant TSCs
>>>> All Transmeta CPUs ever produced have constant-rate TSCs.
>>> A TSC is ticking according to the CPU frequency, is not it?
>> transmeta decided years before intel and amd that a constant rate tsc 
>> (unaffected by P-state) was the only sane choice.  on transmeta cpus the 
>> tsc increments at the maximum cpu frequency no matter what the P-state 
>> (and no matter what longrun is doing behind the kernel's back).
>>
>> mind you, many people thought this was a crazy choice at the time...
>>
> Well it defeats the purpose of TSC. I mean, they could have kept the "TSC" and
> instead added a second TSC ticker, constant_tsc.
> 

It depends on what "the purpose of TSC" is.  The original spec is 
ambiguous if the TSC counts wall time or CPU time, since there was no 
distinction when the spec was made.  The more common usage, however, was 
to count wall time; the relatively few users who care about CPU cycles 
(especially when the CPU is degraded) can be serviced via an RDPMC counter.

I *definitely* support the concept that RDPMC 0 should could CPU cycles 
by convention in Linux.

	-hpa
