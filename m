Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131179AbRCGXAT>; Wed, 7 Mar 2001 18:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131186AbRCGXAK>; Wed, 7 Mar 2001 18:00:10 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:40328 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S131179AbRCGW7z>;
	Wed, 7 Mar 2001 17:59:55 -0500
Date: Wed, 7 Mar 2001 23:58:53 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Jens Axboe <axboe@suse.de>
cc: Derek Fawcus <dfawcus@cisco.com>, <linux-kernel@vger.kernel.org>
Subject: Re: can't read DVD (under 2.4.[12] & 2.2.17)
In-Reply-To: <20010307232637.T4653@suse.de>
Message-ID: <Pine.GSO.4.30.0103072355310.6363-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adding the
 cgc.buflen = 20;
line into drivers/cdrom/cdrom.c: dvd_read_physical(...)
solves my problem.

I don't know the difference, but first you mentioned
 cgc.buflen = 16;
so i tried that also, and it worked the same.

I'll write again if i'm having problems. :)
Thanks for the fast patch.

I think you should also check 2.2.

Balazs Pozsar.

On Wed, 7 Mar 2001, Jens Axboe wrote:

> On Wed, Mar 07 2001, Jens Axboe wrote:
> > On Wed, Mar 07 2001, Jens Axboe wrote:
> > > Really good question, I sent this patch in the private thread between
> > > me and Pozsar just in case the length is what the drive complains about.
> >
> > Agrh, that's not all. I will fix this properly, sorry about the noise.
>
> This should work. Pozsar, could you test?
>
> I suspect that Derik is right though, that the 05/24/00 is because
> the dvdinfo is requesting info for a non-existant physical layer.
> I've attempted to quiet that error. You dvdinfo output did look
> very odd.
>
>


