Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262958AbUKRT4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbUKRT4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbUKRTyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:54:18 -0500
Received: from brown.brainfood.com ([146.82.138.61]:130 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S262948AbUKRTwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:52:13 -0500
Date: Thu, 18 Nov 2004 13:51:58 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: Christian Meder <chris@onestepahead.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-0
In-Reply-To: <20041118195830.GA25938@elte.hu>
Message-ID: <Pine.LNX.4.58.0411181351370.1272@gradall.private.brainfood.com>
References: <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
 <20041117124234.GA25956@elte.hu> <1100773441.3434.4.camel@localhost>
 <20041118161129.GD12483@elte.hu> <1100795964.3699.3.camel@localhost>
 <20041118195830.GA25938@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Ingo Molnar wrote:

>
> * Christian Meder <chris@onestepahead.de> wrote:
>
> > > could you try this with the vanilla 2.6.10-rc2-mm1 kernel too? The crash
> > > you got is an escallation of a crash within a critical section, but that
> > > original crash does not seem to be directly related to PREEMPT_RT.
> >
> > Ok, tried it now. The output from 2.6.10-rc2-mm1 on removal of the prism
> > pccard is pretty innocuous and everything works fine:
> >
> > Nov 18 17:29:27 localhost kernel: hostap_cs: CS_EVENT_CARD_REMOVAL
> > Nov 18 17:29:27 localhost kernel: wifi0: card already removed or not
> > configured during shutdown
> > Nov 18 17:29:27 localhost kernel: wifi0: Interrupt, but dev not OK
> > Nov 18 17:29:27 localhost kernel: hostap_cs: Driver unloaded
>
> ok. Could you please retry with the latest kernel and USE_FRAME_POINTERS
> enabled? It wasnt completely clear from your previous log precisely
> which function generated the fault so it would be easier for me to sort
> it out if you could reproduce it once more.

That's CONFIG_FRAME_POINTER, btw.
