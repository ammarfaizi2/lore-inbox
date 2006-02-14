Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030511AbWBNIRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511AbWBNIRa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWBNIRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:17:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24293 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030511AbWBNIR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:17:29 -0500
Date: Tue, 14 Feb 2006 00:16:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: mail@joachim-breitner.de, linux-kernel@vger.kernel.org,
       linux@dominikbrodowski.net
Subject: Re: [PATCH] [CM4000,CM4040] Add device class bits to enable udev
 device creation
Message-Id: <20060214001619.391fa4b4.akpm@osdl.org>
In-Reply-To: <20060214080542.GB4605@sunbeam.de.gnumonks.org>
References: <1138536696.6509.9.camel@otto.ehbuehl.net>
	<1138541796.6395.8.camel@otto.ehbuehl.net>
	<20060131101046.GS4603@sunbeam.de.gnumonks.org>
	<20060131180927.6843c775.akpm@osdl.org>
	<20060214080542.GB4605@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte <laforge@gnumonks.org> wrote:
>
> On Tue, Jan 31, 2006 at 06:09:27PM -0800, Andrew Morton wrote:
> > Harald Welte <laforge@gnumonks.org> wrote:
> > >
> > > Please apply this fix to the cm4000/4040 drivers, thanks!
> > > 
> > >  [CM4000,CM4040] Add device class bits to enable udev device creation
> > > 
> > >  Using this patch, Omnikey CardMan 4000 and 4040 devices automatically
> > >  get their device nodes created by udev.
> > 
> > Dominik has made quite widespread changes to these drivers - enough that
> > I'm not confident to fix the rejects, make it compile and hope that it
> > still works.
> 
> sorry for that.  I honestly don't have the time to track two trees, and
> I do all my development work against Linus' main tree, therefore my
> patches are against that tree, too.

Dominik maintains the pcmcia development tree, and these are
pcmcia drivers...

> > So can you please sort things out with Dominik?  I guess a tested patch
> > against -mm4 would be ideal.
> 
> The question is: Why wouldn't my patch directly go mainline but rather
> via -mm?  It is a very special-purpose device, the number of users are
> small, it clearly fixes the bug that no device nodes are created, and
> the fix came from the original maintainer.

pcmcia patches should preferably go via the pcmcia development tree, and
get integrated and reviewed by the maintainer and all that good stuff.

So it wouldn't go via -mm at all - pcmcia only goes into -mm for testing.


The more specific point is that your patch conflicted with Dominik's
current development tree in a big way.   That needs to get sorted out.
