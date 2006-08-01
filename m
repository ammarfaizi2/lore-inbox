Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbWHAKDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbWHAKDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 06:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWHAKDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 06:03:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:62621 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932608AbWHAKDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 06:03:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TC8i+5iaQPga0WMnZQvoFyQAduaFv9Mt/BXlKa8PUSnSmLOuwz6sfqsoSkGM0UyCMWpcInUzBnPS5QnAC3Zway17Gcl9tL8XIBIuTTW4Y0nynDRnMS1Dv4dSZjRwjPkSha5lzC34E76ootdxzJQB976K6xTR1TgZ0P/hyK3rK5A=
Message-ID: <44CF26FB.2000007@gmail.com>
Date: Tue, 01 Aug 2006 12:03:16 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hua Zhong <hzhong@gmail.com>,
       "'Heiko Carstens'" <heiko.carstens@de.ibm.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "'Martin Schwidefsky'" <schwidefsky@de.ibm.com>
Subject: Re: do { } while (0) question
References: <008e01c6b549$59e52f70$493d010a@nuitysystems.com> <1154425171.32739.2.camel@taijtu> <44CF22E8.9020307@gmail.com> <20060801095751.GC9556@flint.arm.linux.org.uk>
In-Reply-To: <20060801095751.GC9556@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Aug 01, 2006 at 11:45:53AM +0159, Jiri Slaby wrote:
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
>> Bulls^WNope, it was a bad example (we don't want to break the compilation, 
>> just not want to emit a warn or an err).
> 
> Your sentence does not make sense, but I'm going to take it as saying
> that you disagree that the above will cause a syntax error.  Try it:

No, my code is bad, not his thoughts.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
