Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAYBnh>; Wed, 24 Jan 2001 20:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135328AbRAYBn2>; Wed, 24 Jan 2001 20:43:28 -0500
Received: from SMTP3.ANDREW.CMU.EDU ([128.2.10.83]:29376 "EHLO
	smtp3.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S129401AbRAYBnU>; Wed, 24 Jan 2001 20:43:20 -0500
Date: Wed, 24 Jan 2001 20:43:19 -0500 (EST)
From: Ari Heitner <aheitner@andrew.cmu.edu>
To: Robert Dale <rdale@digital-mission.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SpeedStep,MHz,BogoMIPS,timing..
In-Reply-To: <Pine.LNX.4.10.10101241903540.20959-100000@vs-01.digipath.net>
Message-ID: <Pine.GSO.4.21L.0101242037210.24591-100000@unix13.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Robert Dale wrote:

> 
> I bought a laptop which uses an Intel CPU with SpeedStep.  Sometimes when
> I boot the kernel recognizes the full MHz, and other times it is much less.
> And of course the BogoMIPS reflect this we well.
> 
> I'm wondering if this has any sort of side-effect on the kernel?  Will
> it disrupt timing loops and such? (I have no idea what I'm talking about ;)

My tp 600X has speedstep as well. When running on ac, the CPU goes full speed
(500MHz). On battery, it goes 1/4 speed (133Mhz) to save juice (must work, i
can run for 7 hours or so with an extra battery in the ultrabay).

linux seems happy with the switch -- the timing loops are close to right
(they're supposed to be order-of-magnitude). obviously if you boot the thing
then plug it in, the exact MHz count in /proc/cpuinfo will be wrong. But it's
never seemed a big idea.

You can get the same effect on an old 386 or 486 which still has a
"Turbo" switch.

> 
> Since Linus works at Transmeta, the kings of power saving, I'm guessing this
> has no effect.
> 

Quite the opposite :) SpeedStep is Intel's rather pathetic answer to Crusoe's
continuously variable powersaving (it's like having a two-speed car in
comparison to a slick continously variable transmission like Honda has been
working on iirc).

I love my 600X, and it blazes on wall power. But it took me 30 minutes t
compile the 8k lines Python-Visual today in class running on battery (g++ 2.95
with the optimizer on ... painful) :)



ari


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
