Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWHVWCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWHVWCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 18:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWHVWCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 18:02:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750704AbWHVWCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 18:02:10 -0400
Date: Tue, 22 Aug 2006 15:01:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Nicholas Miell <nmiell@comcast.net>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-Id: <20060822150144.058d9052.akpm@osdl.org>
In-Reply-To: <20060822143747.68acaf99.rdunlap@xenotime.net>
References: <11561555871530@2ka.mipt.ru>
	<1156230051.8055.27.camel@entropy>
	<20060822072448.GA5126@2ka.mipt.ru>
	<1156234672.8055.51.camel@entropy>
	<20060822083711.GA26183@2ka.mipt.ru>
	<1156238988.8055.78.camel@entropy>
	<20060822100316.GA31820@2ka.mipt.ru>
	<1156276658.2476.21.camel@entropy>
	<20060822201646.GC3476@2ka.mipt.ru>
	<1156281182.2476.63.camel@entropy>
	<20060822143747.68acaf99.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 14:37:47 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Tue, 22 Aug 2006 14:13:02 -0700 Nicholas Miell wrote:
> 
> > On Wed, 2006-08-23 at 00:16 +0400, Evgeniy Polyakov wrote:
> > > On Tue, Aug 22, 2006 at 12:57:38PM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> > > > On Tue, 2006-08-22 at 14:03 +0400, Evgeniy Polyakov wrote:
> > > > Of course, since you already know how all this stuff is supposed to
> > > > work, you could maybe write it down somewhere?
> > > 
> > > I will write documantation, but as you can see some interfaces are
> > > changed.
> > 
> > Thanks; rapidly changing interfaces need good documentation even more
> > than stable interfaces simply because reverse engineering the intended
> > API from a changing implementation becomes even more difficult.
> 
> OK, I don't quite get it.
> Can you be precise about what you would like?
> 
> a.  good documentation
> b.  a POSIX API
> c.  a Windows-compatible API
> d.  other?
> 
> and we won't make you use any of this code.
> 

Today seems to be beat-up-Nick day?

This is a major, major new addition to the kernel API.  It's a big deal. 
Getting it documented prior to committing ourselves is a useful part of the
review process.  It certainly can't hurt, and it might help.  It is a
little too soon to spend too much time on that though.  (It's actually
_better_ if someone other than the developer writes the documentation,
too).


And the "why not emulate kqueue" question strikes me as an excellent one. 
Presumably a lot of developer thought and in-field experience has gone into
kqueue.  It would benefit us to use that knowledge as much as we can.

I mean, if there's nothing wrong with kqueue then let's minimise app
developer pain and copy it exactly.  If there _is_ something wrong with
kqueue then let us identify those weaknesses and then diverge.  Doing
something which looks the same and works the same and does the same thing
but has a different API doesn't benefit anyone.
