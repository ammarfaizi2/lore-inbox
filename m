Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272972AbTHKR4C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272963AbTHKRzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:55:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21740 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272945AbTHKRxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:53:31 -0400
Message-ID: <3F37D80D.5000703@pobox.com>
Date: Mon, 11 Aug 2003 13:53:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com> <3F37CF4E.3010605@pobox.com> <20030811172333.GA4879@work.bitmover.com>
In-Reply-To: <20030811172333.GA4879@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Mon, Aug 11, 2003 at 01:15:58PM -0400, Jeff Garzik wrote:
> 
>>>	if (expr) statement;		// OK
>>
>>The test and the statement run together visually, which is it is 
>>preferred to put the statement on the following line.
> 
> 
> Nah.  
> 
> 	if (!p) return (whatever);
> 	if (foo) {
> 		statement;
> 	} else {
> 		statement;
> 		statement;
> 	}
> 	if (!p) return (whatever);
> 
> Perfectly readable.  We have a few hundred thousand lines of code written

Ug.  The first and last 'if' need spreading out away from the big fat 
block, and the "return (whatever)" fools your eyes into thinking they 
are function calls at a 10-nanosecond glance.  Also, having two styles 
of 'if' formatting in your example just screams "inconsistent" to me :)


> like this and I review all of it.  I suspect that I do more reviewing than
> 99% of the people on this list which makes my opinion count more because
> anything that makes my tired eyes absorb the info faster is a good thing.

Absolutely not.  I'm cooler, so my opinion counts more.


> Same for your eyes when you get to my age.  

I bet when you were in school, you had to chip your homework into slate, 
and dinner was brontosaurus-kebob, right?


> I also make people do
> 
> 	if ((a <= B) || (c >= d)) {
> 		xxx
> 	}
> 
> even though I know, if I think about it, what the precedence is.  It doesn't
> matter that I know or you know, what matters is the number of lines of code
> a day you can correctly review.  Anything that helps that means that you 
> are helping people make the source base better.  Try reading 30K lines of 
> diffs at one sitting and tell me again that I'm wrong.  If you do, bump it
> up to 60K lines :)

Absolutely agreed.  I do the same myself out of habit.


>>>	if (!pointer) return (-EINVAL);
>>>
>>>Short, sweet, readable, no worries.  
>>
>>return is not a function ;-)
> 
> 
> See, there is that age thing again.  Think V6.  And it is sort of a function,
> it unravels the stack frame.

hehe :)  I suppose one could say I'm biased towards the compiler view of 
things, 'return' being a compiler intrinsic, controlling code flow like 
several other compiler intrinsics.

	Jeff, who also despises longjmp()



