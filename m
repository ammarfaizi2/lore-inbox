Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVIMJrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVIMJrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 05:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVIMJrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 05:47:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:4031 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932473AbVIMJrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 05:47:47 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [1/3] Add 4GB DMA32 zone
Date: Tue, 13 Sep 2005 11:47:41 +0200
User-Agent: KMail/1.8
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <43246267.mailL4R11PXCB@suse.de> <200509121447.00373.ak@suse.de> <Pine.LNX.4.61.0509131107360.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0509131107360.3728@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509131147.42140.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 September 2005 11:15, Roman Zippel wrote:
> Hi,
>
> On Mon, 12 Sep 2005, Andi Kleen wrote:
> > > On Sun, 11 Sep 2005, Andi Kleen wrote:
> > > > -#define MAX_NR_ZONES		3	/* Sync this with ZONES_SHIFT */
> > > > -#define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
> > > > +#define MAX_NR_ZONES		4	/* Sync this with ZONES_SHIFT */
> > > > +#define ZONES_SHIFT		3	/* ceil(log2(MAX_NR_ZONES)) */
> > >
> > > Why needs ZONES_SHIFT to be increased?
> > >
> > > > -#define FLAGS_RESERVED		8
> > > > +#define FLAGS_RESERVED		9
> > >
> > > I would prefer to keep this at 8.
> >
> > sparsemem needs these two.
>
> Did I somehow offend you, that I don't deserve an answer?

Well, your aggressive tone definitely doesn't encourage speedy answers.

> The reason for my question is rather simple (and I thought obvious), the
> four zone types fit into two bits, so what is sparsemem doing with this
> extra bit?

iirc it was a patch that came in over Andrew. I can't find the email anymore
unfortunately. The argument looked plausible and I think it fixed
a boot problem for the submitter on some arch (probably IA64, on x86-64 it 
worked fine without it, but I've never tried sparsemem and the code was 
originally written before sparsemem). Andrew do you still have the patch with 
the description? It must have been between 2.6.13mm1 and  2.6.13mm2.

You're right that four zones should in theory fit into 2 bits, so I'm
also not sure why it was needed.

-Andi

