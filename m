Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268992AbUIXQu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268992AbUIXQu3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268944AbUIXQq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:46:27 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:6860 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268981AbUIXQpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:45:46 -0400
Message-ID: <41544FDB.8090401@austin.ibm.com>
Date: Fri, 24 Sep 2004 11:48:27 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
References: <4152F46D.1060200@austin.ibm.com> <20040923194216.1f2b7b05.akpm@osdl.org> <41543FE2.5040807@austin.ibm.com> <41544876.4040302@yahoo.com.au>
In-Reply-To: <41544876.4040302@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Steven Pratt wrote:
>
>> Andrew Morton wrote:
>>
>>> Steven Pratt <slpratt@austin.ibm.com> wrote:
>>>  
>>>
>>>> would like to offer up an alternative simplified design which will 
>>>> not only make the code easier to maintain,
>>>>   
>>>
>>>
>>> We won't know that until all functionality is in place.
>>>  
>>
>> Ok, but both you and Nick indicated that the queue congestion isn't 
>> needed,
>
> I would have thought that always doing the readahead would provide a
> more graceful degradation, assuming the readahead algorithm is fairly
> accurate, and copes with things like readahead thrashing (which we
> hope is the case).

Yes, that is exactly my thought.  I think this is what the new code does.

>
>>> I do think we should skip the I/O for POSIX_FADV_WILLNEED against a
>>> congested queue.  I can't immediately think of a good reason for 
>>> skipping
>>> the I/O for normal readahead.
>>>  
>>
>
> I don't see why you should skip the readahead for FADVISE_WILLNEED
> either. Presumably if someone needs this, they really need it. We
> should aim for optimal behaviour when the apis are being used 
> correctly... 

Ok, great, since this is what it does.

Thanks, Steve


