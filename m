Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272275AbTHRTO7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272273AbTHRTO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:14:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:51675 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274972AbTHRTKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:10:31 -0400
Date: Mon, 18 Aug 2003 12:10:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix up riscom8 driver to use work queues instead of task queueing.
In-Reply-To: <20030818195903.G1737@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308181205150.5929-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Aug 2003, Russell King wrote:
> 
> True.  However, there is the opposite point of view which is equally
> valid.  There aren't many people with the hardware, and the people
> that there are aren't interested in development kernel series, so
> even if we did convert them during 2.7, we wouldn't hear about it
> until 2.8.

Yes. However, what worries me more is that there are people who have the 
hardware, but because the driver won't even compile for them, they just go 
"oh, well, I'll try it again when the _real_ 2.6.0 hits the streets".

Which obviously won't work.

So I'm trying to make sure that all the broken drivers are gotten to a 
working state. Right now, considering how long they've been broken, that 
means "it must compile" so that people can test them. 

The "leave it broken, so that somebody will fix it properly some day" 
approach is a fine one for early development series. But right now I'd 
prefer to see patches to make drivers compile cleanly, even if people 
can't test them on real hardware.

The intersection of people who have the hardware, and people who have the 
time/knowledge to convert a driver, may be empty. Expecially for odd 
hardware. So let's get those drivers compiling, even if we can't test 
them, so that others _can_ test them.

		Linus

