Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130380AbQLKUeN>; Mon, 11 Dec 2000 15:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130440AbQLKUeD>; Mon, 11 Dec 2000 15:34:03 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:45852 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130383AbQLKUdy>; Mon, 11 Dec 2000 15:33:54 -0500
Date: Mon, 11 Dec 2000 15:03:23 -0500
From: Matthew Galgoci <mgalgoci@redhat.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: cardbus pirq conflict
Message-ID: <20001211150323.C16986@redhat.com>
Reply-To: mgalgoci@redhat.com
In-Reply-To: <20001208130148.B19712@redhat.com> <3A3191FE.83C14585@uow.edu.au> <20001211124816.L3738@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001211124816.L3738@redhat.com>; from mgalgoci@redhat.com on Mon, Dec 11, 2000 at 12:48:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I goofed in the report below. I had switched to the i82365
pcmcia driver to see if it was affected by the pirq problems
the night before, and forgotten to switch back to the yenta_socket.

Switching back to the yenta_socket, plus andrewm's keventd patch
allowed the collection of cardbus pcmcia cards to work. Apm suspend
and shutting down the machine do not cause an Oops either.

I do however still recieve a nasty message about a pirq table
conflict, but it does not seem to affect the operation of the 
card.

The pirq conflict message seems a little harsh though, and perhaps 
unnecessary.

Thank you all.

Cheer!

--Matt Galgoci


On Mon, Dec 11, 2000 at 12:48:16PM -0500, Matthew Galgoci wrote:
> 
> Hello,
> 
> I tried this patch against test12-pre7, and all that I get is 
> "cs: socket c7604800 timed out during reset. Try increasing
> setup_delay." 
> 
> Performing cardctl reset yields the same message. I think that 
> cardctl reset takes away the possibility that increasing
> setup_delay would actually help.
> 
> The Oops on shutdown no longer occurs, so I believe that you
> have fixed the race contition you descdibed. The Oops was
> also occuring on apm resume, but that has ceased as well.
> 
> I will try testing some other cardbus cards later today, and will
> also experiment with an unpatch test12-pre8
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
