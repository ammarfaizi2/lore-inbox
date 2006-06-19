Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWFSNsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWFSNsL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 09:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWFSNsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 09:48:11 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:10917 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932424AbWFSNsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 09:48:10 -0400
Date: Mon, 19 Jun 2006 15:47:45 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@timesys.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and
 dynamic HZ
In-Reply-To: <20060619125018.GA20549@elte.hu>
Message-ID: <Pine.LNX.4.64.0606191510140.12900@scrub.home>
References: <1150643426.27073.17.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606190144560.17704@scrub.home> <20060619125018.GA20549@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Jun 2006, Ingo Molnar wrote:

> > > Bugreports and suggestions are welcome,
> > 
> > Could you please document the patches? I know it sucks compared to 
> > hacking, but it would make a review a lot simpler.
> 
> yeah, we'll add some description to the patches themselves, but 

The problem is this is not the first time I mentioned this and some 
patches still have no descriptions at all! :-(

> otherwise i'm afraid it will be like with almost all patch submissions 
> on lkml: 99% of the details are in the code and people have to ask 
> specifically if one area or another is unclear :-|

For a lot of things this acceptable, but if patches (e.g. clockevents) add 
new generic infrastructure which effect all archs, they need 
documentation (unless you also provide all the arch specific changes).

> Meanwhile the patch names should provide you with some initial info 
> (also, we reuse GTOD which is documented in -mm) and the splitup is 
> pretty clean too - but in any case please feel free to ask pointed 
> questions! (we happily accept documentation patches as well.)

I can't do this without documentation. Without any information I'm only 
wondering why it has to be this complex.
For example clockevents, I think all the special event handlers are 
overkill, a simple list would do just fine. This way it may also possible 
to treat a clock as virtual interrupt source and we could share code with 
interrupt code and a callback can simply be requested via request_irq().
More information about what this code actually intends to do and what it 
is required to do, would help a great deal to judge alternative solutions, 
but only the author of this code can really provide this information and 
IMO it's really sad that this information is still lacking after being 
requested multiple times.

bye, Roman
