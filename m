Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbRBPJlT>; Fri, 16 Feb 2001 04:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbRBPJlJ>; Fri, 16 Feb 2001 04:41:09 -0500
Received: from 4dyn188.delft.casema.net ([195.96.105.188]:64785 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129131AbRBPJk4>; Fri, 16 Feb 2001 04:40:56 -0500
Message-Id: <200102160940.KAA02620@cave.bitwizard.nl>
Subject: Re: 8139 full duplex?
In-Reply-To: <Pine.SOL.4.21.0102160930050.26108-100000@orange.csi.cam.ac.uk>
 from James Sutherland at "Feb 16, 2001 09:32:34 am"
To: James Sutherland <jas88@cam.ac.uk>
Date: Fri, 16 Feb 2001 10:40:53 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:
> > That would explain me seeing way too many collisions on that old hub
> > (which obviously doesn't support full-duplex).
> 
> No, it would just prevent your card working. Large numbers of collisions
> are normal during fast transfers across a hub.

Why would it completely "not work"? 

As long as the host doesn't have something to send while a recieve is
in progress, everything should work. A friend reports that he spent
lots of time trying to debug a network where "too many" collisions
were happening. Turns out one card was in full-duplex, while the other
side wasn't.

I benchmarked my old network at 10-12 seconds for a 100Mb
transfer. That sounds indeed as if there isn't a whole lot of
collisions happening. And I can immagine that the acks run into the
next data-packet all the time, so that performance would indeed be
very bad if the card was misconfigured. On the other hand I had one
machine that was taking 180 seconds for the 100Mb transfer.

Anyway, I remember fiddling with the eexpress 100 driver, and there
the driver was involved in switching the speeds, and doing some
management of the switchover of full-duplex/half-duplex. I'd expect
some message from the driver if it saw such a change. 

But you're saying that the 8139 chip does it internally, and fully  
automatically? Ok. Good. 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
