Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129219AbRBBGnd>; Fri, 2 Feb 2001 01:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBBGnY>; Fri, 2 Feb 2001 01:43:24 -0500
Received: from venus.illtel.denver.co.us ([64.22.49.69]:4104 "EHLO
	mercury.illtel.denver.co.us") by vger.kernel.org with ESMTP
	id <S129219AbRBBGnM>; Fri, 2 Feb 2001 01:43:12 -0500
Date: Thu, 1 Feb 2001 22:43:54 -0800 (PST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
To: Joe deBlaquiere <jadb@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Serial device with very large buffer
In-Reply-To: <3A7A4992.5070303@redhat.com>
Message-ID: <Pine.LNX.4.10.10102012240170.991-100000@mercury>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Joe deBlaquiere wrote:

> >> 	I'm a little confused here... why are we overrunning? This thing is 
> >> running externally at 19200 at best, even if it does all come in as a 
> >> packet.
> > 
> > 
> >   Different Merlin -- original Merlin is 19200, "Merlin for Ricochet" is
> > 128Kbps (or faster), and uses Metricom/Ricochet network.
> 
> so can you still limit the mru?

  No. And even if I could, there is no guarantee that it won't fill the
whole buffer anyway by attaching head of the second packet after the tail
of the first one -- this thing treats interface as asynchronous and
ignores PPP packets boundaries.

-- 
Alex

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
