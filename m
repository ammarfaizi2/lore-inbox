Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVC1P0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVC1P0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 10:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVC1P0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 10:26:47 -0500
Received: from colin2.muc.de ([193.149.48.15]:38663 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261880AbVC1P0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 10:26:05 -0500
Date: 28 Mar 2005 17:26:00 +0200
Date: Mon, 28 Mar 2005 17:26:00 +0200
From: Andi Kleen <ak@muc.de>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 preemption fix from IRQ and BKL in 2.6.12-rc1-mm2
Message-ID: <20050328152600.GB26121@muc.de>
References: <20050324044114.5aa5b166.akpm@osdl.org> <1111778785.14840.13.camel@leto.cs.pocnet.net> <20050327172625.GC18506@muc.de> <1111946713.20987.16.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111946713.20987.16.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 08:05:13PM +0200, Christophe Saout wrote:
> Am Sonntag, den 27.03.2005, 19:26 +0200 schrieb Andi Kleen:
> 
> > > preempt_schedule_irq is not an i386 specific function and seems to take
> > > special care of BKL preemption and since reiserfs does use the BKL to do
> > > certain things I think this actually might be the problem...?
> > 
> > Hmm, preempt_schedule_irq is not in mainline as far as I can see.
> > My patches are always for mainline; i dont do a special
> > patch kit for -mm*
> 
> PREEMPT_BKL has been in mainline since 2.6.11-rc1,  preempt_schedule_irq
> made it in 2.6.11-rc3. Please look here:
> http://linux.bkbits.net:8080/linux-2.6/search/?expr=preempt_schedule_irq&search=ChangeSet+comments

Hmm, true. I must have missed it with the last merge.

Looking at the changeset your simple patch is probably ok.


> 
> Now that I looked into it I think that it's obviously the correct
> solution.

Agreed.

-Andi
