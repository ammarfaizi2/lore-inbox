Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313589AbSDQTzc>; Wed, 17 Apr 2002 15:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313592AbSDQTzb>; Wed, 17 Apr 2002 15:55:31 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:8392 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313589AbSDQTza>;
	Wed, 17 Apr 2002 15:55:30 -0400
Date: Wed, 17 Apr 2002 13:53:55 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Rick Stevens <rstevens@vitalstream.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Message-ID: <1831780000.1019076835@flay>
In-Reply-To: <3CBDCD8D.1090802@vitalstream.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Even though clustered_apic_mode is 0, the compiler still complains
>>>> about the second one and the first one doesn't depend on
>>>> clustered_apic_mode at all.
>>>> 
>>> Hmmm ... not sure why the compiler complains about the second one,
>>> that's very strange ;-)
>>> 
>> 
>> I agree. The cpp ouput clealy shows
>> 
>>         if ((0) && (numnodes > 1)) {
>> 
>> so I'm not sure why there's a problem.
> 
> Is the thing generating the "(0)" a macro?  If so, then the rules

  #define clustered_apic_mode (0)

> of C and the "&&" operator say that "if the first is false, the
> second needn't even be evaluated".  

That's what I would have thought.
But I don't think it's the second part that causes the warning,
it's the thing *inside* the if clause.

> Could that be what's causing the warning?

To my mind, that's why we should *not* be getting a warning ?

M.

