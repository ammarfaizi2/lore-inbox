Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030558AbVJGXKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030558AbVJGXKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 19:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030556AbVJGXKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 19:10:51 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:22476 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030558AbVJGXKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 19:10:50 -0400
Date: Sat, 8 Oct 2005 01:11:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt10 build problem (now rt12)
Message-ID: <20051007231126.GA17919@elte.hu>
References: <1128619072.4593.16.camel@cmn3.stanford.edu> <20051007114126.GC857@elte.hu> <1128714933.23974.3.camel@cmn3.stanford.edu> <20051007211654.GA14996@elte.hu> <1128725801.23974.20.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128725801.23974.20.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> On Fri, 2005-10-07 at 23:16 +0200, Ingo Molnar wrote:
> > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > 
> > > On Fri, 2005-10-07 at 13:41 +0200, Ingo Molnar wrote:
> > > > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > > > 
> > > > > Maybe not related to rt10, but still can't build it, ".config" 
> > > > > attached:
> > > > 
> > > > ok, i fixed this in -rt11, does it build for you now?
> > > 
> > > rt12 bombs here on the smp/i686 compile (smp config attached):
> > 
> > ok - i have fixed these and have released -rt13 - does it work for you?
> 
> The kernel finally builds but I'm getting these on a depmod -a, will
> check further:
> 
> WARNING: /lib/modules/2.6.13-0.7.rdt.rhfc4.ccrma/kernel/drivers/input/gameport/gameport.ko needs unknown symbol local_irq_restore_nort
> WARNING: /lib/modules/2.6.13-0.7.rdt.rhfc4.ccrma/kernel/drivers/input/gameport/gameport.ko needs unknown symbol local_irq_save_nort

should go away if you add this to drivers/input/gameport.c:

#include <linux/interrupt.h>

	Ingo
