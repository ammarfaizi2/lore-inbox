Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSDQVtT>; Wed, 17 Apr 2002 17:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314139AbSDQVtS>; Wed, 17 Apr 2002 17:49:18 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:52468 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S314138AbSDQVtR>;
	Wed, 17 Apr 2002 17:49:17 -0400
Message-ID: <022e01c1e659$b706f990$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Rick Stevens" <rstevens@vitalstream.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20020417123044.GA8833@www.kroptech.com> <2673595977.1019032098@[10.10.2.3]> <20020417191718.GA8660@www.kroptech.com> <3CBDCD8D.1090802@vitalstream.com> <1831780000.1019076835@flay> <20020417204037.GA292@www.kroptech.com> <3CBDE658.1030102@vitalstream.com>
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Date: Wed, 17 Apr 2002 17:49:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Stevens wrote:
> Adam Kropelin wrote:
>> Indeed. The optimization step that (presumably) removes the body
>> of the if() must happen after the body has been fully evaluated.
>> Makes sense, I guess, now that I think about it...
> 
> Right.  If the first condition of a logical AND statement is false,
> the remainder need not be evaluated at all.  Hence, the entire if
> statement can (and perhaps should) be eliminated by the compiler,
> since the condition is false.
> 
> I didn't see what the actual message from the compiler was, but it
> was probably just a warning.

Thanks for the help, but it was an error, not a warning.

It is caused by invalid code inside the body of the if(). The question
is not what is causing the error but why the compiler is evaluating the
body at all, given that the conditional is always false.

Apparently the body is evaluated prior to the optimizer getting a 
chance to nullify the whole construct.

--Adam


