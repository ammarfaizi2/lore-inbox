Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTDTIAG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 04:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTDTIAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 04:00:06 -0400
Received: from dp.samba.org ([66.70.73.150]:30885 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263540AbTDTIAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 04:00:05 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] kstrdup 
In-reply-to: Your message of "19 Apr 2003 13:27:21 +0100."
             <1050755240.3277.3.camel@dhcp22.swansea.linux.org.uk> 
Date: Sun, 20 Apr 2003 18:05:40 +1000
Message-Id: <20030420081206.C68A62C01A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1050755240.3277.3.camel@dhcp22.swansea.linux.org.uk> you write:
> On Sad, 2003-04-19 at 05:48, Jeff Garzik wrote:
> > And?  It's still slower.
> 
> You are arguing over a 1 instruction, probably sub 1 clock scheduling
> matter on a call which is not used on any fast or common path. If you
> shaved 1 clock off the timer handling instead you'd make a lot more
> difference..

Hey, if we have 50 million machines running 2.6 for three years, this
optimization saves 100 clock cycles per boot (most kstrdups are device
init), and machines boot once a month, and average 1GHz, that's three
minutes of saved time.

I think Jeff and I should start the kstrdup sourceforge project
immediately...

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
