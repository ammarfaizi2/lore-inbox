Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130801AbRANTTa>; Sun, 14 Jan 2001 14:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131066AbRANTTV>; Sun, 14 Jan 2001 14:19:21 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:64936 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S130801AbRANTTM>;
	Sun, 14 Jan 2001 14:19:12 -0500
Date: Sun, 14 Jan 2001 14:18:29 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.30.0101142006420.3610-100000@e2>
Message-ID: <Pine.GSO.4.30.0101141411060.12354-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Jan 2001, Ingo Molnar wrote:

>
> in this case there could still be valid performance differences, as
> copying from user-space is cheaper than copying from the pagecache. To
> rule out SMP interactions, you could try a UP-IOAPIC kernel on that box.
>

Let me complete this with the ZC patches first. then i'll do that.
There are a few retarnsmits; maybe receiver IRQ affinity might help some.

> (I'm also curious what kind of numbers you'll get with the zerocopy
> patch.)

Working on it.

> no, in the case of a single thread this should have minimum impact. But
> i'd suggest to increase the /proc/sys/net/tcp*mem* values (to 1MB or
> more).

The upper thresholds to 1000000 ?
I should have mentioned that i set /proc/sys/net/core/*mem*
to currently 262144.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
