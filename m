Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317708AbSIOENo>; Sun, 15 Sep 2002 00:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317742AbSIOENo>; Sun, 15 Sep 2002 00:13:44 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:25105
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317708AbSIOENn>; Sun, 15 Sep 2002 00:13:43 -0400
Date: Sat, 14 Sep 2002 21:16:21 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alex Davis <alex14641@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Possible bug and question about ide_notify_reboot in 2.4.19
In-Reply-To: <20020914214152.15900.qmail@web40512.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10209141548370.6925-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Sep 2002, Alex Davis wrote:

> --- Andre Hedrick <andre@linux-ide.org> wrote:
> > 
> > Hi Alex,
> > 
> > We (T13 Standards) only recently required (shall) all non-packet device to
> > support flush cache.  No where does it state that a device supporting PM
> > for a standby (shall), the key word here is "shall", issue a flush-cache.
> I am assuming that a hard drive is a non-packet device. Let me make sure I'm

Today, yes ...  In the past no.
There are a handfull of these strange beasts which still exists.

> interpreting this correctly: older ( and some current ) drives may flush cache
> on standby/sleep; current and future drives may not. In addition, older drives

It means there are not rules (rules is a loose term) for how to do this in
the standard.

> may not support the flush cache command.

There is supported v/s enabled, and these  can be optional.
Optional == (Mandatory Optional) because nobody wants to not have the
feature ready or they will miss the sale.

> > I will not break support for older hardware, on a whim.
> Not my intention.

Cool.

> > You said you can make a patch, please do so and apply it to your tree.
> > Now, if you want the option, submit the patch for review.  For two or
> > three days there has been no patch to test.
> Still testing locally. I also want to fix the code so that the flush is
> done before the standby.

Wait, how did the order go south?

> > 
> > To be absolutely honest, I really do not like to give options in the
> > kernel-config build which can cause backwards compatablity problems.
> This wouldn't be a config option. You would have to modify ide.c by
> hand to disable standby.

So a manual config option?  That is more reasonable and not doable by
accident.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

