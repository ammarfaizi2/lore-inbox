Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVHVVlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVHVVlP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVHVVlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:41:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48514 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751253AbVHVVlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:41:15 -0400
Date: Mon, 22 Aug 2005 14:43:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brent Casavant <bcasavan@sgi.com>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] external interrupts
Message-Id: <20050822144330.791ba7b3.akpm@osdl.org>
In-Reply-To: <20050822155852.N325@chenjesu.americas.sgi.com>
References: <20050819160716.U87000@chenjesu.americas.sgi.com>
	<20050820222159.GP516@openzaurus.ucw.cz>
	<20050822155852.N325@chenjesu.americas.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent Casavant <bcasavan@sgi.com> wrote:
>
> On Sun, 21 Aug 2005, Pavel Machek wrote:
> 
> > > Here is a set of patches that implements an external interrupt capability
> > > in Linux, along with a device driver for a specific hardware device.  I
> > > submitted the patches several weeks ago, and they drew no comments, which
> > > I take to be a good sign.  Anyway, I'm 
> > It was not good sign in this particular case. My reaction was "this is _so_
> > overengineered tjat he's probably joking".
> 
> Laughter was not wholly unexpected, though I wasn't joking.  I'm trying
> to be realistic about the lifetime of any given hardware, and IOC4 is
> several years old at this point.  Couple that with a sincere desire to
> preserve application source compatability when (not if) new hardware
> appears, and an abstraction layer seemed to be a logical choice.  I'm
> more than happy to discuss problems in the abstraction layer's interface
> and make appropriate changes -- I'm nothing if not obliging.

Having an abstraction layer for a single client driver does seem a bit
pointless.  It would become more pointful if other client drivers were to
pop up.

Hence an option would be to merge an IOC4-specific driver which just does
what you need, no abstraction layer.  If someone later comes up with a
requirement for a driver for similar-looking hardware then we can resurrect
the abstraction layer at that stage.
