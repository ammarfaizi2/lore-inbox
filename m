Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266211AbUHMRBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266211AbUHMRBN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUHMRBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:01:12 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:41649 "EHLO
	ffke-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S266211AbUHMRBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:01:08 -0400
Date: Fri, 13 Aug 2004 21:12:53 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Cornelia Huck <kernel@cornelia-huck.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let W1 select NET
Message-Id: <20040813211253.051d923b@zanzibar.2ka.mipt.ru>
In-Reply-To: <20040813174522.73221785@gondolin.boeblingen.de.ibm.com>
References: <20040813101717.GS13377@fs.tum.de>
	<Pine.LNX.4.58.0408131231480.20635@scrub.home>
	<20040813105412.GW13377@fs.tum.de>
	<20040813155233.04ccac4a@gondolin.boeblingen.de.ibm.com>
	<1092409800.12729.454.camel@uganda>
	<20040813174522.73221785@gondolin.boeblingen.de.ibm.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004 17:45:22 +0200
Cornelia Huck <kernel@cornelia-huck.de> wrote:

> On Fri, 13 Aug 2004 19:10:00 +0400
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> > It is just not a good example.
> > In other words - it is bad config dependencies.
> > You just caught error.
> > Not very good example with depends:
> > 
> > config A
> > 	depends on B
> > config B
> > 	depends on C
> > config C
> > 	depends on A
> > 
> > Just do not create wrong dependencies - although it sounds like "do 
> > not create deadlocks".
> 
> Hm, none too easy with configurations spread over multiple files :) -
> however, should select really be able to activate an option with unmet
> dependencies?

We have spinlock debugging, probably we need it in config parser too.
I think it is better to fix such bugs( or features), then hide them with
depend/select.
 
> (and iirc, you are warned about circular dependencies?)

I'm sure noone depends on w1 :)
 
> Regards,
> Cornelia


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
