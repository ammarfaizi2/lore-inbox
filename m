Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265681AbUGCA4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUGCA4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 20:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUGCA4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 20:56:23 -0400
Received: from hera.cwi.nl ([192.16.191.8]:54716 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265681AbUGCA4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 20:56:21 -0400
Date: Sat, 3 Jul 2004 02:56:03 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, bug-parted@gnu.org,
       "K.G." <k_guillaume@libertysurf.fr>,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, clausen@gnu.org, buytenh@gnu.org,
       msw@redhat.com
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
Message-ID: <20040703005555.GA20808@apps.cwi.nl>
References: <Pine.LNX.4.21.0407030201520.30622-100000@mlf.linux.rulez.org> <200407030242.39075.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407030242.39075.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(i) Szaka wrote stuff that I interpreted as stating (a) that parted
is seriously broken, and (b) that parted is unmaintained.

Now that I look, I find parted-1.6.11 with a Changelog with last change,
Andrew Clausen 2004-04-25. That is not long ago.

Upon looking further, I find that Andrew Clausen answered on the
parted mailing list on 2004-06-26, not long ago at all.

So, any suggestions (maybe misunderstood by me) about parted being
unmaintained, are completely incorrect.

Concerning the "seriously broken" part, looking at the various available
sources I find that indeed parted has always been seriously broken,
but now Andrew has added stuff in an attempt to fix things.
His added stuff is broken as well, but clearly work is being done,
so instead of shouting on the kernel list it seems more productive
to tell Andrew precisely in what ways his stuff is broken.
I would expect that very soon parted is fine.


(ii) Various people talk about moving disks between machines.
Such people have not understood the main fact here:
the geometry is not a property of the disk but of the BIOS.
It is futile to hope for a construction that will work across
different machines with different BIOSes.


(iii) Bartlomiej writes:

> I now think that Andries should have removed HDIO_GETGEO from
> IDE driver _completely_ instead of only removing ide-geometry.c.

The main reason that it still exists is that it provides some
information not (easily) available elsewhere, namely the starting
offset.

But it is true, returning 0 in all other fields would have made
it more clear that there is no attempt to return the BIOS geometry.
It might be a good idea to do that.


Andries
