Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262278AbRENKGk>; Mon, 14 May 2001 06:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262310AbRENKGa>; Mon, 14 May 2001 06:06:30 -0400
Received: from mean.netppl.fi ([195.242.208.16]:33796 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S262278AbRENKGP>;
	Mon, 14 May 2001 06:06:15 -0400
Date: Mon, 14 May 2001 13:06:12 +0300
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: 3c590 vs. tulip
Message-ID: <20010514130612.A32567@netppl.fi>
In-Reply-To: <OE73aZbF27y4RbrxUrO000014d0@hotmail.com> <20010511155641.A11827@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <20010511155641.A11827@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 03:56:41PM +0200, Andi Kleen wrote:
> On Fri, May 11, 2001 at 09:27:29AM -0400, Dan Mann wrote:
> > I was just wondering if anybody had an idea which nic card might be a better
> > choice for me; I have a pci 3c590 and a pci smc that uses the tulip driver.
> > I don't have the card number for the smc with me handy, however I know both
> > cards were manufactured in 1995.  Is either card/driver a better choice for
> > a mildly used file server (I am running 2.4.4 Linus)?
> 
> As of 2.4.4 newer 3c90x (I guess you mean that, 3c59x should be mostly
> extinct now) are a better choice because they support zero copy TX and 
> hardware checksumming while tulip does not.
>From what I remember, 3c590 was a horribly buggy card that sometimes
broke even in workstation use (possibly fixed by driver updates more
recently). 3c905B and later are fine, I'm not sure if the original
905 had any bad issues. The original ones definately won't do zero-copy.

The tulips from that era work pretty reliably. Some of the older ones
just won't do autonegotiation (I've seen this with an old 
SMC with both 10/100baseTX and 9-pin "for use with token ring cabling"
connectors). Forcing the link speed works just fine, though.

-- 
Pekka Pietikainen



