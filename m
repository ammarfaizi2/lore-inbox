Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUCDNCK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUCDNBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:01:50 -0500
Received: from ns.suse.de ([195.135.220.2]:24806 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261878AbUCDNBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:01:47 -0500
Date: Thu, 4 Mar 2004 14:01:48 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: amitkale@emsyssoft.com, george@mvista.com, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, piggy@timesys.com,
       trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
Message-Id: <20040304140148.73574a24.ak@suse.de>
In-Reply-To: <20040303211850.05d44b4a.akpm@osdl.org>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel>
	<40467BC3.7030708@mvista.com>
	<20040304015056.4d2cc3ee.ak@suse.de>
	<200403041036.58827.amitkale@emsyssoft.com>
	<20040303211850.05d44b4a.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004 21:18:50 -0800
Andrew Morton <akpm@osdl.org> wrote:

> "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> >
> > Flashing keyboard lights is easy on x86 and x86_64 platforms. 
> 
> Please, no keyboards.  Some people want to be able to use kgdboe
> to find out why machine number 324 down the corridor just died.

Not as the only indication I agree. But for machines running X that
are actually used by people I think it's important to always give some kind 
of visual feedback when the X server freezes. And kgdb will make the X server
freeze. You could actually make it a notifier list to register severals
ways to do this, e.g. the cluster people could add something that makes
it flash a warning light. For a standard box I think flashing the keyboard
is a good default for now

(ok there are USB keyboards too, for those there will need to be a different
solution)

> 
> char *why_i_crashed;
> 
> 
> {
> 	...
> 	if (expr1)
> 		why_i_crashed = "hit a BUG";
> 	else if (expr2)
> 		why_i_crashed = "divide by zero";
> 	else ...
> }
> 
> then provide a gdb macro which prints out the string at *why_i_crashed?

That doesn't tell the user at all why his X server just froze.
But it may be a good addition.

-Andi

