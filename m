Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280589AbRKFVbf>; Tue, 6 Nov 2001 16:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280586AbRKFVb0>; Tue, 6 Nov 2001 16:31:26 -0500
Received: from cc78409-a.hnglo1.ov.nl.home.com ([212.120.97.185]:40582 "EHLO
	dexter.hensema.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280587AbRKFVbG>; Tue, 6 Nov 2001 16:31:06 -0500
From: spamtrap@use.reply-to (Erik Hensema)
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Date: 6 Nov 2001 21:31:04 GMT
Message-ID: <slrn9uglko.esu.spamtrap@dexter.hensema.xs4all.nl>
In-Reply-To: <F272lT2NqFJ3sl3xbYi00004f63@hotmail.com>
Reply-To: erik@hensema.net
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Knop (w_knop@hotmail.com) wrote:
>>>1)  IT SHOULD NOT BE PRETTY.  No tabs to line up columns. No "progress
>>>bars."  No labels except as "proc comments" (see later).  No in-line
>>>labelling.
>>
>>It should not be pretty TO HUMANS. Slight difference. It should be >pretty 
>>to shellscripts and other applications though.
>
>If this is the case, why are we using ASCII for everything? If the only 
>interface to /proc will be applications, then we could just as well let the 
>application turn four bytes into an ASCII IPv4 adddress. We could easily 
>have it set up to parse using the format [single byte type identifier (ie 4 
>for string with the first byte of "data" being the string length, 1 for 
>unsigned int, 2 for signed int, 19 for IPv4, 116 for progress bar, 
>etc.)][data]. Let people standardize away. Am I missing the point?

ASCII is readable by all languages with little programmer effort. In C, you
can use a simple scanf, Perl and shells like plain ascii best.

When /proc is turned into some binary interface we'd need to create little
programs which read the binary values from the files and output them on
their stdout, which is quite cumbersome, IMHO.

>I think every aspect of an OS should be intuitive (so long as it is 
>efficient), which IMO /proc isn't. If this means splitting it in two, as 
>some have suggested, so be it. It certainly should have a design 
>guideline/spec so we may at least be consistant. Just my 2 coppers.

Yes, maintain compatibility for 2.6 and try to dump it for 2.8.

Heck, 95% compatibility could even be achieved using a 100% userspace app
which serves the data over named pipes.

-- 
Erik Hensema (erik@hensema.net)
I'm on the list; no need to Cc: me, though I appreciate one if your mailer
doesn't support the References header.
