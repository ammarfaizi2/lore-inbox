Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131673AbRABWIE>; Tue, 2 Jan 2001 17:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131755AbRABWHy>; Tue, 2 Jan 2001 17:07:54 -0500
Received: from mx2.utanet.at ([195.70.253.46]:9097 "EHLO smtp1.utaiop.at")
	by vger.kernel.org with ESMTP id <S131673AbRABWHk>;
	Tue, 2 Jan 2001 17:07:40 -0500
Message-ID: <3A52582B.9080307@grips.com>
Date: Tue, 02 Jan 2001 23:37:31 +0100
From: Gerold Jury <geroldj@grips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-prerelease i686; en-US; m18) Gecko/20001229
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
Subject: Re: Happy new year^H^H^H^Hkernel..
In-Reply-To: <Pine.LNX.4.10.10012311205020.1210-100000@penguin.transmeta.com> <3A514236.2000801@grips.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for that stupid mistake.
The patches to the isdn part do not make a difference to the kernel hang
that i experienced lately.
When i reversed the patch for the mentioned files i checked the kernel 
configuration and noticed that the "diversion services for isdn" where 
on, a feature that i cannot use at the moment with my carrier.
I switched them off before i compiled the new kernel.
This is what makes the difference.
Kernel 2.4.0-test13-pre4 was the previous one that I used (with 
diversion services on, i am a fan of make oldconfig) and that did not 
show the problem (as all of the previous kernels, test9, test10, test12).

I have reversed the patches part by part, the only thing that makes a 
difference is the diversion services.
The reason for this remains unknown for me.

I use a fritz pnp/isa card, driver compiled as a module.
No SMP, isdn in kernel.
Close to nothing running during the hangup.

The problem is reproducable and i would be glad to help testing any 
suggestions.

Gerold


Gerold Jury wrote:

> The ISDN changes for the HISAX drivers
> that came in since test12 have introduced a bug that causes a 
> AIEE-something and a complete kernel hang when i hangup the isdn line.
> I have reversed the patch for all occurences of INIT_LIST_HEAD in the 
> isdn patch part and it works for me now.
> 
> The relevant part is attached. Please back it out for 2.4.0.
> 
> Happy new year
> 
> Gerold Jury
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
