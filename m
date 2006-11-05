Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbWKELUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbWKELUO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 06:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWKELUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 06:20:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65180 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932641AbWKELUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 06:20:10 -0500
Date: Sun, 5 Nov 2006 12:19:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Nate Diller <nate.diller@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Oleg Verych <olecom@flower.upol.cz>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061105111933.GB4965@elf.ucw.cz>
References: <20061101160551.GA2598@elf.ucw.cz> <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz> <20061101185745.GA12440@2ka.mipt.ru> <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com> <20061102062158.GC5552@2ka.mipt.ru> <5c49b0ed0611021140u360342f2v1e83c73d03eea329@mail.gmail.com> <20061103084240.GB1184@2ka.mipt.ru> <20061103085712.GA3725@elf.ucw.cz> <20061103091301.GC1184@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061103091301.GC1184@2ka.mipt.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri 2006-11-03 12:13:02, Evgeniy Polyakov wrote:
> On Fri, Nov 03, 2006 at 09:57:12AM +0100, Pavel Machek (pavel@ucw.cz) wrote:
> > > So, kqueue API and structures can not be usd in Linux.
> > 
> > Not sure what you are smoking, but "there's unsigned long in *bsd
> > version, lets rewrite it from scratch" sounds like very bad idea. What
> > about fixing that one bit you don't like?
> 
> It is not about what I dislike, but about what is broken or not.
> Putting u64 instead of a long or some kind of that _is_ incompatible
> already, so why should we even use it?

Well.. u64 vs unsigned long *is* binary incompatible, but it is
similar enough that it is going to be compatible at source level, or
maybe userland app will need *minor* ifdefs... That's better than two
completely different versions...

> And, btw, what we are talking about? Is it about the whole kevent
> compared to kqueue in kernelspace, or just about what structure is being
> transferred between kernelspace and userspace?
> I'm sure, it was some kind of a joke to 'not rewrite *bsd from scratch
> and use kqueue in Linux kernel as is'.

No, it is probably not possible to take code from BSD kernel and "just
port it". But keeping same/similar userland interface would be nice.
										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
