Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHL1V>; Thu, 8 Feb 2001 06:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRBHL1M>; Thu, 8 Feb 2001 06:27:12 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:60429 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129032AbRBHL0z>; Thu, 8 Feb 2001 06:26:55 -0500
Date: Thu, 8 Feb 2001 03:26:51 -0800
Message-Id: <200102081126.f18BQpS18016@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: vido@ldh.org
Cc: Alan Cox <alan@redhat.com>, Andrey Savochkin <saw@saw.sw.com.sg>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eepro100.c, kernel 2.4.1
In-Reply-To: <20010208201539.A19229@ldh.org>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001 20:15:39 +0900, Augustin Vidovic <vido@ldh.org> wrote:

>> So what _were_ those messages? Can you post them?
> 
> No I can't because they were suppressed by the syslogd (DOS protection), only
> their number being reported (several thousands every few seconds).

syslogd does not suppress messages, it suppresses *identical* messages.
So what was the *first* message logged by syslogd, the one followed by
"last message repeated XXX times"?

>> Well, your patch disables the work-around exactly for those (really old) cards
>> that actually need it and enables it for those that don't need it.
> 
> No, because the test usede for the activation is now the same as the one used
> for the diagnostic, which means that every card which is diagnosed to have the
> bug get the workaround activated.

Umm, no. With your patch, both the diagnostic and the activation are wrong,
whereas before only the diagnostic was wrong.

>> eth0: Sending a multicast list set command from a timer routine........."
>> 
>> If you find such messages, the work-around really did something. Otherwise,
>> it's the placebo effect...
> 
> Now, I do not get _any_ message in the logs, which means that the network
> cards activity is closer to normality than before the patch.

So your patch did not do you any good. Case closed, as far as the work-around
is concerned.

If you post the original log messages, we might be able to find the real
bug...

[and please don't drop the Cc:]

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
