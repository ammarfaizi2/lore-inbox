Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317432AbSFMDb3>; Wed, 12 Jun 2002 23:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317433AbSFMDb3>; Wed, 12 Jun 2002 23:31:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:46047 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317432AbSFMDb2>;
	Wed, 12 Jun 2002 23:31:28 -0400
Date: Wed, 12 Jun 2002 23:31:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Kurt Wall <kwall@kurtwerks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <20020612222540.23e38e0a.kwall@kurtwerks.com>
Message-ID: <Pine.GSO.4.21.0206122323060.16357-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jun 2002, Kurt Wall wrote:

> Quite so: the kernel sees .desktop and sees a plain old file; Windows sees
> .lnk and does something that resembles interpreting them. Again, my point
> was that .desktop files do not map cleanly .lnk files.

"Windows" as in...?  AFAICS Windows _kernel_ sees .lnk and sees a plain old
file.  Some part of godforsaken mess known as GNOME asks kernel to read
from plain old file and interprets the contents returned by read().  Some
part of godforsaken mess known as Windows userland asks kernel to read from
plain old file and interprets the contents returned by read().  In either
case interpretation is done in userland.

I don't see any reason to put that stuff into the kernel - no more than
putting ~-expansion or globbing in there.

