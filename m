Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275338AbTHMSIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275339AbTHMSIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:08:30 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:23300 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S275338AbTHMSIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:08:24 -0400
Subject: Re: 2.6.0-test3-mm1 interactivity scheduling mistakes (smp)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030813180020.GA1339@hh.idb.hist.no>
References: <20030813180020.GA1339@hh.idb.hist.no>
Content-Type: text/plain
Message-Id: <1060798101.603.47.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 13 Aug 2003 20:08:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-13 at 20:00, Helge Hafting wrote:
> I ran a "nice make -j3 bzImage" on 2.6.9-test3-mm1 in order
> to compile 2.6.0-test3-mm2 on my dual celeron.
> 
> While waiting I played cuyo, a lightweight game similiar to tetris.
> 
> This mostly behaved as expected, with a responsive game.
> But mozilla (on some other virtual desktop) occationally
> refreshed its page, causing several seconds with jerky response
> in the game.
> 
> This is wrong for two reasons:
> 1. There should be enough cpu with two processors,
>    one running the game and another the heavy mozilla stuff.
>    The make was niced after all.  No guessing, I told it explicitly.
> 
> 2. The game has very interactive behaviour, it uses  4-10% cpu
>    and cause X to use about 20%.  Mozilla may have been idle for a 
>    while, getting "interactive".  But it shouldn't remain
>    interactive  for so long,  it sat at 100% till it went
>    idle again.   
> 
> X runs with elevated priority, (std. debian testing setup)
> but that shouldn't matter - X only used 20% and that was
> for the game and two xterms.  Mozilla wasn't visible
> at all.

I can't tell you why, but for me, X behaves horribly if it's not reniced
exactly at +0. In the past, I reniced X at -20, but Con told me that
with O??int patches, X must/should work with no nicing at all.

Could you please try again with X not reniced?
Thanks!

