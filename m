Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315460AbSEGXzF>; Tue, 7 May 2002 19:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSEGXzE>; Tue, 7 May 2002 19:55:04 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:6413 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315460AbSEGXzE>; Tue, 7 May 2002 19:55:04 -0400
Date: Wed, 8 May 2002 01:54:54 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, benh@kernel.crashing.org,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205071142001.1067-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.21.0205072106480.32715-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 May 2002, Linus Torvalds wrote:

> Also, you obviously haven't thought it through AT ALL. Hint: partitions.
> 
> If you have /dev/hda1, that _cannot_ be a symlink to the physical tree,
> because on a physical level that partition DOES NOT EXIST. It's purely a
> virtual mapping.
> 
> Yet clearly there _is_ a mapping from /dev/hda1 onto the physical device
> in question, and clearly it _is_ a meaninful operation to operate on the
> physical device underlying /dev/hda1.
> 
> So if you want to have a sane interface, you need to have a way to look up
> the physical device that underlies /dev/hda1.
> 
> Yet it clearly cannot be a symlink.
> 
> QED.

Somehow I expect Al to step in with something like:

mount -t partfs /devfs/bus/... /dev/hda

:-)

bye, Roman


