Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbUK2DX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUK2DX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 22:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbUK2DX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 22:23:59 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:5342 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261619AbUK2DXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 22:23:55 -0500
Subject: Re: Suspend 2 merge
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20041128235530.GB2856@elf.ucw.cz>
References: <20041124132839.GA13145@infradead.org>
	 <1101329104.3425.40.camel@desktop.cunninghams>
	 <20041125192016.GA1302@elf.ucw.cz>
	 <1101422088.27250.93.camel@desktop.cunninghams>
	 <20041125232200.GG2711@elf.ucw.cz>
	 <1101426416.27250.147.camel@desktop.cunninghams>
	 <20041126003944.GR2711@elf.ucw.cz>
	 <1101455756.4343.106.camel@desktop.cunninghams>
	 <20041126123847.GD1028@elf.ucw.cz>
	 <1101680972.4343.300.camel@desktop.cunninghams>
	 <20041128235530.GB2856@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101698428.4343.336.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 29 Nov 2004 14:20:28 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-11-29 at 10:55, Pavel Machek wrote:
> Hi!
> 
> > > My machine suspends in 7 seconds, and that's swsusp1. According to
> > > your numbers, suspend2 should suspend it in 1 second and LZE
> > > compressed should be .5 second.
> > 
> > Seven seconds? How much memory is in use when you start, and how much is
> > actually written to disk? If you're starting with 1GB of RAM in use,
> > I'll sit up and listen, but I suspect you're talking about something
> > closer to 20MB and init S :>
> 
> It was on .5GB machine, with X running, IIRC. Specify how should I
> load the system and I'll try it here. swsusp1 got some speedups with
> O(n^2) killing (not yet merged).

So it wrote .5GB of memory in seven seconds, or started with .5GB of RAM
in use?

If we want to compare apples with apples, we're going to have to make
the only difference which code is run. A normal load on my computer is
evolution, cyrus imapd, opera, win4lin running Libronix and a kernel
tree in the cache (last image sizes were 1000, 1002, 995, 949 and
910MB). I'm happy to run your sped-up code for some tests, if you'd
like. You know where to find mine if you want to make sure I'm not
cheating :>

> > These discussions are getting really unreasonable. "I don't want that
> > feature, therefore it shouldn't be merged" isn't a valid argument.
> > Neither is "Well, I can suspend in seven seconds with hardly any memory
> > in use." If you just don't want suspend2 in the kernel, come out and say
> > it. 
> 
> Ok, "I do not want suspend2 in kernel". Not what you'd call suspend2,
> anyway. I thought that stripping down suspend2 then merging it is
> reasonable way to go, but now it seems to me that enhancing swsusp1 is
> easier way to go. At least I'll be able to do it incrementally.

You'll be able to do that within limits, but once you do seriously given
up on the max-half-of-memory limit, you'll need some major redesigning.
If that's the way you want to go, okay. Assuming nothing else changes,
I'll just keep suspend2 alive outside of the kernel tree until you get
sick of users asking, and continue to enhance it.

> I'm sorry about all the confusion, and you can still get that jpeg for
> "put pavel into doom3".

I'm not taking it personally at all. I did find some of the objections
pretty petty and some of the comparisons grossly unfair, but I'm not
taking it personally.
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

