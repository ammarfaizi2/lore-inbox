Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288759AbSAYXIO>; Fri, 25 Jan 2002 18:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288742AbSAYXIA>; Fri, 25 Jan 2002 18:08:00 -0500
Received: from vsdc01.corp.publichost.com ([64.7.196.123]:2574 "EHLO
	vsdc01.corp.publichost.com") by vger.kernel.org with ESMTP
	id <S288759AbSAYXHn>; Fri, 25 Jan 2002 18:07:43 -0500
Message-ID: <3C51E539.1030304@vitalstream.com>
Date: Fri, 25 Jan 2002 15:07:37 -0800
From: Rick Stevens <rstevens@vitalstream.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <Pine.LNX.4.44.0201241530000.2839-100000@waste.org> <200201242228.g0OMSlL06826@home.ashavan.org.> <1011911932.810.23.camel@phantasy> <200201242243.g0OMhAL06878@home.ashavan.org.> <20020125045206.A2313@ragnar-hojland.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ragnar Hojland Espinosa wrote:

> On Fri, Jan 25, 2002 at 04:44:38PM -0600, Timothy Covell wrote:
> 
>>On Thursday 24 January 2002 16:38, Robert Love wrote:
>>
>>>On Fri, 2002-01-25 at 17:30, Timothy Covell wrote:
>>>
>>>>On Thursday 24 January 2002 16:19, Robert Love wrote:
>>>>
>>>>>how is "if (x)" any less legit if x is an integer ?
>>>>>
>>>>What about
>>>>
>>>>{
>>>>    char x;
>>>>
>>>>    if ( x )
>>>>    {
>>>>        printf ("\n We got here\n");
>>>>    }
>>>>    else
>>>>    {
>>>>        // We never get here
>>>>        printf ("\n We never got here\n");
>>>>    }
>>>>}
>>>>
>>>>
>>>>That's not what I want.   It just seems too open to bugs
>>>>and messy IHMO.
>>>>
>>>When would you ever use the above code?  Your reasoning is "you may
>>>accidentally check a char for a boolean value."  In other words, not
>>>realize it was a char.  What is to say its a boolean?  Or not?  This
>>>isn't an argument.  How does having a boolean type solve this?  Just use
>>>an int.
>>>
>>>	Robert Love
>>>
>>It would fix this because then the compiler would refuse to compile
>>"if (x)"  when x is not a bool.    That's what I would call type safety.
>>But I guess that you all are arguing that C wasn't built that way and
>>that you don't want it.    
>>
> 
> It would actually break this.  if is supposed (and expected) to evaluate
> an expression, whatever it will be.  Maybe a gentle warning could be in
> place, but refusing to compile is a plain broken C compiler.


Granted.  "if (x)" is true if "x" is non-zero, regardless of type and
shoudn't even generate a warning if "x" is scalar.

Either printf() will occur depending on whether automatics are
initialized to zero or not.  The first one will most likely print
since there's 255 to 1 odds that "x" will be non-zero if not
initialized and I don't think gcc initializes automatics.
----------------------------------------------------------------------
- Rick Stevens, SSE, VitalStream, Inc.      rstevens@vitalstream.com -
- 949-743-2010 (Voice)                    http://www.vitalstream.com -
-                                                                    -
-  The problem with being poor is that it takes up all of your time  -
----------------------------------------------------------------------

