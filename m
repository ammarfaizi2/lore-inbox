Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVCENqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVCENqy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 08:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVCENqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 08:46:54 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:22429 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261275AbVCENqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 08:46:51 -0500
Message-ID: <4229B847.5050301@drzeus.cx>
Date: Sat, 05 Mar 2005 14:46:47 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ian Molton <spyro@f2s.com>, Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC] Secure Digital (SD) support
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk> <4229A4B4.1000208@drzeus.cx> <20050305124420.A342@flint.arm.linux.org.uk>
In-Reply-To: <20050305124420.A342@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Sat, Mar 05, 2005 at 01:23:16PM +0100, Pierre Ossman wrote:
>  
>
>>I can make a new patch or you can just undo that line once you've 
>>applied the current one.
>>    
>>
>
>I'd rather not just apply this patch - there's rather a lot there to
>just apply on top of what's already merged.
>
>Is there any chance you can split it up into a smaller set of changes
>so it's more obvious what's going on at each stage please?
>  
>
Sure. I'll try to divide it into smaller pieces. It will result in some 
patches that are just there to prepare for the other ones though (i.e. 
they don't add any functionality by themselves).

>We'll also need to run this by Linus first, explaining why you believe
>it's now ok to merge this.  (Added Linus...)
>
>  
>
First of, I can't really back up the claim that it isn't ok. The SDA has 
a paragraph about non-disclosure in their "IP Policy" 
(http://www.sdcard.org/membership/images/ippolicy.pdf) but it also 
states that exceptions can be granted.

Against this stands the new information that the SDA is changing its 
policy and making the specs public. This information comes from some of 
the guys at HP research and hasn't been confirmed by any public 
statement from SDA. The SDA have, however, already released the SDIO 
specs. Presumably as part of this new policy.

It was also pointed out in the previous thread by myself, Alan Cox and 
Ian Molton that SD specs have been publically available from different 
companies for quite some time. As such it is difficult for anyone to 
claim that these are secret and can be regulated by a NDA. The only part 
that hasn't been found in the wild is the spec for the 'secure' parts of 
the cards. But that also means that it isn't included in this patch so 
it shouldn't pose a problem.

As always, IANAL so I can't give any definite answer. But from my point 
of view they would have a very weak case if they tried to claim that the 
information in this patch is a trade secret.

Rgds
Pierre


