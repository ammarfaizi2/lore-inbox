Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270674AbTG0FZj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 01:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270675AbTG0FZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 01:25:28 -0400
Received: from co239024-a.almel1.ov.home.nl ([217.120.226.100]:20099 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270674AbTG0FZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 01:25:24 -0400
Date: Sun, 27 Jul 2003 07:38:51 +0200 (CEST)
From: Aschwin Marsman <a.marsman@aYniK.com>
X-X-Sender: marsman@localhost.localdomain
To: Arjan van de Ven <arjanv@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove module reference counting.
In-Reply-To: <20030726193743.B20667@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0307270735360.2141-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jul 2003, Arjan van de Ven wrote:

> On Sat, Jul 26, 2003 at 12:31:25PM -0700, Linus Torvalds wrote:
> > 
> > On Sat, 26 Jul 2003, Rusty Russell wrote:
> > > 
> > > No, it would just leak memory.  Not really a concern for developers.
> > > It's fairly trivial to hack up a backdoor "remove all freed modules
> > > and be damned" thing for developers if there's real demand.
> > 
> > It's not just a developer thing. At least installers etc used to do some 
> > device probing by loading modules and depending on the result.
> 
> yes but those same installers couldn't care less if the kernel
> completely frees the memory of the module text or if it leaks that.
> It won't even notice the difference....

But doesn't the same happen when e.g. kudzu tries to detect new hardware?
This is running every time my RH system boots, so memory leaks at that 
moment do not appeal to me. When it's only an installer thing, it doesn't
worry me, although from an engineering perspective...

Have fun,
 
Aschwin Marsman
 
--
aYniK Software Solutions         all You need is Knowledge
P.O. box 134                     NL-7600 AC Almelo - the Netherlands
a.marsman@aYniK.com              http://www.aYniK.com

