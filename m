Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVBAOvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVBAOvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 09:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVBAOvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 09:51:11 -0500
Received: from mail.tmr.com ([216.238.38.203]:62726 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262030AbVBAOu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 09:50:58 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Date: Tue, 01 Feb 2005 09:54:42 -0500
Organization: TMR Associates, Inc
Message-ID: <41FF9832.3010609@tmr.com>
References: <1106932637.3778.92.camel@localhost.localdomain><1106932637.3778.92.camel@localhost.localdomain> <1106935677.7776.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Trace: gatekeeper.tmr.com 1107268817 30792 192.168.12.100 (1 Feb 2005 14:40:17 GMT)
X-Complaints-To: abuse@tmr.com
Cc: =?UTF-8?B?TG9yZW56byBIZXJuw6FuZGV6IEdhcmPDrWEtSGllcnJv?= 
	<lorenzo@gnu.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
To: Arjan van de Ven <arjan@infradead.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <1106935677.7776.29.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Fri, 2005-01-28 at 18:17 +0100, Lorenzo Hernández García-Hierro
> wrote:
> 
>>Hi,
>>
>>Attached you can find a split up patch ported from grSecurity [1], as
>>Linus commented that he wouldn't get a whole-sale patch, I was working
>>on it and also studying what features of grSecurity can be implemented
>>without a development or maintenance overhead, aka less-invasive
>>implementations.
> 
> 
> 
> why did you make it a config option? This is the kind of thing that is
> either good or isn't... at which point you can get rid of a lot of, if
> not all the ugly ifdefs the patch adds.

If there is a performance hit (there is), it's not bad to have it be an 
option, since some people will choose to go fast ("damn the torpedos, 
full speed ahead). Your point on ifdefs *may* be able to be addressed 
somewhat by putting them in macros, or similar tricks. But some are 
going to be visible even so, and you're right, they are distracting.
> 
> Also, why does it need to enhance the random driver this much, the
> random driver already has a facility to provide pseudorandom numbers
> good enough for networking use (eg the PRNG rekeys often enough with
> real entropy that brute forcing it shouldn't be possible).

I'm curious about this one as well, unless there's some proof that the 
output is "better" by actual analysis, why change? And that's better in 
terms of realized security, not by some change in the 5th insignificant 
digit of a statistical measure.

In general I do like to have the option of more security as a tradeoff, 
even if it is more than is generally needed.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
