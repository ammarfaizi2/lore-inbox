Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313582AbSDQTbc>; Wed, 17 Apr 2002 15:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313583AbSDQTbb>; Wed, 17 Apr 2002 15:31:31 -0400
Received: from vsdc01.corp.publichost.com ([64.7.196.123]:24072 "EHLO
	vsdc01.corp.publichost.com") by vger.kernel.org with ESMTP
	id <S313582AbSDQTbb>; Wed, 17 Apr 2002 15:31:31 -0400
Message-ID: <3CBDCD8D.1090802@vitalstream.com>
Date: Wed, 17 Apr 2002 12:31:25 -0700
From: Rick Stevens <rstevens@vitalstream.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
In-Reply-To: <20020417123044.GA8833@www.kroptech.com> <2673595977.1019032098@[10.10.2.3]> <20020417191718.GA8660@www.kroptech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> On Wed, Apr 17, 2002 at 08:28:19AM -0700, Martin J. Bligh wrote:
> 
>>Adam Kropelin wrote:
>>
>>>Even though clustered_apic_mode is 0, the compiler still complains
>>>about the second one and the first one doesn't depend on
>>>clustered_apic_mode at all.
>>>
>>Hmmm ... not sure why the compiler complains about the second one,
>>that's very strange ;-)
>>
> 
> I agree. The cpp ouput clealy shows
> 
>         if ((0) && (numnodes > 1)) {
> 
> so I'm not sure why there's a problem.

Is the thing generating the "(0)" a macro?  If so, then the rules
of C and the "&&" operator say that "if the first is false, the
second needn't even be evaluated".  Could that be what's causing
the warning?
----------------------------------------------------------------------
- Rick Stevens, SSE, VitalStream, Inc.      rstevens@vitalstream.com -
- 949-743-2010 (Voice)                    http://www.vitalstream.com -
-                                                                    -
-         We have enough youth, how about a fountain of SMART?       -
----------------------------------------------------------------------

