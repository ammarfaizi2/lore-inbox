Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265006AbUFAMXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbUFAMXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 08:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUFAMXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 08:23:07 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:28640 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S265014AbUFAMWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 08:22:12 -0400
Message-ID: <40BC74C6.2010306@maine.rr.com>
Date: Tue, 01 Jun 2004 08:21:26 -0400
From: "David B. Stevens" <dsteven3@maine.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jlnance@unity.ncsu.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <200405290037.17775.vda@port.imtp.ilyichevsk.odessa.ua> <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net> <20040531104928.GA1465@ncsu.edu>
In-Reply-To: <20040531104928.GA1465@ncsu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu wrote:
>>>cp should use fadvise() and say that it _really_ does not need those pages.
>>
>>Yes, indeed. On the other hand the sequential read could be detected by the kernel, too.
> 
> 
> I'm not sure.  Copying a file is a pretty good indication that you
> are about to do something with either the new or the old file.
> 
> Thanks,
> 
> Jim

It is?

Sorry for butting in folks, but I've been reading this thread hoping to 
see some possible solutions.  Seems that a survey of best practices 
might have been suggested, however, I haven't seen such a suggestion.

So here goes, might it not be of some benefit to see how other operating 
systems (there are rather large number) handle the use  of memory.  For 
just one example you could look at MVS, where the application can 
request through various means how and how much memory it uses.  Most 
defaults can be overridden by the scripting language used to run the 
application.  This also true of other operating systems.

I would be more willing to say that the folks setting up the running of 
systems should have far more control over the use or non use of cache 
backed I/O data.

Now that I've said that you have to consider how and where this control 
should be based.

<soapbox>

SWAP is a solution for the age old whine, I caused the system to run out 
of memory and the big mean operating system terminated my application.

These days it allows the performance of the system to degrade to the 
point that the whine goes, The big mean operating system is taking 
forever to run my 10 TB backup and, by the way, it takes 3 days to wake 
up my openoffice application that I started a week ago.

Ain't progress grand ;-)

</soapbox>

Cheers,
   Dave



