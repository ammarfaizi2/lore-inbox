Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWESUIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWESUIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWESUIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:08:25 -0400
Received: from mserv2.uoregon.edu ([128.223.142.41]:42368 "EHLO
	smtp.uoregon.edu") by vger.kernel.org with ESMTP id S964793AbWESUIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:08:24 -0400
Message-ID: <446DE6E9.9080707@uoregon.edu>
Date: Fri, 19 May 2006 08:40:25 -0700
From: Joel Jaeggli <joelja@uoregon.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Stealing ur megahurts (no, really)
References: <446D61EE.4010900@comcast.net> <20060519101006.GL8304@mea-ext.zmailer.org>
In-Reply-To: <20060519101006.GL8304@mea-ext.zmailer.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> On Fri, May 19, 2006 at 02:13:02AM -0400, John Richard Moser wrote:
> ...
>> On Linux we have mem= to toy with memory, which I personally HAVE used
>> to evaluate how various distributions and releases of GNOME operate
>> under memory pressure.  This is a lot more convenient than pulling chips
>> and trying to find the right combination.  This option was, apparently,
>> designed for situations where actual system memory capacity is
>> mis-detected (mandrake 7.2 and its insistence that a 256M memory stick
>> is 255M....); but is very useful in this application too.
>>
>> This brings the idea of a cpumhz= parameter to adjust CPU clock rate.
>> Obviously we can't do this directly, as convenient as this would be; but
>> the idea warrants some thought, and some thought I gave it.  What I came
>> up with was simple:  Adjust time slice length and place a delay between
>> time slices so they're evenly spaced.
> ...
>> Questions?  Comments?  Particular ideas on what would happen?

The other thing  I would observe is that clock speed is only part of the
equation, it's one thing to soak up some cpu cycles, but the cpu may be
a lot more superscalar (pipelineing, simd instructions, multiple cores
etc) than the one you're trying to simulate, probably it also has a lot
more cache and much faster memory. So that while you can certainly soak
up a lot of cpu pretty easily there are other considerations that might
effect simulating the performance of say a 100mhz pentium on say an
athlon 64x2.

emulation would probably go a lot further as an approach

> Modern machines have ability to be "speed controlled" - Perhaps
> they can cut their speed by 1/3 or 1/2, but run slower anyway
> in the name of energy conservation.
> 
> 
> Another approach (not thinking on multiprocessor systems now)
> is to somehow gobble up system performance into some "hoarder"
> (highest scheduling priority, eats up 90% of time slices doing
> excellent waste of CPU resources..)
> 

<snip>

-- 
-------------------------------------------------
Joel Jaeggli (joelja@uoregon.edu)
GPG Key Fingerprint:
5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

