Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265554AbUABTAP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265557AbUABTAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:00:15 -0500
Received: from firewall.conet.cz ([213.175.54.250]:42396 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265554AbUABTAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:00:10 -0500
Message-ID: <3FF5BF68.8060303@conet.cz>
Date: Fri, 02 Jan 2004 19:58:48 +0100
From: Libor Vanek <libor@conet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Christoph Hellwig <hch@infradead.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
References: <3FF56B1C.1040308@conet.cz> <20040102151206.GJ1718@actcom.co.il> <3FF59073.3060305@conet.cz> <20040102160020.A24026@infradead.org> <20040102163552.GD31489@wohnheim.fh-wedel.de> <3FF5A36A.5070501@conet.cz> <20040102180431.GB6577@wohnheim.fh-wedel.de>
In-Reply-To: <20040102180431.GB6577@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 07:04:31PM +0100, Jörn Engel wrote:
> On Fri, 2 January 2004 17:59:22 +0100, Libor Vanek wrote:
> > >My guess is that the filesystem change notification would be a better
> > >solution, either in userspace or in kernelspace, doesn't matter.  But
> > >that is far from finished or even generally accepted.
> > 
> > This is also something (but just a bit) different - I don't need "change 
> > notification" but "pre-change notification" ;)
> 
> "Vor dem Spiel ist nach dem Spiel" -- Sepp Herberger
> 
> Except for exactly two cases, pre-change and post-change and the same,
> just off-by-one.  So you would need a bootup/mount/whenever special
> case now, is that a big problem?

Probably my english is bad but I don't understand what are you trying to say (except the german part ;-))
A bit more about pre/post-change (if this is what are you trying to say) - I need allways pre-change because after file is changed I can no longer get original (pre-change) version of file which I need for snapshot.

> > >For the diploma thesis, feel free to use any hack you like, including
> > >hijacking syscalls.  But remember that it is a hack and nothing else,
> > >only helping you to remain on schedule and focus more on the real
> > >subject.  And don't plan on kernel acceptance either, as you will fail
> > >either that or the thesis and I'd choose the thesis.
> > 
> > You're absolutely right but when I'm going to spent several weeks on 
> > something like this I'd like to do something usefull - not something 
> > which will be trashed after exam. So I'm trying to find out some 
> > "politically correct" way.
> 
> Then seperate the two problems.  One is to figure out, what has
> changed and two is to act accordingly.  Two should be pretty
> independent on this threads subject.  If that part is really useful,
> people will help you on problem one.  Postpone. :)
> ...
> Ok, back to your problem.  Seperation is the way to go.  Problem one
> is a hard one and it takes a lot of time to do right.  But hacking it
> up is quite simple, so you can save time with the hack and do it right
> only if your solution to problem two proved good enough.

Yes - that's what I'm now doing. Just now I'm going to reboot my machine (<grr>) and try if EXPORT_SYMBOL(sys_open) works as I think it should ;)

Anyway - thanks for hints.

--
Libor Vanek



