Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUBPXtq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUBPXtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:49:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:63397 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265944AbUBPXtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:49:43 -0500
Date: Mon, 16 Feb 2004 15:49:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: David Eger <eger@theboonies.us>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-rc3 radeonfb: Problems with new (and old) driver
In-Reply-To: <1076974304.1046.102.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402161546460.30742@home.osdl.org>
References: <Pine.LNX.4.50L0.0402160411260.2959-100000@rosencrantz.theboonies.us>
  <1076904084.12300.189.camel@gaston>  <Pine.LNX.4.58.0402160947080.30742@home.osdl.org>
  <1076968236.3648.42.camel@gaston>  <Pine.LNX.4.58.0402161410430.30742@home.osdl.org>
  <1076969892.3649.66.camel@gaston>  <Pine.LNX.4.58.0402161420390.30742@home.osdl.org>
  <1076972267.3649.81.camel@gaston>  <Pine.LNX.4.58.0402161503490.30742@home.osdl.org>
 <1076974304.1046.102.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Benjamin Herrenschmidt wrote:
> > 
> > So _logically_ the interface should be more of a "con_notify_change()"  
> > one, with a bitmap of which states have changed (where "graphics vs text"
> > is just one set of states - resultion is another, VC backing store is one,
> > etc etc).
>
> Ok, if it's ok to delay it to 2.6.4, i'd prefer going all the way trough
> calling it properly and passing the proper "state" flags instead of
> hacking more on broken blank/unblank semantics. It can stay in -mm for
> a while if we want enough testing.

Oh, there is no hurry with this. In fact, I'd rather take it slow than try 
to make any big changes to something that _largely_ works but has problems 
in some special cases.

In fact, I'd be happiest if the first step would be to just rename the
interface and change the argument infrastructure, but actually keep all
the behaviour "obviously the same". Bugs and all, if it comes to that. So
I'd rather take several small steps (and let people use it for a while in
between) than try to do everything. And yes, 2.6.3 is not even a target.

			Linus
