Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265663AbUGCAh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUGCAh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 20:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbUGCAh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 20:37:28 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:54007 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265515AbUGCAhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 20:37:25 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Szakacsits Szabolcs <szaka@sienet.hu>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
Date: Sat, 3 Jul 2004 02:42:38 +0200
User-Agent: KMail/1.5.3
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, bug-parted@gnu.org,
       "K.G." <k_guillaume@libertysurf.fr>,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.21.0407030201520.30622-100000@mlf.linux.rulez.org>
In-Reply-To: <Pine.LNX.4.21.0407030201520.30622-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407030242.39075.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Saturday 03 of July 2004 02:17, Szakacsits Szabolcs wrote:
> On 2 Jul 2004, Patrick J. LoPresti wrote:
> > You will find that the default_* files (i.e., the geometry from the
> > extended INT13 interface) match the values returned by HDIO_GETGEO.
>
> If my memory serves well, you wrote once long ago that your project needs
> the "legacy" value to make things work.
>
> Kernel 2.4 guessed usually legacy, right?

2.4 has drivers/ide/ide-geometry.c which is _exclusively_ for FS use,
IDE driver doesn't need it et all.

> Kernel 2.6 returns extended and it more upsets tools and users with
> trashed partitions.

2.6 returns "raw" IDE CHS not a BIOS translation.

I now think that Andries should have removed HDIO_GETGEO from
IDE driver _completely_ instead of only removing ide-geometry.c.

This can (and should) be still done.

Bartlomiej

