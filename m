Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTGAJNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 05:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTGAJNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 05:13:30 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:45187 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261454AbTGAJN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 05:13:29 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] patch-O1int-0306302317 for 2.5.73 interactivity
Date: Tue, 1 Jul 2003 19:31:24 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200307010029.19423.kernel@kolivas.org> <200307010754.35804.kernel@kolivas.org> <1057049984.587.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1057049984.587.1.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307011931.24586.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jul 2003 18:59, Felipe Alfaro Solana wrote:
> On Mon, 2003-06-30 at 23:54, Con Kolivas wrote:
> > On Tue, 1 Jul 2003 07:21, Felipe Alfaro Solana wrote:
> > > On Mon, 2003-06-30 at 16:29, Con Kolivas wrote:
> > > > Buried deep in another mail thread was the latest implementation of
> > > > my O1int patch so I've brought it to the surface to make it clear
> > > > this one is significantly different from past iterations.
> > > >
> > > > Summary:
> > > > Decreases audio skipping with loads.
> > > > Smooths out X performance with load.
> > > >
> > > > I've also made it available here:
> > > > http://kernel.kolivas.org/2.5
> > > >
> > > > along with a patch called granularity that is a modified version of
> > > > Ingo's timeslice_granularity patch. It is no longer necessary and may
> > > > slightly decrease throughput in non-desktop settings but put on top
> > > > of my O1int patch makes X even smoother.
> > >
> > > Damn! XMMS audio skips are back... To reproduce them, I start up my KDE
> > > session, launch Konqueror, launch XMMS and make it play sound. Then, I
> > > drag the Konqueror window like crazy over my desktop and XMMS skips,
> > > altough not too much.
> > >
> > > The previous version of this patch is the one that worked best for me.
> >
> > A little bit more of this.. a little bit less of that... Use 100 or
> > 1000Hz for this one? And did you notice any change in X?
>
> I'm using 1000HZ. With respect to X, I haven't noticed any major
> difference. Should I? I haven't tested it under very heavy loads, but
> under normal workloads, it behaves a little better than its predecesors.

I'd say it would depend on the graphic card. On a sis630 even with a p3 1133 
it is embarassingly jerky under even the slightest of loads without my patch. 
However, it is as good now without the granularity patch as earlier with the 
granularity.

Con

