Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbRBHLAp>; Thu, 8 Feb 2001 06:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129094AbRBHLAh>; Thu, 8 Feb 2001 06:00:37 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:45581 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129031AbRBHLAR>; Thu, 8 Feb 2001 06:00:17 -0500
Date: Thu, 8 Feb 2001 03:00:10 -0800
Message-Id: <200102081100.f18B0Am17975@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: vido@ldh.org
Cc: Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eepro100.c, kernel 2.4.1
In-Reply-To: <20010208194156.A19161@ldh.org>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001 19:41:56 +0900, Augustin Vidovic <vido@ldh.org> wrote:

> You can see a kind of sudden blackout which lasts about 3 hours, and then the
> situation resumes to normality.
> 
> At the same time, the /var/log/messages receives thousands of messages from the
> NET: subsystem.

So what _were_ those messages? Can you post them?

> Since the dmesg of the kernel tells about a work-around for such a bug, I was assuming
> that the work around was activated, but I had a doubt and after looking at the source,
> I discovered that it wasn't.

Well, your patch disables the work-around exactly for those (really old) cards
that actually need it and enables it for those that don't need it.

> Now, as Ion says, maybe it is not the "receiver lock-up bug" itself which is
> worked-around, frankly I don't know.

There is a very simple way to tell. Check your logs for messages like:

eth0: Sending a multicast list set command from a timer routine........."

If you find such messages, the work-around really did something. Otherwise,
it's the placebo effect...


Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
