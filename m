Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161232AbVKSDkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbVKSDkh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 22:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161239AbVKSDkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 22:40:37 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:54920
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1161232AbVKSDkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 22:40:37 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 18 Nov 2005 21:38:29 -0600
User-Agent: KMail/1.8
Cc: Adrian Bunk <bunk@stusta.de>, Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>,
       linux-kernel@vger.kernel.org
References: <1132020468.27215.25.camel@mindpipe> <200511182043.34655.rob@landley.net> <1132370572.6874.56.camel@mindpipe>
In-Reply-To: <1132370572.6874.56.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511182138.30017.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 November 2005 21:22, Lee Revell wrote:
> On Fri, 2005-11-18 at 20:43 -0600, Rob Landley wrote:
> > On Friday 18 November 2005 20:02, Lee Revell wrote:
> > > > Speaking of which: I've been playing with qemu recently, and the
> > > > sound card it emulates is a sound blaster 16.  Which only seems to
> > > > have an OSS driver, no ALSA...
> > > >
> > > > This is known?  If so I might take a whack at porting this if I get
> > > > really bored this weekend...
> > >
> > > There already is an ALSA driver, check out sound/isa/sb/sb16.c:
> >
> > Ok, so where is the config option?
>
> sound/isa/Kconfig:

Ah, I see.

that entire menu doesn't show up unless you've selected ISA under the bus menu 
(which I thought means we probe for ISA slots, not that we don't support ISA 
devices built onto the motherboard).

Meanwhile, the OSS SB16 driver shows up just fine with ISA disabled in the bus 
menu...

Rob
