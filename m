Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269461AbTHORIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270496AbTHORIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:08:40 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:61194 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S269461AbTHORGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:06:40 -0400
Date: Fri, 15 Aug 2003 19:14:05 +0200
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm1 interactivity scheduling mistakes (smp)
Message-ID: <20030815171405.GA925@hh.idb.hist.no>
References: <20030813180020.GA1339@hh.idb.hist.no> <1060798101.603.47.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060798101.603.47.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 08:08:21PM +0200, Felipe Alfaro Solana wrote:
> On Wed, 2003-08-13 at 20:00, Helge Hafting wrote:
> > I ran a "nice make -j3 bzImage" on 2.6.9-test3-mm1 in order
> > to compile 2.6.0-test3-mm2 on my dual celeron.
> > 
> > While waiting I played cuyo, a lightweight game similiar to tetris.
> > 
> > This mostly behaved as expected, with a responsive game.
> > But mozilla (on some other virtual desktop) occationally
> > refreshed its page, causing several seconds with jerky response
> > in the game.
> > 
> > This is wrong for two reasons:
> > 1. There should be enough cpu with two processors,
> >    one running the game and another the heavy mozilla stuff.
> >    The make was niced after all.  No guessing, I told it explicitly.
> > 
> > 2. The game has very interactive behaviour, it uses  4-10% cpu
> >    and cause X to use about 20%.  Mozilla may have been idle for a 
> >    while, getting "interactive".  But it shouldn't remain
> >    interactive  for so long,  it sat at 100% till it went
> >    idle again.   
> > 
> > X runs with elevated priority, (std. debian testing setup)
> > but that shouldn't matter - X only used 20% and that was
> > for the game and two xterms.  Mozilla wasn't visible
> > at all.
> 
> I can't tell you why, but for me, X behaves horribly if it's not reniced
> exactly at +0. In the past, I reniced X at -20, but Con told me that
> with O??int patches, X must/should work with no nicing at all.
> 
> Could you please try again with X not reniced?
I tried again with X not reniced - and it failed the same way.

Helge Hafting
