Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWAOAEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWAOAEP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 19:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWAOAEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 19:04:15 -0500
Received: from [63.81.120.158] ([63.81.120.158]:65018 "EHLO hermes.mvista.com")
	by vger.kernel.org with ESMTP id S1750831AbWAOAEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 19:04:14 -0500
In-Reply-To: <a36005b50601141602y641567ebh5ff9b6a1fad4d7d2@mail.gmail.com>
References: <43C84D4B.70407@mvista.com> <a36005b50601141602y641567ebh5ff9b6a1fad4d7d2@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <746DBAD6-855A-11DA-A824-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org
From: david singleton <dsingleton@mvista.com>
Subject: Re: [robust-futex-1] futex: robust futex support
Date: Sat, 14 Jan 2006 16:04:10 -0800
To: Ulrich Drepper <drepper@gmail.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 14, 2006, at 4:02 PM, Ulrich Drepper wrote:

> On 1/13/06, David Singleton <dsingleton@mvista.com> wrote:
> =============================================
>> --- linux-2.6.15.orig/include/asm-generic/errno.h
>> +++ linux-2.6.15/include/asm-generic/errno.h
>> @@ -105,5 +105,6 @@
>>  /* for robust mutexes */
>>  #define        EOWNERDEAD      130     /* Owner died */
>>  #define        ENOTRECOVERABLE 131     /* State not recoverable */
>> +#define ENOTSHARED     132     /* no pshared attribute */
>
> Do not introduce a new error code if at all possible.  Adding
> userlang-visible error codes means the ABI changes due to the stupid
> _sys_errlist variable.  Just reuse an error code which cannot be
> returned in the futex code so far and which has some kind of
> resemblence with what the error means.

can you suggest some error codes you like to use?  I'll use
whatever you suggest.

thanks

David

