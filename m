Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbTIVVrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTIVVrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:47:09 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:42625 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263075AbTIVVrF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:47:05 -0400
Date: Mon, 22 Sep 2003 22:46:53 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Message-ID: <20030922214653.GD29869@mail.jlokier.co.uk>
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com> <1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk> <20030922162602.GB27209@mail.jlokier.co.uk> <1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk> <1064250691.6235.2.camel@laptop.fenrus.com> <20030922182808.GA28372@mail.jlokier.co.uk> <20030922212718.A13166@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922212718.A13166@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> > > The first person to complain about the extra branch miss in udelay for
> > > this will get laughed at by me ;)
> > 
> > udelay(1) is too slow on a 386 even without the branch miss.
>
> ok we have ndelay() now as well in 2.6

I was sort of joking, but the point is that a function call might be
too slow on a 386.

On a 386, a function call for every byte transferred to/from the
floppy disk might show up as a real overhead - this occurred to me
because someone once thought it was worth rewriting the floppy data
transfer code in assembly language, and presumably it did improve
performance at the time.

Of course the answer is to not use udelay() on 386-optimised
configurations.

-- Jamie

