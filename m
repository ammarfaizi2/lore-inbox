Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314108AbSDQVRT>; Wed, 17 Apr 2002 17:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314129AbSDQVRS>; Wed, 17 Apr 2002 17:17:18 -0400
Received: from vsdc01.corp.publichost.com ([64.7.196.123]:64013 "EHLO
	vsdc01.corp.publichost.com") by vger.kernel.org with ESMTP
	id <S314108AbSDQVRS>; Wed, 17 Apr 2002 17:17:18 -0400
Message-ID: <3CBDE658.1030102@vitalstream.com>
Date: Wed, 17 Apr 2002 14:17:12 -0700
From: Rick Stevens <rstevens@vitalstream.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
In-Reply-To: <20020417123044.GA8833@www.kroptech.com> <2673595977.1019032098@[10.10.2.3]> <20020417191718.GA8660@www.kroptech.com> <3CBDCD8D.1090802@vitalstream.com> <1831780000.1019076835@flay> <20020417204037.GA292@www.kroptech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> On Wed, Apr 17, 2002 at 01:53:55PM -0700, Martin J. Bligh wrote:
> 
>>>of C and the "&&" operator say that "if the first is false, the
>>>second needn't even be evaluated".  
>>>
>>That's what I would have thought.
>>But I don't think it's the second part that causes the warning,
>>it's the thing *inside* the if clause.
>>
> 
> Exactly.
> 
> 
>>>Could that be what's causing the warning?
>>>
>>To my mind, that's why we should *not* be getting a warning ?
>>
> 
> Indeed. The optimization step that (presumably) removes the body
> of the if() must happen after the body has been fully evaluated.
> Makes sense, I guess, now that I think about it...

Right.  If the first condition of a logical AND statement is false,
the remainder need not be evaluated at all.  Hence, the entire if
statement can (and perhaps should) be eliminated by the compiler,
since the condition is false.

I didn't see what the actual message from the compiler was, but it
was probably just a warning.
----------------------------------------------------------------------
- Rick Stevens, SSE, VitalStream, Inc.      rstevens@vitalstream.com -
- 949-743-2010 (Voice)                    http://www.vitalstream.com -
-                                                                    -
-     Never put off 'til tommorrow what you can forget altogether!   -
----------------------------------------------------------------------

