Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280696AbRKBOER>; Fri, 2 Nov 2001 09:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280697AbRKBOEB>; Fri, 2 Nov 2001 09:04:01 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:4620 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S280696AbRKBODs>; Fri, 2 Nov 2001 09:03:48 -0500
Date: Fri, 2 Nov 2001 15:03:41 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Justin Mierta <Crazed_Cowboy@stones.com>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: ECS k7s5a motherboard doesnt work
In-Reply-To: <3BDDC1D5.2040305@stones.com>
Message-ID: <Pine.LNX.4.33.0111021441550.2070-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Justin Mierta wrote:

> >>9) *new* - the machine is not overheating, the hottest spot is at a cool
> >>57 C
> >>
> >57C is hardly cool, though it shouldn't cause problems.
> >
> last i saw, amd rates these chips at 95C, so 57 is downright chilly :)

yup, but see the cooler man (if it has one). Some of them are rated for
< 70C - above that they stop and melt (in whatever order).

> i'm not sure how to check, and i have a very difficult time even getting
> to a shell in linux, because the damn thing keeps dma erroring about
> reading the cd's.  is there some boot-up settings i can feed it so it
> wont try using dma at all?

see Documentation/kernel-parameters.txt:

ide0=nodma ide1=nodma

should do.

The following is on my K7S5A (no onboard eth):

# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.53 seconds =241.51 MB/sec
 Timing buffered disk reads:  64 MB in  1.82 seconds = 35.16 MB/sec

kernel is 2.2.19-xxx from RH, but when I tested it performed the same
under 2.4.x. Its uptime is only 9 days, but no problems so far. It's
a NFS, samba, SMTP, IMAP, HTTP server, not heavily loaded.

> >>at this point, i'm tending to think that there's several versions of
> >>sis735 floating around (similar to the maneuver that ensoniq pulled with
> >>their sound cards) -- possibly even within the revisions of the k7s5a
> >>motherboard itself.

Mine doesn't have an eth on board. Have you tried and disabled it?

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

