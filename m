Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSE2M7V>; Wed, 29 May 2002 08:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315235AbSE2M7U>; Wed, 29 May 2002 08:59:20 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:50823 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315214AbSE2M7T>;
	Wed, 29 May 2002 08:59:19 -0400
Date: Wed, 29 May 2002 14:58:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Neale Banks <neale@lowendale.com.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: odd timer bug, similar to VIA 686a symptoms
Message-ID: <20020529145857.A9813@ucw.cz>
In-Reply-To: <20020529140515.A8522@ucw.cz> <Pine.LNX.4.05.10205292319090.3388-100000@marina.lowendale.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 11:40:40PM +1000, Neale Banks wrote:
> On Wed, 29 May 2002, Vojtech Pavlik wrote:
> 
> [...]
> > On Wed, May 29, 2002 at 01:46:27PM +0100, Alan Cox wrote:
> [...]
> > > Neptune chipsets at least had latching bugs on timer reads. What chipset
> > > is the laptop ?
> > 
> > This is unlikely to be the latching bug - note the values are near to
> > 65535 - that means the timer is reprogrammed to count from 0xffff down
> > instead from LATCH. That is because of the suspend I presume. What's
> > weird is that the VIA fix doesn't program it to the correct value, or
> > perhaps is that missing from the patch?
> 
> Yes, my version of your patch includes an option to disable the via686a
> fix (and this was in effect at the time - I'm still cringing in fear from
> nasty FS corruption that ensued after a "probable hardware bug: restoring
> chip configuration" message last October :-( - yes it may be unlikely
> that it's related, but I don't yet have any other suspects.  FWIW, the
> machine also locked up then).

It shouldn't be able to do anything like that ...

> Any suggestions smarter than backing up everything "important" and running
> the battery down with the VIA fix enabled?

Nope. ;)

-- 
Vojtech Pavlik
SuSE Labs
