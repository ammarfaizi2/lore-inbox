Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132752AbQLHV7J>; Fri, 8 Dec 2000 16:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133014AbQLHV67>; Fri, 8 Dec 2000 16:58:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8466 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132752AbQLHV6l>; Fri, 8 Dec 2000 16:58:41 -0500
Date: Fri, 8 Dec 2000 13:27:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: tytso@mit.edu
cc: rgooch@ras.ucalgary.ca, jgarzik@mandrakesoft.mandrakesoft.com,
        dhinds@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: Serial cardbus code.... for testing, please.....
In-Reply-To: <200012081805.eB8I5AT08790@snap.thunk.org>
Message-ID: <Pine.LNX.4.10.10012081319010.11626-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I didn't have time to do more than just quickly apply the patch and leave
in a hurry, but my Vaio certainly recognized the serial port on the combo
cardbus card I have with this patch. Everything looked fine - I got a
message saying it found a 16450 on ttyS4 when I plugged the card in.

Ted, I have the in-kernel pcmcia on both Toves VAIO 505VE, and on both the
VAIO picturebooks I have (Pentium/MMX 266 and crusoe-600), and I saw the
serial chip on the first try with your patch. I'm surprised you seem to
have so many problems. All the thin-and-light VAIO's have very similar
electronics (the big power-VAIO's are different, but you said you had a
505VX, right?).

Why are you using "epic_cb"? That's almost certainly not going to work
with the in-kernel cardbus driver. Use the standard epic100 PCI driver, it
should work directly. No need to mess with any modules, or anything like
that. You don't even need cardmgr - the device just shows up. Same thing
with the serial card - remove all traces of serial_cb.

(Of course, I use tulip instead of epic100, so maybe there's an epic
driver bug, but it's definitely hotplug-aware).

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
