Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264279AbUDTWKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbUDTWKB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbUDTWJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:09:46 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:3307 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264548AbUDTVWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 17:22:39 -0400
Subject: Re: Failing back to INSANE timesource :) Time stopped today.
From: john stultz <johnstul@us.ibm.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Niclas Gustafsson <niclas.gustafsson@codesense.com>,
       lkml <linux-kernel@vger.kernel.org>, Patricia Gaughen <gone@us.ibm.com>
In-Reply-To: <Pine.LNX.4.55.0404201431360.28193@jurand.ds.pg.gda.pl>
References: <1081416100.6425.45.camel@gmg.codesense.com>
	 <1081465114.4705.4.camel@cog.beaverton.ibm.com>
	 <1081932857.17234.37.camel@gmg.codesense.com>
	 <Pine.LNX.4.55.0404151633100.17365@jurand.ds.pg.gda.pl>
	 <1082048278.17234.144.camel@gmg.codesense.com>
	 <1082452873.20179.34.camel@gmg.codesense.com>
	 <Pine.LNX.4.55.0404201431360.28193@jurand.ds.pg.gda.pl>
Content-Type: text/plain
Message-Id: <1082495923.10026.36.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Apr 2004 14:18:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-20 at 05:40, Maciej W. Rozycki wrote:
> On Tue, 20 Apr 2004, Niclas Gustafsson wrote:
> 
> > I've now been running the system since last week, about 6 days now with
> > sometimes quite high load, both in regard to CPU usage and network
> > traffic.
> > And it seems to be running just fine with the patch from Maciej.
> 
>  I'm glad to read this.

It appears to be working here in our labs as well.


> > I've got a couple of questions, 
> > 
> > When was this bug introduced? Was it 2.6.1 ( or rather somewhere in
> > 2.5)? Or was it already present in 2.4?
> 
>  Well, the bug has been introduced by IBM in their firmware (SMM code).  
> ;-)  The patch only works it around.  Functionally the changed code is the
> same for your configuration.
> 
>  If you are asking about the problematic code, then it's there since
> 2.3.x, so it's in 2.4, too.  It's a part of the NMI watchdog support,
> though it's used for ordinary timer interrupts for certain systems as
> well.

Are you saying that 2.4 will exhibit this problem as well, or that 2.4
already has an equivalent workaround?


> > When will this patch be merged into the 2.6-tree?  I don't have to
> > stress the impact of this problem on IBM servers as they are rendered
> > quite useless.
> 
>  Apparently there are problems with the workaround on certain AMD
> Athlon-based systems.  I suppose they need to be resolved somehow first.

Can you point me to any threads on this issue. I'd like to do what I can
to help get this workaround in.

> > Which other IBM models are affected? Can I run 2.6.5 on my 345:s or
> > 335:s?  Do they use the same buggy SMM firmware?
> 
>  Ask IBM.  The reason is an incorrect handling of PIC (8259A) state
> saving/restoration.

I'm following up w/ our hardware group about this issue.

Thanks so much for the help!
-john

