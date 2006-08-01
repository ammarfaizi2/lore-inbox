Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbWHAKCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWHAKCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 06:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWHAKCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 06:02:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:29594 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932602AbWHAKCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 06:02:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=J10C1emXgAejGrW/NAIdkYezUpAYkcp7WxXpNVpJfC/8NXfo73Of73UmFWa+D1xcq/gJqoGREhT5NYhhd0xwobxCCbWuH+SB3ZidsphF1sJIuNbE4cKY706KEQMs3kBwwBYgVPl2IlLe4ZZdPSw6f6NBWfG/Wb0UrPyexJL+2do=
Message-ID: <44CF26BB.3040002@gmail.com>
Date: Tue, 01 Aug 2006 12:02:12 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Hua Zhong <hzhong@gmail.com>,
       "'Heiko Carstens'" <heiko.carstens@de.ibm.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "'Martin Schwidefsky'" <schwidefsky@de.ibm.com>
Subject: Re: do { } while (0) question
References: <008e01c6b549$59e52f70$493d010a@nuitysystems.com>	 <1154425171.32739.2.camel@taijtu>  <44CF22E8.9020307@gmail.com> <1154426399.32739.8.camel@taijtu>
In-Reply-To: <1154426399.32739.8.camel@taijtu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Tue, 2006-08-01 at 11:45 +0159, Jiri Slaby wrote:
>> Peter Zijlstra wrote:
>>> On Tue, 2006-08-01 at 02:03 -0700, Hua Zhong wrote:
>>>>> #if KILLER == 1
>>>>> #define MACRO
>>>>> #else
>>>>> #define MACRO do { } while (0)
>>>>> #endif
>>>>>
>>>>> {
>>>>> 	if (some_condition)
>>>>> 		MACRO
>>>>>
>>>>> 	if_this_is_not_called_you_loose_your_data();
>>>>> }
>>>>>
>>>>> How do you want to define KILLER, 0 or 1? I personally choose 0.
>>>> Really? Does it compile?
>>> No, and that is the whole point.
>>>
>>> The empty 'do {} while (0)' makes the missing semicolon a syntax error.
>> Bulls^WNope, it was a bad example (we don't want to break the compilation, just 
>> not want to emit a warn or an err).
> 
> It was a perfectly good example why 'do {} while (0)' is useful. The
> perhaps mistakenly forgotten ';' after MACRO will not stop your example
> from compiling if KILLER == 1. Even worse, it will compile and do
> something totally unexpected.
> 
> If however you use KILLER != 1, the while(0) will require a ';' and this
> example will fail to compile.

That's what I'm trying to say. It was a _bad_ piece of code. It doesn't 
demonstrate I want it to demonstrate.

> Not compiling when you made a coding error (forgetting ';' is one of the
> most common) is a great help.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
