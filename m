Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWEPUhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWEPUhh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 16:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWEPUhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 16:37:37 -0400
Received: from relay03.pair.com ([209.68.5.17]:23057 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1750757AbWEPUhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 16:37:37 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 16 May 2006 15:37:35 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Theodore Tso <tytso@mit.edu>
cc: Zvi Gutterman <zvi@safend.com>, "'Muli Ben-Yehuda'" <muli@il.ibm.com>,
       "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Jonathan Day'" <imipak@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: /dev/random on Linux
In-Reply-To: <20060516201749.GA10077@thunk.org>
Message-ID: <Pine.LNX.4.64.0605161534140.32181@turbotaz.ourhouse>
References: <20060516082859.GD18645@rhun.haifa.ibm.com>
 <00fc01c678f0$30c77520$2c02a8c0@Safend.com> <20060516201749.GA10077@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006, Theodore Tso wrote:
B>
> 3) Investigate the possibility of adding quotas to /dev/random.  This
> is actually much more trickier that the paper suggests, since you want
> to allow the user to be able to extract enough entropy to create a
> 2048 bit (or at least a 1024-bit) RSA key.  The problem is that's a
> lot of entropy!  Maybe it would be OK to only allow a 1024-bit RSA key
> to be generated every 12 or 24 hours, but suppose someone is
> experimenting with GPG and screws up (say they forget their
> passphrase); do you tell them that sorry, you can't generating another
> key until tomorrow?  So now we have to have an interface so the root
> user can reset the user's entropy quota....  And even with a 24-hour
> limit, on a diskless system, you don't get a lot of entropy, so even a
> 1024-bit RSA key could seriously deplete your supply of entropy.

#3 is fine if it's out of the kernel. This isn't just policy - it's 
complicated policy, as you point out quite well.

> This last point is a good example of the concerns one faces when
> trying to design a working system in the real word, as opposed to the
> concerns of academicians, where the presence or lack of forward
> security in the event of a pool compromise is issue of massive urgency
> and oh-my-goodness-we-can-only-tell-the-maintainer-because-it's-such-a-
> critical-security-hole attitude.  Where as my attitude is, "yeah, we
> should fix it, but I doubt anyone has actually been harmed by this in
> real life", which puts it in a different category than a buffer
> overrun attack which is accessible from a publically available network
> service.
>

Slashdot headline about Linux's weak-ass rng should be up shortly, next to 
the news post discussing what Linus had for breakfast this morning.

> 						- Ted

Thanks,
Chase
