Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbTIVQ0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbTIVQ0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:26:12 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:29057 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263206AbTIVQ0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:26:07 -0400
Date: Mon, 22 Sep 2003 17:26:02 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Message-ID: <20030922162602.GB27209@mail.jlokier.co.uk>
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com> <1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> (one part of the problem of course is you need inb_p/outb_p to drive
> the timer chip on some x86 boards in order to calibrate the udelay
> timer)

What sort of timer chip problems do you see?  Is it something that can
be auto-detected, so that timer chip accesses can be made faster on
boards where that is fine?

I'm sure I've seen timer chip code in DOS programs that didn't have
the extra delay I/Os.  Surely it cannot be a very widespread problem.

> > When debugging this I modified arch/i386/io.h to read:
> > #define  __SLOW_DOWN_IO__ ""
> > Which totally removed the delay and the system ran fine.
> 
> Not all systems do - we had breakages from both the keyboard controller
> and the timer chips even on some modern boards when this got messed up.

I've also seen much DOS code that didn't have extra delays for
keyboard I/Os.  What sort of breakage did you observe with the
keyboard?

Thanks,
-- Jamie
