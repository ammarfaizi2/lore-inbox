Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314144AbSDQWGr>; Wed, 17 Apr 2002 18:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314145AbSDQWGq>; Wed, 17 Apr 2002 18:06:46 -0400
Received: from jalon.able.es ([212.97.163.2]:40887 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314144AbSDQWGp>;
	Wed, 17 Apr 2002 18:06:45 -0400
Date: Thu, 18 Apr 2002 00:06:27 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Rick Stevens <rstevens@vitalstream.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Message-ID: <20020417220627.GC1728@werewolf.able.es>
In-Reply-To: <20020417123044.GA8833@www.kroptech.com> <2673595977.1019032098@[10.10.2.3]> <20020417191718.GA8660@www.kroptech.com> <3CBDCD8D.1090802@vitalstream.com> <1831780000.1019076835@flay> <20020417204037.GA292@www.kroptech.com> <3CBDE658.1030102@vitalstream.com> <022e01c1e659$b706f990$02c8a8c0@kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.17 Adam Kropelin wrote:
>Rick Stevens wrote:
>> Adam Kropelin wrote:
>>> Indeed. The optimization step that (presumably) removes the body
>>> of the if() must happen after the body has been fully evaluated.
>>> Makes sense, I guess, now that I think about it...
>> 
>> Right.  If the first condition of a logical AND statement is false,
>> the remainder need not be evaluated at all.  Hence, the entire if
>> statement can (and perhaps should) be eliminated by the compiler,
>> since the condition is false.
>> 
>> I didn't see what the actual message from the compiler was, but it
>> was probably just a warning.
>
>Thanks for the help, but it was an error, not a warning.
>
>It is caused by invalid code inside the body of the if(). The question
>is not what is causing the error but why the compiler is evaluating the
>body at all, given that the conditional is always false.
>
>Apparently the body is evaluated prior to the optimizer getting a 
>chance to nullify the whole construct.
>

AFAIK, you first parse C to build a tree of commands, expresions, etc,
and then you do the rest on the tree (optimizations at source-code level,
like CSE, ie, detection of equal subtrees, or for example
killig and if tree if it is always false).

Hope this helps.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam1 #2 SMP Wed Apr 17 21:20:31 CEST 2002 i686
