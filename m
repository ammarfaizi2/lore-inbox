Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262346AbRENRtJ>; Mon, 14 May 2001 13:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262349AbRENRs7>; Mon, 14 May 2001 13:48:59 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:26631 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262346AbRENRsl>;
	Mon, 14 May 2001 13:48:41 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200105141747.VAA15542@ms2.inr.ac.ru>
Subject: Re: NETDEV_CHANGE events when __LINK_STATE_NOCARRIER is modified
To: andrewm@uow.edu.au (Andrew Morton)
Date: Mon, 14 May 2001 21:47:41 +0400 (MSK DST)
Cc: davem@redhat.COM, linux-kernel@vger.kernel.org
In-Reply-To: <3AFF384B.7382B436@uow.edu.au> from "Andrew Morton" at May 14, 1 11:43:39 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Jeff has introduced `alloc_etherdev()' which allocates storage
> for a netdev but doesn't register it.  The one quirk with this
> approach (and why it's vastly simpler than my thing) 

I do not see where it is simpler. The only difference is that
name is unknown. 8)


> Not many drivers have been converted to the new interface yet.

Paaardon! It is the only place where it takes sense to tell: "simpler"
and it was sense of your patch! Of course, it is much "simpler" to leave
all the devices in buggy state, no doubts. 8)

What's about dev_probe_lock, I again do not understand why it is not deleted.
Please, shed some light.


> is a bit foggy.  ISTR that the init() method was inherently
> immune to this race.

8) Imagine, I believed that all the devices use this method for years.
The discovery that init_etherdev does some shit was real catharsis. 8)

Alexey
