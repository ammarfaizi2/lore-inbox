Return-Path: <linux-kernel-owner+w=401wt.eu-S1755241AbXAAQaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbXAAQaK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 11:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbXAAQaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 11:30:10 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:32847 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbXAAQ3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 11:29:44 -0500
Message-ID: <4599335D.9060905@oracle.com>
Date: Mon, 01 Jan 2007 08:14:21 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Christoph Hellwig <hch@infradead.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line
 macros.
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain> <20070101142020.GA16425@infradead.org> <Pine.LNX.4.64.0701010921460.7166@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0701010921460.7166@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> On Mon, 1 Jan 2007, Christoph Hellwig wrote:
> 
>> On Sun, Dec 31, 2006 at 02:32:25PM -0500, Robert P. J. Day wrote:
>>> + (a) Enclose those statements in a do - while block:
>>> +
>>> +	#define macrofun(a, b, c) 		\
>>> +		do {				\
>>> +			if (a == 5)		\
>>> +				do_this(b, c);	\
>>> +		} while (0)
>> nitpick, please don't add an indentaion level for the do {.  Do this
>> should look like:
>>
>> 	#define macrofun(a, b, c) 	\
>> 	do {				\
>> 		if (a == 5)		\
>> 			do_this(b, c);	\
>> 	} while (0)
> 
> the former is the way it's presented in CodingStyle currently, it
> wasn't my personal opinion on the subject.  i was just reproducing
> what was already there.
> 
>>> + (b) Use the gcc extension that a compound statement enclosed in
>>> +     parentheses represents an expression:
>>> +
>>> +	#define macrofun(a, b, c) ({		\
>>>  		if (a == 5)			\
>>>  			do_this(b, c);		\
>>> -	} while (0)
>>> +	})
>> I'd rather document to not use this - it makes the code far less
>> redable.  And it's a non-standard extension, something we only
>> use if it provides us a benefit which it doesn't here.
> 
> it might be a bit late to put a cork in *that* bottle:
> 
>   $ grep -r "#define.*({" *

We aren't trying to prevent its past use.  We just aren't encouraging
the use of gcc extensions if there are reasonable & better ways to
do something.

-- 
~Randy
