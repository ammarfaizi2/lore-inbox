Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268160AbTBXGZd>; Mon, 24 Feb 2003 01:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268163AbTBXGZd>; Mon, 24 Feb 2003 01:25:33 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:36359 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S268160AbTBXGZc>;
	Mon, 24 Feb 2003 01:25:32 -0500
Date: Sun, 23 Feb 2003 23:22:30 -0700
From: Val Henson <val@nmt.edu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224062230.GD16803@boardwalk>
References: <20030222231552.GA31268@work.bitmover.com> <Pine.LNX.3.96.1030223183404.999F-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030223183404.999F-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 06:57:09PM -0500, Bill Davidsen wrote:
> On Sat, 22 Feb 2003, Larry McVoy wrote:
> > 
> > But that's a false promise because by definition, fine grained threading
> > adds more bus traffic.  It's kind of hard to not have that happen, the
> > caches have to stay coherent somehow.
> 
> Clearly. And things which require more locking will pay some penalty for
> this. But a quick scan of this list on keyword "lockless' will show that
> people are thinking about this.

Lockless algorithms still generate bus traffic when you do the atomic
compare-and-swap or load-linked or whatever hardware instruction you
use to implement your lockless algorithm.  Caches still have to stay
coherent, lock or no lock.

-VAL
