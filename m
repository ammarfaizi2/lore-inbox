Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSLLVb7>; Thu, 12 Dec 2002 16:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267524AbSLLVb6>; Thu, 12 Dec 2002 16:31:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56068 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264853AbSLLVb5>;
	Thu, 12 Dec 2002 16:31:57 -0500
Message-ID: <3DF90208.3010208@pobox.com>
Date: Thu, 12 Dec 2002 16:39:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: Roger Luethi <rl@hellgate.ch>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pci-skeleton duplex check
References: <Pine.LNX.4.44.0212121539110.10674-100000@beohost.scyld.com>
In-Reply-To: <Pine.LNX.4.44.0212121539110.10674-100000@beohost.scyld.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Becker wrote:
> On Thu, 12 Dec 2002, Jeff Garzik wrote:
> 
>>Donald Becker wrote:
>>
>>>[[ I don't know why I bother. The people that now control what goes into
>>>the kernel would rather put in random patches from other people than
>>>accept a correct fix from me. ]]
>>
>>I'm very interested in applying fixes from you!  I am publicly begging 
>>you to do so, and even CC'ing lkml on my request.
> 
> 
> This is very disingenuous statement.


Oh come on, it's far less disingenuous than what you said:

	[[ I don't know why I bother. The people that now control what
	   goes into the kernel would rather put in random patches from
	   other people than accept a correct fix from me. ]]

I'm sure you'll continue making snide comments on every mailing list you 
maintain, but the fact remains:

I would much rather accept a fix from you.

That hasn't changed in the past year.  or two.  or any amount of time. 
Your input is very valuable, and I typically save quite a few of your 
emails.


> The drivers in the kernel are now heavily modified and have significantly
> diverged from my version.  Sure, you are fine with having someone else
> do the difficult and unrewarding debugging and maintainence work, while
> you work on just the latest cool hardware, change the interfaces and are
> concerned only with the current kernel version.

While I disagree with this assessment, I think we can safely draw the 
conclusion that the problem is _not_ people ignoring your patches, or 
preferring other patches over yours.


> I've been actively developing Linux drivers for over a decade, and run
> about two dozen mailing lists for specific drivers.  I write diagnostic
> routines for every released driver.  I thoroughly test and frequently
> update the driver set I maintain.  And since about 2000, my patches were
> ignored while the first notice I've have gotten to changes in my drivers
> is the bug reports.  And the response: "submit a patch to fix those
> newly introduced bugs".  I've even had patches ignore in favor of people
> that wrote "I don't have the NIC, but here is a change".

I don't recall _ever_ getting a patch from you or seeing one posted on 
lkml or netdev.  How can you be ignored if you're not sending patches?


> A good example is the tulip driver.  You repeatedly restructured my
> driver in the kernel, splitting into different files.  It was still 90+%
> my code, but the changes made it impossible to track the modification
> history.  The kernel driver was long-broken with 21143-SYM cards, but no
> one took the responsibility for fixing it.

s/was/is/
I take responsibility for fixing it, I just haven't fixed it yet :)


> It's easy to make the first few patches, when you don't have to deal
> with reversion testing, many different models, and have an unlimited
> sandbox where it doesn't matter if a specific release works or not.  But
> it takes a huge of work to keep a stable, tracable driver development
> process that works with many different kernel versions and hardware
> environments.


We're slowly getting there, in terms of regression and stress testing.

Since you don't send patches anymore for a long time, I was really the 
only one [stupid enough?] to stand up and even bother to help collecting 
and reviewing net driver changes.

I would love to integrate your drivers directly, but they don't come 
anywhere close to using current kernel APIs.  The biggie of biggies is 
not using the pci_driver API.  So, given that we cannot directly merge 
your drivers, and you don't send patches to kernel developers, what is 
the next best alternative?  (a) let kernel net drivers bitrot, or (b) 
maintain them as best we can without Don Becker patches?  I say that "b" 
is far better than "a" for Linux users.

	Jeff



