Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316192AbSFPL45>; Sun, 16 Jun 2002 07:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316195AbSFPL44>; Sun, 16 Jun 2002 07:56:56 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:42645 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316192AbSFPL4z>;
	Sun, 16 Jun 2002 07:56:55 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15628.18921.395095.652968@argo.ozlabs.ibm.com>
Date: Sun, 16 Jun 2002 18:18:49 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: Cardbus
In-Reply-To: <Pine.LNX.4.44.0206151453360.3479-100000@home.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> It has nothing to do with "buggy" PCI-PCI bridges, and everything to do
> with the fact that a lot of bridges seem to extend on the official PCI
> bridge interface in various ways. In particular, it seems to be fairly
> common to have the _real_ bridging information in the chip-specific range
> (PCI config area 0x40+) instead of in the official "2 mem resources, 2 IO
> resources" place.

OK, that makes sense.  (The "buggy" wasn't intended as any kind of
put-down, it was just what I had been told.)

What ends up in the official places?  Zeroes, maybe?

Can we discriminate between these bridges, and bridges which use the
official places but where the firmware has closed an aperture?  I
really would like the code not to assume the bridge is transparent in
the latter case.

Paul.
