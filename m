Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSJILOK>; Wed, 9 Oct 2002 07:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261525AbSJILOK>; Wed, 9 Oct 2002 07:14:10 -0400
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:12674 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261523AbSJILOK>;
	Wed, 9 Oct 2002 07:14:10 -0400
Date: Wed, 9 Oct 2002 12:19:24 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christer Weinigel <christer@weinigel.se>, simon@baydel.com,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
Message-ID: <20021009111924.GA6939@bjl1.asuk.net>
References: <3DA16A9B.7624.4B0397@localhost> <3DA1CF36.19659.13D4209@localhost> <1034022158.26550.28.camel@irongate.swansea.linux.org.uk> <87smzhzy6l.fsf@zoo.weinigel.se> <1034031138.26473.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034031138.26473.40.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mon, 2002-10-07 at 23:22, Christer Weinigel wrote:
> > #define printk_debug(xxx...) printk(KERN_DEBUG, xxx...)
> > #define printk_info(xxx...) printk(KERN_INFO, xx...)
> > #else
> > #define printk_debug(xxx...) do { } while (0)
> > #define printk_info(xxx...) do { } while (0)
> 
> That might make a lot of sense. The macros in question would need a bit
> of hand checking for side effects in calls but yes this is the kind of
> thing that can be good

You can write the macros so the side effects are still executed if you
prefer.  Untested:

#define printk_debug(xxx...) do { (void) (xxx ## , 0); } while (0)

-- Jamie

