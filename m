Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268355AbUHYC2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268355AbUHYC2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 22:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268388AbUHYC2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 22:28:17 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:65118 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268355AbUHYC2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 22:28:14 -0400
Message-ID: <412BF93A.6000902@yahoo.com.au>
Date: Wed, 25 Aug 2004 12:28:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Massimo Cetra <mcetra@navynet.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Production comparison between 2.4.27 and 2.6.8.1
References: <002401c489e4$d7903ec0$0600640a@guendalin>
In-Reply-To: <002401c489e4$d7903ec0$0600640a@guendalin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Massimo Cetra wrote:
> Nick Piggin wrote:
> 
> 
>>>Is this issue being analyzed ?
>>>Should we hope in an improvement sometime?
>>>Or I'll have to use 2.4 to have good performance ?
>>>
>>
>>You booted with elevator=deadline and things still didn't 
>>improve though, correct? If so, then the problem should be 
>>found and fixed.
> 
> 
> Yes, that's correct.
> Thanks.  I'll try next versions of kernel.
> I dont think 2.8.9-RC1 includes something regarding this issue.
> 

OK, can you try testing different values of
/sys/block/???/queue/read_ahead_kb

and

/sys/block/???/queue/nr_requests

You should set '???' for all disks involved.


First, try setting read_ahead_kb to 0, then 256.
If those values don't change anything, set nr_requests to 1024.

