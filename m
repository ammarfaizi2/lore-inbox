Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbTFLRSm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTFLRSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:18:41 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:13184 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264905AbTFLRSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:18:36 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 12 Jun 2003 10:30:24 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Bryan O'Sullivan" <bos@serpentine.com>
cc: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       piggin@cyberone.com.au
Subject: Re: 2.5.70-mm8: freeze after starting X
In-Reply-To: <1055438377.1058.2.camel@serpentine.internal.keyresearch.com>
Message-ID: <Pine.LNX.4.55.0306121022400.3626@bigblue.dev.mcafeelabs.com>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com> 
 <20030611154122.55570de0.akpm@digeo.com> <1055374476.673.1.camel@localhost>
  <1055377120.665.6.camel@localhost> <20030611172444.76556d5d.akpm@digeo.com>
 <1055438377.1058.2.camel@serpentine.internal.keyresearch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jun 2003, Bryan O'Sullivan wrote:

> On Wed, 2003-06-11 at 17:24, Andrew Morton wrote:
>
> > Odd that starting the X server triggers it.  Be interesting if your patch
> > fixes things for Brian.
>
> I think Robert and I are seeing different things.  For me, -mm6 is fine
> (unlike Robert's case), -mm7 oopses in the PCI init code during early
> boot (somewhere in the radeon init stuff, can't capture the oops
> easily), and -mm8 gives itself a wedgie a few seconds after starting X.
>
> I'm about to try, um, whichever of the umpty-ump patches that went back
> and forth looks most plausible.

I'm having total freezes with 2.5.69 in both my home laptop with a SiS650
chipset and in my machine at work with Intel Corp. 82845G/GL. Using X with
Gnome (RH9) the system will end up to a completely frozen state after a
random amount of time. This happens with almost no activity on the machine
that makes me thing to be not related to some kind of load. IRQ are
disabled and the IDE drive light remains on. I planned to debug the thing
but I didn't have time yet. I set up the NMI oopser and I need to do
something to get the dump since when the NMI trigger I'm in graphic mode.
I was thinking about LKCD. It has never happened in console mode so it
must be X/Gnome+2.5.69



- Davide

