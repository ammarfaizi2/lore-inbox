Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265138AbUGLOxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265138AbUGLOxZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUGLOxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:53:25 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:8715 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265138AbUGLOxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:53:23 -0400
Message-ID: <40F2AB82.40508@techsource.com>
Date: Mon, 12 Jul 2004 11:17:22 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Linus Torvalds <torvalds@osdl.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0407080917420.1764@ppc970.osdl.org> <40ED7BE7.7010506@techsource.com> <200407090056.51084.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200407090056.51084.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Denis Vlasenko wrote:
> On Thursday 08 July 2004 19:52, Timothy Miller wrote:
> 
>>Linus Torvalds wrote:
>>
>>>I've seen too damn many people mistake NULL and NUL (admit it, you've
>>>seen it too), and I've seen code like
>>>
>>>	char c = NULL;
>>
>>THIS is simply a case of the programmer not understanding what NULL
>>means.  When I use '0' for a pointer, I know EXACTLY what I mean, and I
>>also know when '0' might be ambiguous, and when I don't know what I'm
>>allowed to do, then I play it REALLY safe and typecast 0 to exactly the
>>pointer type I need.
> 
> 
> The question is, whether readers of your code (including compiler)
> will be able to be sure that there is no error in
> 
> 	f(a,b,c,d,e,0,f,g,h);
> 
> statement or not. Better typecheck that 0.

This I agree with, definately.  It's very important to make your code 
readable, and if it's not obvious from context, make it obvious.  Cases 
like the above are one of the reasons I like languages like Verilog 
where you can pass parameters by specifying the parameter name.

