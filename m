Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276448AbRJCQQv>; Wed, 3 Oct 2001 12:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276451AbRJCQQo>; Wed, 3 Oct 2001 12:16:44 -0400
Received: from chiara.elte.hu ([157.181.150.200]:50952 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276448AbRJCQQ2>;
	Wed, 3 Oct 2001 12:16:28 -0400
Date: Wed, 3 Oct 2001 18:14:32 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ben Greear <greearb@candelatech.com>
Cc: jamal <hadi@cyberus.ca>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BBB3845.DAE47D27@candelatech.com>
Message-ID: <Pine.LNX.4.33.0110031808100.8633-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001, Ben Greear wrote:

> So, couldn't your NAPI patch be used by drivers that are updated, and
> let Ingo's patch be a catch-all for un-fixed drivers?  As we move
> foward, more and more drivers support your version, and Ingo's patch
> becomes less utilized.  So long as the patches are tuned such that
> yours keeps Ingo's from being triggered on devices you support, there
> should be no real conflict, eh?

exactly. auto-mitigation will not hurt NAPI-enabled devices the least.
Also, auto-mitigation is device-independent.

perhaps Jamal misunderstood the nature of my patch, so i'd like to state
it again: auto-mitigation is a feature that is not triggered normally. I
did a quick hack yesterday to include kpolld - that was a mistake, i was
wrong, and i've removed it. kpolld was mostly an experiment to prove that
TCP network connections can be fully functional during extreme overload
situations as well. Also, auto-mitigation will be a nice mechanizm to make
people more aware of the NAPI patch: if they ever notice 'Possible IRQ
overload:' messages then they can be told to try the NAPI patches.

	Ingo

