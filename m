Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSHBN5b>; Fri, 2 Aug 2002 09:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSHBN5b>; Fri, 2 Aug 2002 09:57:31 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:51345 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S314829AbSHBN5a>; Fri, 2 Aug 2002 09:57:30 -0400
Date: Fri, 2 Aug 2002 16:00:32 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Nick Orlov <nick.orlov@mail.ru>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <20020802125204.GA4729@nikolas.hn.org>
Message-ID: <Pine.SOL.4.30.0208021557410.3612-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Aug 2002, Nick Orlov wrote:

> On Fri, Aug 02, 2002 at 01:27:25PM +0100, Alan Cox wrote:
> > On Fri, 2002-08-02 at 02:47, Nick Orlov wrote:
> > >
> > > > <marcelo@plucky.distro.conectiva> (02/07/19 1.646)
> > > > 	Fix wrong #ifdef in ide-pci.c: Was causing problems with FastTrak
> > >
> > > Because of this fix my Promise 20265 became ide0 instead of ide2.
> > > Is there any reason to mark pdc20265 as ON_BOARD controller?
> >
> > How about because it can be and it should be checked. I don't know what
> > is going on with the ifdef in your case to cause this but its not as
> > simple as it seems
>
> Why pdc20265 is so special ? All other Promises marked as OFF_BOARD...
>
> And what determines how id will be assigned to controllers if both of
> them are ON_BOARD ?

AFAIR problem is that some vendors included onboard 20265 as primary
device (playing tricks for that) and to be consistent we have to treat it as
onboard, we have right now no way to check if it is on or offboard.
EDD support will probably help here.

Regards
--
Bartlomiej

> --
> With best wishes,
> 	Nick Orlov.

