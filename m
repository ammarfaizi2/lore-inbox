Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVBBDrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVBBDrF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVBBDrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:47:04 -0500
Received: from gate.crashing.org ([63.228.1.57]:25529 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262259AbVBBDpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:45:41 -0500
Subject: Re: Fw: Re: 2.6.11-rc2-mm2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joseph Fannin <jfannin@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Sean Neakums <sneakums@zork.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050202034205.GA27123@caphernaum.rivenstone.net>
References: <20050129163117.1626d404.akpm@osdl.org>
	 <1107155510.5905.2.camel@gaston>
	 <20050131112106.GA3494@samarkand.rivenstone.net>
	 <1107213513.5963.26.camel@gaston>
	 <20050202034205.GA27123@caphernaum.rivenstone.net>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 14:45:19 +1100
Message-Id: <1107315919.5624.61.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 22:42 -0500, Joseph Fannin wrote:
> On Tue, Feb 01, 2005 at 10:18:33AM +1100, Benjamin Herrenschmidt wrote:
> > On Mon, 2005-01-31 at 06:21 -0500, Joseph Fannin wrote:
> > 
> > >     I'm getting a blank screen with radeonfb on two boxes here as
> > > well. One is a beige g3, the other is i386; both have PCI Radeon 7000s
> > > with radeonfb non-modular. 
> > > 
> > >     On the PC I could see the earliest kernel messages in VGA text
> > > mode before radeonfb took over and the screen went blank -- no
> > > penguin, and the logo is enabled.  Booting with radeonfb:off seemed to
> > > work except for the module problem in -rc2-mm2:
> > > 
> > >     On the ppc box I tried both -rc2-mm1 and -rc2-mm2.  Both hung and
> > > then rebooted after 3 minutes, so it seems to be panicing somewhere.
> > > I backed the massive-radeonfb patch out of -mm2 and radeonfb worked,
> > > so I got as far as the module thing again.
> 
> > 
> > Hrm... indeed, there seem to be a problem, though I can't tell for sure
> > what's up now, it just works on all the configs I had a chance to test
> > on. Can you try to boot your G3 with serial console so you can see the
> > panic message if any ?
> 
>     Okay, I managed to get this Oops message on ppc, when modprobing a
> modular radeonfb. I got a similar backtrace on i386 too (lost it though).

Interesting ... I'll have a look. Seems like some generic change is
causing it.

Ben.


