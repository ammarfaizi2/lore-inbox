Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290516AbSAQWxy>; Thu, 17 Jan 2002 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290515AbSAQWxo>; Thu, 17 Jan 2002 17:53:44 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:61412 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S290513AbSAQWxd>; Thu, 17 Jan 2002 17:53:33 -0500
Date: Thu, 17 Jan 2002 22:53:31 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: probably very irrelevant oops
In-Reply-To: <3C4739D3.DCFFA025@zip.com.au>
Message-ID: <Pine.LNX.4.44.0201172247040.24397-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:53 -0800 Andrew Morton wrote:

>> find /lib/modules/2.4.17-expt/kernel/ -type f|while read i; do insmod $i; done

[etc..]

>You're sick.  I like you.

I'm only using the sledgehammers you guys give me :)

[snip]
>
>It appears that one of the modules failed to unregister itself
>from the global driver list.  Then when the next module went
>walking the list, it tried to refer to the bad module's vmalloc'ed
>space.
>
>One strange thing: why was it `modprobe' which crashed?  Were you
>not purely running `rmmod' at the time?

I was, but maybe magicdev or something got in the way. I'll try it with no
GUI or any crazy daemons loaded.

>The bug probably is in the module which immediately preceded
>es1371 in your /proc/modules output.  Could you please load
>them all up again, send me your /proc/modules output?

I will do, when I'm back at work. I don't fancy remote crashing my
machine!

>Also, change your scripts to print out the names of the modules
>as they're being loaded and unloaded, run the test again and
>see which modules were being loaded/unloaded shortly before the
>crash.

Sure :)

