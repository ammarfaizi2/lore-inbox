Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWEWNeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWEWNeE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 09:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWEWNeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 09:34:04 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:18733 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932213AbWEWNeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 09:34:02 -0400
Message-ID: <44730F43.3050806@de.ibm.com>
Date: Tue, 23 May 2006 15:33:55 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/6] statistics infrastructure - prerequisite: timestamp
References: <1148055080.2974.15.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <661de9470605230606l3e5fca31x5ce2be91512433@mail.gmail.com>
In-Reply-To: <661de9470605230606l3e5fca31x5ce2be91512433@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
>> +static inline int nsec_to_timestamp(char *s, unsigned long long t)
>> +{
>> +       unsigned long nsec_rem = do_div(t, 1000000000);
> 
> Could we please use NSEC_PER_SEC. I cannot count the number of zeros
> after the 1.

Sure. I tried to keep my changes as small as possible ;-)

>> +       return sprintf(s, "[%5lu.%06lu]", (unsigned long)t, 
>> nsec_rem/1000);
>> +}
> 
> Something symbolic for the 1000 would be better.  NSECS_PER_USEC probably?

Makes sense.

Thanks,
Martin


