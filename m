Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWBXUo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWBXUo4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWBXUo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:44:56 -0500
Received: from mail.atl.external.lmco.com ([192.35.37.50]:58799 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S1751090AbWBXUo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:44:56 -0500
Message-ID: <43FF7047.7060503@atl.lmco.com>
Date: Fri, 24 Feb 2006 15:44:55 -0500
From: Gautam H Thaker <gthaker@atl.lmco.com>
Organization: Lockheed Martin -- Advanced Technology Laboratories
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Gautam H Thaker <gautam.h.thaker@lmco.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: ~5x greater CPU load for a networked application when using 2.6.15-rt15-smp
 vs. 2.6.12-1.1390_FC4
References: <43FE134C.6070600@atl.lmco.com> <20060223205851.GA24321@elte.hu> <20060224041145.5bcdbc97.akpm@osdl.org> <43FF675A.6080305@atl.lmco.com> <20060224123129.4ec024d4.akpm@osdl.org>
In-Reply-To: <20060224123129.4ec024d4.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Gautam H Thaker <gthaker@atl.lmco.com> wrote:
> 
>>>http://www.zip.com.au/~akpm/linux/#zc  <- better ;)
>>
>> Andrew,
>>
>> I read the README for the "zc" tests. I wish Ingo can opine on which may be a
>> better test. Also, i assume that I can run "zcs" and "zcc" on the same
>> machine. I would do the tests with "send" instead of "sendfile".
> 
> 
> Oh.  I don't actually remember what zc does.  I was actually referring to
> `cyclesoak', which has proven to be a pretty accurate (or at least,
> sensitive and repeatable) way of determining overall per-CPU system load.

Yes, I should have been more clear. I meant to say that perhaps I should use
the 4 combinations of OS configs (non-RT/RT x UniProc/SMP) and use zc  and
cyclesoak rather than do a 20 node test, but I believe I will need many nodes
sending to my one "monitor" node to get this high packet receive rate of
about 38,000/second. Lower rates involving only a single machine should also
be capable of revealing conclusively that "RT-SMP" kernels are some factor
heavier than non-RT-UniProc kernel. Anyway, I will do the tests.

-- 

Gautam H. Thaker
Distributed Processing Lab; Lockheed Martin Adv. Tech. Labs
3 Executive Campus; Cherry Hill, NJ 08002
856-792-9754, fax 856-792-9925  email: gthaker@atl.lmco.com
