Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSE2M4z>; Wed, 29 May 2002 08:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315239AbSE2M4y>; Wed, 29 May 2002 08:56:54 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:43340 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S315218AbSE2M4x>; Wed, 29 May 2002 08:56:53 -0400
Date: Wed, 29 May 2002 23:40:40 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: odd timer bug, similar to VIA 686a symptoms
In-Reply-To: <20020529140515.A8522@ucw.cz>
Message-ID: <Pine.LNX.4.05.10205292319090.3388-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2002, Vojtech Pavlik wrote:

[...]
> On Wed, May 29, 2002 at 01:46:27PM +0100, Alan Cox wrote:
[...]
> > Neptune chipsets at least had latching bugs on timer reads. What chipset
> > is the laptop ?
> 
> This is unlikely to be the latching bug - note the values are near to
> 65535 - that means the timer is reprogrammed to count from 0xffff down
> instead from LATCH. That is because of the suspend I presume. What's
> weird is that the VIA fix doesn't program it to the correct value, or
> perhaps is that missing from the patch?

Yes, my version of your patch includes an option to disable the via686a
fix (and this was in effect at the time - I'm still cringing in fear from
nasty FS corruption that ensued after a "probable hardware bug: restoring
chip configuration" message last October :-( - yes it may be unlikely
that it's related, but I don't yet have any other suspects.  FWIW, the
machine also locked up then).

Any suggestions smarter than backing up everything "important" and running
the battery down with the VIA fix enabled?

Thanks,
Neale.

