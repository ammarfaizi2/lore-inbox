Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130063AbQLTACv>; Tue, 19 Dec 2000 19:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130011AbQLTACc>; Tue, 19 Dec 2000 19:02:32 -0500
Received: from smtp4.vol.cz ([195.250.128.84]:62213 "EHLO smtp4.vol.cz")
	by vger.kernel.org with ESMTP id <S129997AbQLTACW>;
	Tue, 19 Dec 2000 19:02:22 -0500
Date: Wed, 20 Dec 2000 00:12:39 +0100
From: Stanislav Brabec <utx@penguin.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Norbert Warmuth <nwarmuth@privat.circular.de>,
        linux-kernel@vger.kernel.org, Tim Gerla <timg@means.net>
Subject: Re: ATAPI: audio CD still stops on >> (fast forward, 2.4.0-test12)
Message-ID: <20001220001239.A8593@utx.cz>
In-Reply-To: <20001216145940.C471@suse.de> <Pine.LNX.4.30.0012181835390.27844-100000@floh.privat.circular.de> <20001218185613.A473@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001218185613.A473@suse.de>; from axboe@suse.de on Mon, Dec 18, 2000 at 06:56:13PM +0100
X-Accept-Language: cs, sk, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote (Mon Dec 18 2000, 18:56:13 GMT):
> On Mon, Dec 18 2000, Norbert Warmuth wrote:
> > On Sat, 16 Dec 2000, Jens Axboe wrote:
> > > > But problem with >> (fast forward playng of short samples) still remains
> > > > on some audio CD's.
> > > > Dec 15 12:17:25 utx kernel:   "47 00 00 00 02 00 3c 3a ff 00 00 00 "
> > > 							   ^^
> > > This is the same case that Miles reported, it's very odd how that 8th
> > > byte gets screwed somehow... But I know about this, I just haven't tracked
> > > this down yet.
> > 
> > At least Stanislav's problem is a userland problem. Sometimes tcd/gtcd
> > (the software Stanislav uses to play CDs) miscalculates frame values. A
> > patch to tcd is available at http://bugs.gnome.org/db/33/33600.html.
> 
> Ah interesting, I _bet_ this is also what everybody else is seeing!
> 

I have tested this patch and there is my result:


Linux kernel patch solves the problem of stopping while playing after
2min 40sec.

gnome-media/tcd/linux-cdrom.c with fix http://bugs.gnome.org/db/33/33600.html
solves the problem of fast-fwd. Even on older kernels ffwd works OK.

Both these were two independent bugs, one in kernel, second in tcd.


I have looked into GNOME CVS and nobody have yet comitted this patch
into CVS, so I am doing it.

Can anybody close the bug in GNOME bug tracking system?


SW:
Linux & (g)tcd

HW:
Cyrix686MX200
ATAPI CD-ROM Mitsumi FX400E (4x speed)
CD Banco de Gaia / Last Train to Lhasa (CD 1) / track 1

-- 
Stanislav Brabec
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
