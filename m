Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266222AbUGOPuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266222AbUGOPuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 11:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbUGOPuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 11:50:24 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:58629 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266222AbUGOPuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 11:50:16 -0400
Message-ID: <40F6AD88.8040209@techsource.com>
Date: Thu, 15 Jul 2004 12:15:04 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linus Torvalds <torvalds@osdl.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>	<Pine.LNX.4.58.0407080917420.1764@ppc970.osdl.org>	<40ED7BE7.7010506@techsource.com>	<200407090056.51084.vda@port.imtp.ilyichevsk.odessa.ua>	<40F2AB82.40508@techsource.com> <jeisct2oig.fsf@sykes.suse.de>
In-Reply-To: <jeisct2oig.fsf@sykes.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andreas Schwab wrote:
> Timothy Miller <miller@techsource.com> writes:
> 
> 
>>Denis Vlasenko wrote:
>>
>>>The question is, whether readers of your code (including compiler)
>>>will be able to be sure that there is no error in
>>>	f(a,b,c,d,e,0,f,g,h);
>>>statement or not. Better typecheck that 0.
>>
>>This I agree with, definately.  It's very important to make your code
>>readable, and if it's not obvious from context, make it obvious.  Cases
>>like the above are one of the reasons I like languages like Verilog where
>>you can pass parameters by specifying the parameter name.
> 
> 
> If your function needs nine arguments it is not readable by
> definition. :-)


Yeah... unfortunately, in chip design, you can't really avoid that. 
VHDL has structures which allow you to aggregate different signals, but 
Verilog doesn't have that feature, so you end up with hundreds of module 
parameters sometimes.  That's when pass-by-name really pays off.

But then again, everything you know about software development is 
completely goes out the window when doing chip design.  (i.e. in C, less 
code usually produces better results.  The opposite is true in Verilog.)

