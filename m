Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVLTHXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVLTHXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 02:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVLTHXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 02:23:15 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:50572 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750819AbVLTHXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 02:23:14 -0500
From: David Brownell <david-b@pacbell.net>
To: dmitry pervushin <dpervushin@gmail.com>
Subject: Re: [spi-devel-general] Re: [PATCH/RFC] SPI:  async message handing library update
Date: Mon, 19 Dec 2005 23:23:12 -0800
User-Agent: KMail/1.7.1
Cc: Vitaly Wool <vwool@ru.mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Greg KH <greg@kroah.com>, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <200512181059.14301.david-b@pacbell.net> <1135006827.5451.5.camel@fj-laptop>
In-Reply-To: <1135006827.5451.5.camel@fj-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512192323.12910.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 December 2005 7:40 am, dmitry pervushin wrote:
> On Sun, 2005-12-18 at 10:59 -0800, David Brownell wrote:
> >                         chipselect = !t->cs_change;
> >                         if (chipselect);
> >                                 continue;
> > 
> >                         bitbang->chipselect(spi, 0);
> > 
> >                         /* REVISIT do we want the udelay here instead?
> > */
> >                         msleep(1);
> Ohhh. Have you intentionally put the semicolon after "if
> (chipselect)" ? 

Nope.  Good catch ... haven't had a chance to try that yet with that driver;
not all drivers actually need to drop chipselect like that.

Any other comments about that approach to the "let someone else manage the
queue"?  This one's more clearly "implementation utilities" than what you had
seemed to be talking about before, but I think it does address a point where
I think we were agreeing:  it should be easy for people to whip together a
controller driver by providing just some lower level I/O calls.

- Dave

