Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753083AbWKGUTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbWKGUTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbWKGUTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:19:54 -0500
Received: from moci.net4u.de ([217.7.64.195]:61920 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1753082AbWKGUTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:19:53 -0500
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 2.6.19-rc <-> ThinkPads, summary
Date: Tue, 7 Nov 2006 21:19:47 +0100
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20061029231358.GI27968@stusta.de> <20061105062330.GT13381@stusta.de> <20061107200646.GD9533@flint.arm.linux.org.uk>
In-Reply-To: <20061107200646.GD9533@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611072119.49397.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 November 2006 21:06, Russell King wrote:
> On Sun, Nov 05, 2006 at 07:23:30AM +0100, Adrian Bunk wrote:
> > On Sat, Nov 04, 2006 at 02:04:40PM +0000, Russell King wrote:
> > > On Sat, Nov 04, 2006 at 04:49:07AM +0100, Adrian Bunk wrote:
> > > > As far as I can see, the 2.6.19-rc ThinkPad situation is still
> > > > confusing and we don't even know how many different bugs we are
> > > > chasing...
> > >
> > > Why am I copied on this?  Nothing jumps out as being in any area of
> > > my interest (which today is limited to ARM architecture only.)
> >
> > Ernst bisected his problem to your
> > commit 1fbbac4bcb03033d325c71fc7273aa0b9c1d9a03
> > ("serial_cs: convert multi-port table to quirk table").
> >
> > It might be a false positive of the bisecting, but if it turns out to
> > actually cause problems it was your commit.
>
> No idea, sorry.
>
> No information if a serial card was in the PCMCIA slot.  If there's
> no _PCMCIA_ serial card inserted, the code in that patch will not be
> run.
>
> Also no indication if serial_cs was built into Earnst's kernel.  If
> it wasn't, this commit couldn't be the cause.
>
> NeedMoreInformation.

It was a false positive of the bisecting. Now i can reproduce the problem 
without Cardbus/PCMCIA complied in.

So you are now allowed to remove yoursef from the distribution list ;-)

Sorry,

<earny>
